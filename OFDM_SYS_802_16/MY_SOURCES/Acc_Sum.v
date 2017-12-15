`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:26:36 04/15/2012 
// Design Name: 
// Module Name:    Acc_Sum 
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
module Acc_Sum(
   input 			clk,rst,
	input 			ena,
	input 			[15:0] a_Re, a_Im,
	input				[15:0] a_d_Re, a_d_Im,
	output signed  [21:0] sum_out_Im, sum_out_Re
   );

reg [43:0] sum_reg;
always @(posedge clk)
begin
	if (rst)			sum_reg <= 44'd0;
	else if(ena)	sum_reg <= {sum_out_Im, sum_out_Re};
end

assign sum_out_Re = (~ena)? 22'd0: $signed(sum_reg[21:0]) + $signed({{6{a_Re[15]}},a_Re}) - $signed({{6{a_d_Re[15]}},a_d_Re}); 
assign sum_out_Im = (~ena)? 22'd0: $signed(sum_reg[43:22]) + $signed({{6{a_Im[15]}},a_Im}) - $signed({{6{a_d_Im[15]}},a_d_Im}); 

endmodule
