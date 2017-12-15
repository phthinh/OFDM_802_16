`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:02:55 04/15/2012 
// Design Name: 
// Module Name:    Multiplierless_Correlator 
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
module Multiplierless_Correlator(
	input 	clk,rst,
	input 	ena,
	input 	[15:0] CR_in,
	output   [21:0] CR_out
   );
 
 
reg [3:0] Synch_known_coeff 	 [63:0];
initial $readmemh("./MY_SOURCES/Synch_known_coeff_rtl.txt", Synch_known_coeff);


wire 	[15:0] iCR_in = CR_in;
wire			 iena   = ena;
/*always @(posedge clk)
begin
	if (rst) begin
		iCR_in <= 16'd0;
		iena	 <= 1'b0;
		end
	else if(ena)	begin
		iCR_in <= CR_in;
		iena	 <= ena;
		end
end*/

wire 	[15:0] iCR_in_d64;

Delay2n #(.WIDTH(16), .D(64), .B(6)) RX_delay64(
	.clk(clk), 
	.rst(rst), 
	.ena(iena),
	.dat_in(iCR_in),	
	.dat_out(iCR_in_d64)
);

wire [16:0] fir_in = iCR_in + iCR_in_d64;



//=============================================
wire [16:0] ML_value1, ML_value2;
assign ML_value1 =  fir_in >> 1;
assign ML_value2 =  fir_in;

wire [16:0] ML_tap_out 	 [63:0];		//Multipliless 
genvar ML_cnt;
generate
   for (ML_cnt=0; ML_cnt < 64; ML_cnt = ML_cnt + 1) 
   begin: ML_assign
			ML_tap ML_tap_ins(
				.ML_value1(ML_value1), 	.ML_value2(ML_value2),				//[16:0]
				.known_coeff(Synch_known_coeff[ML_cnt][1:0]),				//[1:0]
				.ML_out(ML_tap_out[ML_cnt])										//[16:0]
				);				
   end
endgenerate	

//=============================================
wire [22:0] add_out 	 [63:0];		//Add 
assign 		add_out[0] = {{6{1'b0}},ML_tap_out[0][16:0]};



wire [21:0] reg_out [62:0];		//Add Register 

genvar cnt;
generate
   for (cnt=0; cnt < 63; cnt = cnt + 1) 
   begin: AddCmpReg_ins				
			Delay_reg #(.WIDTH(22)) CRpc_Re_D(
					.clk(clk), 							.rst(rst),						.ena(iena),
					.dat_in(add_out[cnt][21:0]),    		
					.dat_out(reg_out[cnt][21:0])
					);			
			
			assign add_out[cnt+1] = reg_out[cnt] + {{5{1'b0}},ML_tap_out[cnt+1][16:0]};
   end
endgenerate	

assign CR_out = (~iena)? 22'd0 : add_out[63][21:0];		

	

endmodule
