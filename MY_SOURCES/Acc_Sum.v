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
module Acc_Sum #(parameter FBIT2 =7)	//number of P Metric's frational bits
(  input 			clk,rst,
	input 			ena,
	input 			[FBIT2:0] a_Re, a_Im,						// in format 1.FBIT2
	input				[FBIT2:0] a_d_Re, a_d_Im,					// in format 1.FBIT2
	output signed  [6 + FBIT2:0] sum_out_Im, sum_out_Re	// in format 7.FBIT2
   );

reg [FBIT2:0] ia_Re, ia_Im, ia_d_Re, ia_d_Im;
always @(posedge clk)
begin
	if (rst)			begin
		ia_Re 	<= {(FBIT2){1'b0}};
		ia_Im 	<= {(FBIT2){1'b0}};
		ia_d_Re	<= {(FBIT2){1'b0}};
		ia_d_Im	<= {(FBIT2){1'b0}};
		end
	else if(ena)	begin
		ia_Re 	<= a_Re;
		ia_Im 	<= a_Im;
		ia_d_Re 	<= a_d_Re;
		ia_d_Im 	<= a_d_Im;
		end
end

reg [(13+2*FBIT2):0] sum_reg;
always @(posedge clk)
begin
	if (rst)			sum_reg <=  {(14+2*FBIT2){1'b0}};
	else if(ena)	sum_reg <= {sum_out_Im, sum_out_Re};
end

assign sum_out_Re = $signed(sum_reg[6+FBIT2:0]) 				+ $signed({{6{ia_Re[FBIT2]}},ia_Re}) - $signed({{6{ia_d_Re[FBIT2]}},ia_d_Re}); 
assign sum_out_Im = $signed(sum_reg[(13+2*FBIT2):7+FBIT2]) 	+ $signed({{6{ia_Im[FBIT2]}},ia_Im}) - $signed({{6{ia_d_Im[FBIT2]}},ia_d_Im}); 

endmodule
