`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:24:15 03/29/2012 
// Design Name: 
// Module Name:    Synch 
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
module Synch(	
	input 			CLK_I, RST_I,
	input [31:0] 	DAT_I,				//DAT_I[31:16]:imaginary part; DAT_I[15:0]: real part; in format Q1.15
	input 			CYC_I, 
	input				STB_I,
	output			ACK_O,
	
	output [31:0]	DAT_O,				//DAT_O[31:16]:imaginary part; DAT_O[15:0]: real part; in format Q1.15
	output 			WE_O, STB_O, CYC_O,
	input				ACK_I,

	input  [3:0]	SNR,				//Signal to Noise Ratio
	output [31:0]	FRE_O,			//FRE_O[31:16]:imaginary part; FRE_O[15:0]: real part; in format Q7.8
	output 			FRE_O_val
   );	 
	
parameter FBIT  =6;	//number of R Metric's frational bits
parameter FBIT2 =7;	//number of P Metric's frational bits	
	
reg  syn_value_rst;
wire time_syn_done;
wire time_syn_run;

reg [15:0] rx_Re, rx_Im;

always @(posedge CLK_I) begin
	if(RST_I) begin
		rx_Re <= 16'd0;
		rx_Im <= 16'd0;
		end
	else if ((CYC_I) & STB_I) begin
		rx_Re <= DAT_I[15:0];
		rx_Im <= DAT_I[31:16];
		end
end
wire 	 iena  = (CYC_I) & STB_I & time_syn_run;

always@(posedge CLK_I)
begin
	if(RST_I)	syn_value_rst	<= 1'b0;
	else 			syn_value_rst	<= time_syn_done;	
end

//================================ Calculate P metric ==============================//
wire [15:0] rx_Im_d64,rx_Re_d64;
Delay2n #(.WIDTH(32), .D(64), .B(6)) RX_delay64(
	.clk(CLK_I), 
	.rst((RST_I | syn_value_rst)), 
	.ena(iena),
	.dat_in({rx_Im,rx_Re}),	
	.dat_out({rx_Im_d64,rx_Re_d64})
);

wire [15:0] rx_Im_conj;
assign rx_Im_conj = (~rx_Im) + 1'b1;

wire [FBIT2:0] ACRMult_Re, ACRMult_Im; 		// in format Q1.FBIT2
wire [79:0] 	CM_out;
wire 				CM_val;

Complex_Multiplier ACR_Mult_ins (
	.aclk(CLK_I), 										// input aclk
	.aresetn(~(RST_I|time_syn_done)), 			// input aresetn
	.s_axis_a_tvalid(iena), 						// input s_axis_a_tvalid
	.s_axis_a_tdata({rx_Im_conj, rx_Re}), 		// input [31 : 0] s_axis_a_tdata
	.s_axis_b_tvalid(iena),							// input s_axis_b_tvalid
	.s_axis_b_tdata({rx_Im_d64,  rx_Re_d64}), // input [31 : 0] s_axis_b_tdata
	.m_axis_dout_tvalid(CM_val), 					// ouput m_axis_dout_tvalid
	.m_axis_dout_tdata(CM_out[79:0])				// ouput [79 : 0] m_axis_dout_tdata: real = [32:0]; image = [79:40];
	); 			
assign ACRMult_Re = CM_out[30:30-FBIT2];				// rounding output in format 1.FBIT2
assign ACRMult_Im = CM_out[70:70-FBIT2];

wire [FBIT2:0] ACRMult_Re_d128, ACRMult_Im_d128;	// in format Q1.FBIT2
Delay2n #(.WIDTH(2*(FBIT2+1)), .D(128), .B(7)) ACR_delay128(
	.clk(CLK_I), 
	.rst((RST_I | syn_value_rst)), 
	.ena(CM_val),
	.dat_in({ACRMult_Im, ACRMult_Re}),	
	.dat_out({ACRMult_Im_d128,ACRMult_Re_d128})
	);

wire [6+FBIT2:0] P_Re, P_Im;		// rounding P_Metric in format 7.FBIT2
Acc_Sum #(.FBIT2(FBIT2)) P_Acc_Sum_ins(
   .clk(CLK_I),
	.rst((RST_I | syn_value_rst)),
	.ena(CM_val),
	.a_Re(ACRMult_Re), 
	.a_Im(ACRMult_Im),
	.a_d_Re(ACRMult_Re_d128),
	.a_d_Im(ACRMult_Im_d128),
	.sum_out_Re(P_Re), 
	.sum_out_Im(P_Im)
   );
//================================ End P metric ===================================//



//================================ Calculate R metric ==============================//
wire [79:0] ABSrx_out;
wire [15:0] rx_abs;
wire 			ABSrx_val;
//wire [21:0] R_Metric;								// rounding R Metric in format 7.15
wire [4+FBIT:0] R_Metric;							// rounding R Metric in format 5.FBIT
Complex_Multiplier ABSrx_ins (
	.aclk(CLK_I), 										// input aclk
	.aresetn(~(RST_I|time_syn_done)), 			// input aresetn
	.s_axis_a_tvalid(iena), 						// input s_axis_a_tvalid
	.s_axis_a_tdata({rx_Im_conj, rx_Re}), 		// input [31 : 0] s_axis_a_tdata
	.s_axis_b_tvalid(iena),							// input s_axis_b_tvalid
	.s_axis_b_tdata({rx_Im,  	  rx_Re}), 		// input [31 : 0] s_axis_b_tdata
	.m_axis_dout_tvalid(ABSrx_val), 				// ouput m_axis_dout_tvalid
	.m_axis_dout_tdata(ABSrx_out)					// ouput [79 : 0] m_axis_dout_tdata
	); 				
assign rx_abs = ABSrx_out[30:15];					// rounding output of ABS in format 1.15

							
Multiplierless_Correlator #(.FBIT(FBIT)) XCR_cal(
	.clk(CLK_I),
	.rst((RST_I | syn_value_rst)),
	.ena(ABSrx_val & CM_val),
	.CR_in(rx_abs),  					// Bus [15 : 0] 
	.CR_out(R_Metric) 				// rounding R Metric in format 5.FBIT	
	);

assign P_Metric = {P_Im, P_Re};

Time_Synch #(.FBIT(FBIT), .FBIT2(FBIT2)) Time_Synch_ins(
	.clk(CLK_I), .rst(RST_I),  .syn_run(time_syn_run),
	.metric_val(ABSrx_val),
	.P_Metric_Re({P_Re,{(15-FBIT2){1'b0}}}),				// real part of P metric [21:0] in format 7.15
	.P_Metric_Im({P_Im,{(15-FBIT2){1'b0}}}),				// imaginary part of P metric [21:0] in format 7.15
	.R_Metric(R_Metric),				// R Metric in format 5.FBIT
	.SNR(SNR),			
	
	.syn_done(time_syn_done),
	.FRE_O(FRE_O),						// P metric out for frequency offset estimation [31:0]
	.FRE_O_val(FRE_O_val)
	);

Synch_out Synch_out_ins(
	.clk(CLK_I), .rst(RST_I),
	.dat_in(DAT_I),					//input [31 : 0] DAT_I
	.cyc_i(CYC_I), 
	.stb_i(STB_I),
	.ack_o(ACK_O),
	.time_syn_run(time_syn_run),
	
	.time_syn_done(time_syn_done),
	.dat_out(DAT_O),					//output [31:0] DAT_O
	.we_o(WE_O), 
	.stb_o(STB_O), 
	.cyc_o(CYC_O),
	.ack_i(ACK_I)
	);

endmodule
