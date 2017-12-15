`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:21:35 12/29/2012 
// Design Name: 
// Module Name:    Ch_Sim1 
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
module Ch_Sim1(
	input 			CLK_I, RST_I,
	input [31:0] 	DAT_I,
	input 			WE_I, STB_I, CYC_I,
	output			ACK_O,
	
	output [31:0]	DAT_O,
	output 			CYC_O, STB_O,
	output 			WE_O,
	input				ACK_I	
    );
/*
always @(posedge CLK_I) begin
	if(RST_I) begin 
		DAT_O <= 32'd0;
		CYC_O <= 1'b0;
		WE_O	<= 1'b0;
		STB_O <= 1'b0;
		end
	else begin
		DAT_O <= DAT_I;
		CYC_O <= CYC_I;
		WE_O	<= WE_I;
		STB_O <= STB_I;
		end		
end*/
//assign DAT_O = {DAT_I[31],DAT_I[31],DAT_I[31:18],DAT_I[15],DAT_I[15],DAT_I[15:2]};
//assign DAT_O = DAT_I;
assign DAT_O = {DAT_I[29:16],2'd0,DAT_I[13:0],2'd0};
assign CYC_O = CYC_I;
assign WE_O	 = WE_I;
assign STB_O = STB_I;
assign ACK_O = ACK_I;

endmodule
