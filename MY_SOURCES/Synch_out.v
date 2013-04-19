`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:21:43 04/23/2012 
// Design Name: 
// Module Name:    Synch_out 
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
module Synch_out(
	input clk, rst,
	input [31:0] 		dat_in,
	input 				cyc_i, 
	input					stb_i,
	output 				ack_o,
	output reg			time_syn_run,
	
	input					time_syn_done,
	output reg [31:0]	dat_out,
	output reg			cyc_o, stb_o, 
	output				we_o,
	input					ack_i
	);


reg cyc_i_pp;
always @(posedge clk)begin 
	if(rst) cyc_i_pp <= 1'b0;
	else    cyc_i_pp <= cyc_i;
end

always @(posedge clk)begin 
	if(rst) 									time_syn_run <= 1'b0;
	else if (cyc_i & (~cyc_i_pp)) 	time_syn_run <= 1'b1;
	else if (time_syn_done) 			time_syn_run <= 1'b0;
end

reg syn_done;
always @(posedge clk)begin 
	if(rst) 						syn_done <= 1'b0;
	else if (time_syn_done) syn_done <= 1'b1;
	else if (~cyc_i) 			syn_done <= 1'b0;
end

always @(posedge clk)begin 
	if(rst) 	begin
			dat_out <= 32'b0;
			cyc_o	  <= 1'b0;
			stb_o	  <= 1'b0;
			end
	else if (syn_done) begin
			cyc_o	  <= 1'b1;
			dat_out <= dat_in;
			stb_o	  <= stb_i;
			end
	else if (~cyc_i) begin
			dat_out <= 32'b0;
			cyc_o	  <= 1'b0;
			stb_o	  <= 1'b0;
			end
end

assign  ack_o = (cyc_i & stb_i & (ack_i|(~stb_o)));
assign  we_o  = stb_o;
endmodule
