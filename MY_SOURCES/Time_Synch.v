`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:34:21 04/20/2012 
// Design Name: 
// Module Name:    Time_Synch 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Time_Synch
	#(	parameter 	FBIT 		= 6,	//number of R Metric's frational bits
		parameter 	FBIT2 	= 7,	//number of P Metric's frational bits
		parameter	SYN_VAL 	= 6'd54)
	(
	input 			clk, rst, syn_run,
	input				metric_val,
	input  [21:0]	P_Metric_Re,P_Metric_Im,	//in format 7.15
	input  [4+FBIT:0]	R_Metric,     // rounding R Metric in format 5.FBIT
	input  [3:0]	SNR,
	
	output 				syn_done,
	output reg [31:0]	FRE_O,
	output 				FRE_O_val
   );

reg [16:0] Synch_thres_coeff 	 [15:0];			// threshold in format 2.15
initial $readmemh("./MY_SOURCES/RTL_Synch_thres_coeff_q05.txt", Synch_thres_coeff);

wire ena = metric_val & syn_run;

wire [16:0] thres_coeff = Synch_thres_coeff[SNR];
wire [33:0] mult_thres_out;  // output of multiplying to threshold in format 9.25
mult thres_mult_ins (
   .clk(clk), 									// input clk 
	.sclr((rst|syn_done)), 								// input sclr
	.ce(ena), 									// input ce  	
   //.a(R_Metric[4+FBIT:FBIT-12]), 		// input [16 : 0] a in format 5.12  reduce bits in case FBIT > 12
	.a({R_Metric, {{(12-FBIT){1'b0}}}}), 		// input [16 : 0] a in format 5.12
   .b(thres_coeff), 			// input [16 : 0] b in format 2.15
   .p(mult_thres_out) 		// output [33 : 0] p		in format 7.27
);
wire [22:0] R_Metric_thr = {1'b0, mult_thres_out[33:12]};	// R metric multipies threshold in format 8.15

wire [7+FBIT2:0] P_Metric_mag;			// rounding P_Metric_mag in format 8.FBIT2
wire 			P_Metric_mag_val;

wire [6+FBIT2:0] P_Re, P_Im;		// rounding P_Metric in format 7.FBIT2
assign P_Re = P_Metric_Re[21:15-FBIT2];
assign P_Im = P_Metric_Im[21:15-FBIT2];
Appr_Mag #(.WIDTH(7+FBIT2)) P_Metic_mag_ins(
	.clk(clk),  .rst((rst | syn_done)), .ena(ena),
	.real_in(P_Re), 
	.imag_in(P_Im),
	.mag(P_Metric_mag),		// magnitute of P metric in format 8.FBIT2
	.val(P_Metric_mag_val)	
    );
	 
wire [5:0] R_Metric_d64;	//reduced bit R_metric delay 64 in format 5.1
Delay2n #(.WIDTH(6), .D(64), .B(6)) RX_delay64(
	.clk(clk), 	.rst((rst|syn_done)), .ena(ena),
	.dat_in(R_Metric[4+FBIT:FBIT-1]),	
	.dat_out(R_Metric_d64)
	); 

reg e_dec;
always@(posedge clk) 
begin
	if (rst)	e_dec <= 1'b0;
	else if (~syn_run) e_dec <= 1'b0; 
	else if (|(R_Metric_thr[21:16])) e_dec <= 1'b1;
end

wire [7+FBIT2:0] R_Metric_Cmp = R_Metric_thr[22:15-FBIT2];
wire cmp_metric;
reg [3:0] cmp_cnt;
always@(posedge clk) 
begin
	if (rst)	cmp_cnt <= 4'b0000;
	else if (P_Metric_mag_val & (P_Metric_mag > R_Metric_Cmp)&(~cmp_metric)&(e_dec)) cmp_cnt <= cmp_cnt + 1'b1;
	else if (~syn_run) cmp_cnt <= 4'b0000; 
end
assign cmp_metric = (cmp_cnt[3])?1'b1:1'b0;	
	
reg [6:0] find_peak_cnt;
wire 		 find_peak_ena = (~find_peak_cnt[6]) & cmp_metric & syn_run;
always@(posedge clk) 
begin
	if (rst)	find_peak_cnt = 7'b1;
	else if (~syn_run) find_peak_cnt = 7'b1;
	else if (find_peak_ena) find_peak_cnt = find_peak_cnt + 1'b1;	
end

reg find_peak_ena_pp;
always@(posedge clk)
begin
	if(rst)	find_peak_ena_pp	<= 1'b0;
	else 		find_peak_ena_pp	<= find_peak_ena;
	
end

//assign FRE_O_val = (find_peak_ena_pp & (~find_peak_ena));
assign FRE_O_val = (find_peak_cnt == 7'd32);

wire [5+FBIT:0] add_metric = R_Metric + {R_Metric_d64,{(FBIT-1){1'b0}}};

reg 			peak_dec;
reg  [5+FBIT:0] peak_add_metric;

always@(posedge clk) 
begin
	if (rst)	begin
			FRE_O 	<= 32'd0;
			peak_dec <= 1'b0;
			peak_add_metric <= 23'd0;
		end
	else if (find_peak_ena) begin	
		if (peak_add_metric < add_metric) begin 
				FRE_O 	<= {P_Metric_Im[21:6],P_Metric_Re[21:6]};
				peak_add_metric <= add_metric;
				peak_dec <= 1'b1;
				end
		else	peak_dec <= 1'b0;
		end
	else begin
		peak_dec <= 1'b0;
		peak_add_metric <= 23'd0;
	end		
end 

reg [5:0] syn_cnt;
wire 		 syn_cnt_run = ~(syn_cnt == 6'd0);
always@(posedge clk) 
begin
	if (rst)												syn_cnt <= 6'd0;	
	if (~ syn_run) 									syn_cnt <= 6'd0;	
	else if (find_peak_ena & (~syn_cnt_run)) 	syn_cnt <= 6'b1;
	else if (syn_cnt == SYN_VAL) 					syn_cnt <= 6'b0;
	else if (syn_cnt_run & peak_dec) 			syn_cnt <= 6'b1;
	else if (syn_cnt_run) 							syn_cnt <= syn_cnt + 1'b1;
	
end 

assign syn_done = (syn_cnt == SYN_VAL) & (~find_peak_ena);
endmodule
