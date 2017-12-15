`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:02:39 04/18/2012 
// Design Name: 
// Module Name:    ML_tap 
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
module ML_tap(
   input 	 	[16:0] ML_value1, ML_value2,	
	input			[ 1:0] known_coeff,
	output reg 	[16:0] ML_out
    );
	 
always @(*) begin
	case (known_coeff)
		2'b00:	ML_out = 17'd0;					
		2'b01: 	ML_out = ML_value1;			// * 0.5							
		2'b10: 	ML_out = ML_value2;			// * 1						
		default: ML_out = 17'd0;								
	endcase	
end

endmodule
