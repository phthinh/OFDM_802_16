`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:22:04 04/15/2012 
// Design Name: 
// Module Name:    Delay64 
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
module Delay2n #(parameter WIDTH = 32, D = 64, B = 6)(
	input  clk, rst, ena,
	input  [WIDTH-1:0] dat_in,	
	output [WIDTH-1:0] dat_out
);
reg [WIDTH-1:0] dat_ram [D-1:0];
reg [B-1:0]  adr_cnt;
assign 	  dat_out  = dat_ram[adr_cnt];
integer 	cnt;
always@ (posedge clk)begin
	if(rst) begin
			adr_cnt <= 6'd0;
			for (cnt = 0; cnt < D; cnt = cnt+1) dat_ram[cnt] <= 0;
		end
	else if (ena) begin
			dat_ram[adr_cnt]	<= dat_in;
			adr_cnt 				<= adr_cnt +1'b1;
		end		
end
endmodule
