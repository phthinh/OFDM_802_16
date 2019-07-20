`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:29:52 05/28/2013 
// Design Name: 
// Module Name:    Freoff_Est_Comp 
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
module Freoff_Est_Comp(
    input clk, rst, ena, ce,
	 input [31:0] dat_in,
	 input		  stb_in,
	 input [15:0] P_Re, P_Im,
	 output reg [31:0] dat_out,
	 output reg 		 out_val
	 );


reg ena_pp;
always @(posedge clk)
begin
	if(rst)	ena_pp <= 1'b0; 
	else		ena_pp <= ena;
end

wire  phase_trans_rdy, phase_trans_rfd;
wire	[31:0] phase_trans_out;
wire	Metric_nd = ena & (~ena_pp);

wire [15:0] phase_rot;
wire 			phase_rot_nd;
wire [15:0] phase_rot_xout, phase_rot_yout;
wire			phase_rot_rdy;

reg [3:0] avg_cnt;				//count for delay 8 samples and compute average of 8 following samples
always @(posedge clk)
begin
	if(rst)							avg_cnt <= 4'd0; 
	else if(Metric_nd)			avg_cnt <= 4'd1;
	else if(~(avg_cnt==4'd0))	avg_cnt <= avg_cnt +1'b1; 
end
//wire [15:0] P_Re_rd, P_Im_rd;
//assign P_Re_rd = P_Re + 5'b10000;
//assign P_Im_rd = P_Im + 5'b10000;

reg [18:0] P_Re_avg, P_Im_avg;
always @(posedge clk)
begin
	if(rst)						begin P_Re_avg <= 16'd0; P_Im_avg <= 16'd0; end
	else if(Metric_nd)		begin P_Re_avg <= 16'd0; P_Im_avg <= 16'd0; end
	else if(avg_cnt[3])		begin P_Re_avg <= P_Re_avg + {{3{P_Re[15]}},P_Re};
											P_Im_avg <= P_Im_avg + {{3{P_Im[15]}},P_Im}; end
end

reg	 phase_trans_nd;
always @(posedge clk)
begin
	if(rst)								phase_trans_nd <= 1'b0; 
	else if(avg_cnt == 4'b1111)	phase_trans_nd <= 1'b1;
	else 									phase_trans_nd <= 1'b0; 
end

FreComp_PhaseTrans Phase_Trans_ins (
  .s_axis_cartesian_tdata({P_Im_avg[18:3], P_Re_avg[18:3]}),
  .s_axis_cartesian_tvalid(phase_trans_nd), 	// input nd
  .s_axis_cartesian_tready(phase_trans_rfd), 	// output rfd
  .m_axis_dout_tdata(phase_trans_out),// output [31 : 16] phase_out in format 3.13; [15:0] real_out is not used
  .m_axis_dout_tvalid(phase_trans_rdy),	// output rdy

  .aclk(clk), 			// input clk 
  .aresetn(~rst) 			// input sclr
);

wire phase_acc_ld = phase_trans_rdy;
reg  phase_acc_run;
always @(posedge clk)
begin
	if(rst)							phase_acc_run <= 1'b0; 
	else if(phase_trans_rdy)	phase_acc_run <= 1'b1;
	else if(~ena)					phase_acc_run <= 1'b0; 
end

wire phase_acc_rdy;
Phase_Acc Phase_Acc_ins(
    .clk(clk),						//input clock
    .rst(rst),						//input reset
	 .ld(phase_acc_ld),
    .acc(phase_acc_run & stb_in),		//input Accumulate phase
	 .ce(ce),
	 .phase_in(phase_trans_out[31:16]),	//input [15:0] phase input
    .phase_out(phase_rot),			//output[15:0] phase output
    .phase_out_rdy(phase_acc_rdy)	//output	phase out ready		
    );


assign phase_rot_nd = phase_acc_rdy & stb_in;
wire [15:0] phase_rot_x_in = {dat_in[15], dat_in[15:1]};     //in format 2.14
wire [15:0] phase_rot_y_in = {dat_in[31], dat_in[31:17]} ;		//in format 2.14
FreComp_PhaseRot Phase_Rot_ins (
  .s_axis_cartesian_tdata({phase_rot_y_in, phase_rot_x_in}), //input [15 : 0] y_in, x_in	//in format 2.14
  .s_axis_cartesian_tvalid(phase_rot_nd),
  .s_axis_phase_tdata(phase_rot),			// input [15 : 0] phase_in in format 3.13
  .s_axis_phase_tvalid(phase_rot_nd), 			// input nd
  .m_axis_dout_tdata({phase_rot_yout, phase_rot_xout}), // output [15 : 0] yout, xout	//in format 2.14
  .m_axis_dout_tvalid(phase_rot_rdy),			// output rdy
  
  .aclken(ce),					// input ce
  .aclk(clk), 					// input clk  
  .aresetn(~rst) 				// input sclr
);

always @(posedge clk)
begin
	if(rst)	begin		
			dat_out <= 32'b0;
			out_val <= 1'b0;
		end
	else if (phase_rot_rdy)	begin
			dat_out <= {phase_rot_yout, phase_rot_xout};
			out_val <= 1'b1;
		end	
	else	out_val <= 1'b0;
end

endmodule
