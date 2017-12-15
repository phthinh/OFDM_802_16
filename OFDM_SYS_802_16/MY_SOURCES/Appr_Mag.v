`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:24:42 04/21/2012 
// Design Name: 
// Module Name:    Appr_Mag 
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
module Appr_Mag(
	input 					clk, rst, ena,
	input 		[21:0] 	real_in, imag_in,
	output reg	[22:0]	mag,
	output reg				val
	
    );

reg	[21:0] real_reg, imag_reg;
reg	ena_reg;
reg	[21:0] real_abs, imag_abs;
reg	ena_abs;

always@(posedge clk)
begin	
	if(rst) begin
		ena_reg 	<= 1'b0;
		real_reg <= 22'd0;
		imag_reg	<= 22'd0;
		end
	else if(ena) begin
		ena_reg 	<= 1'b1;
		real_reg <= real_in;
		imag_reg	<= imag_in;
		end
	else ena_reg <= 1'b0;
end

always@(posedge clk)
begin	
	if(rst) begin
		ena_abs 	<= 1'b0;
		real_abs <= 22'd0;
		imag_abs	<= 22'd0;
		end
	else if(ena_reg) begin
		ena_abs 	<= 1'b1;
		real_abs <= (real_reg[21])? (~real_reg + 1'b1): real_reg;
		imag_abs	<= (imag_reg[21])? (~imag_reg + 1'b1): imag_reg;
		end
	else ena_abs <= 1'b0;
end

always@(posedge clk)
begin	
	if(rst) begin
		val 	<= 1'b0;
		mag 	<= 23'd0;		
		end
	else if(ena_abs) begin
		val 	<= 1'b1;
		mag 	<= (real_abs > imag_abs)? (real_abs + (imag_abs>>1)): (imag_abs + (real_abs>>1));
		end
	else val <= 1'b0;
end

endmodule
