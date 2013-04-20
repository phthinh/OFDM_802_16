`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:28:32 11/10/2012 
// Design Name: 
// Module Name:    Ph_Est 
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
module PhTrack_Est(
	input 		 clk, rst, start, acc,
	input [15:0] datin_Re,		//Q 3.13
	input [15:0] datin_Im,		//Q 3.13
	input			 datin_val,
	output[15:0] ph_Re,		 
	output[15:0] ph_Im,
	output reg	 ph_oval
    );

reg  [2:0] 	ph_cnt;
reg  [18:0]	ph_sum8_Re, ph_sum8_Im;		// Q6.13
reg  [17:0]	ph_sum4_Re, ph_sum4_Im;		// Q5.13
reg 			sum_done;
reg 			sum_val_p, ph_est_p;

reg  [18:0]	ph_op1_Re, ph_op1_Im;		// Q6.13
reg  [17:0]	ph_op2_Re, ph_op2_Im;		// Q5.13
wire [18:0]	subsum1_Re, subsum1_Im;		// Q6.13
wire [15:0] addsum2_Re, subsum2_Im;		// Q3.13
//reg  [13:0] acosbi, asinbi;				// Q1.13
reg  [14:0] sinbi, cosbi;					// Q2.13

//reg  [15:0] ph_acc_Re, ph_acc_Im;		// Q3.13
wire [15:0] ph_est_Re, ph_est_Im;		// Q3.13

always@(posedge clk) begin
	if (rst)				begin
								//acosbi 	<= 13'd0;
								//asinbi 	<= 13'd0;
								sinbi 	<= 14'd0;
								cosbi 	<= 14'd0;
							end
	else if(ph_est_p)begin
								//asinbi	<= {subsum1_Re[18], subsum1_Re[18], subsum1_Re[18:7]};		// subsum1_Re >> 7;  Q1.13
								cosbi		<= addsum2_Re[14:0];		// Q2.13				// subsum2_Re >> 3;  Q2.13
								//acosbi	<= {subsum1_Im[18], subsum1_Im[18], subsum1_Im[18:7]};		// subsum1_Im >> 7;  Q1.13
								sinbi		<= subsum2_Im[14:0];		// Q2.13				// subsum2_Im >> 3;  Q2.13
							end	
end

assign subsum1_Re = {ph_op1_Re[18], ph_op1_Re[18:1]} 	- {ph_op2_Re[17], ph_op2_Re}; 	// Q6.13
assign addsum2_Re	= ph_op1_Re[18:3] 						+ subsum1_Re[15:0];	  	// Q3.13

assign subsum1_Im = {ph_op2_Im[17], ph_op2_Im} 			- {ph_op1_Im[18], ph_op1_Im[18:1]};	// Q6.13
assign subsum2_Im	=  ph_op1_Im[18:3] 						- subsum1_Im[15:0];		// Q3.13

always@(posedge clk) begin
	if (rst)				begin
								ph_op1_Re <= 19'd0;
								ph_op1_Im <= 19'd0;
								ph_op2_Re <= 18'd0;
								ph_op2_Im <= 18'd0;								
							end
	else if(sum_val_p)begin
								ph_op1_Re <= ph_sum8_Re;
								ph_op1_Im <= ph_sum8_Im;
								ph_op2_Re <= ph_sum4_Re;
								ph_op2_Im <= ph_sum4_Im;
							end	
end
always@(posedge clk) begin
	if (rst)	begin 
					ph_cnt <= 3'd0;
					ph_sum8_Re <= 19'd0;
					ph_sum8_Im <= 19'd0;
				end
	else if(start)begin 
					ph_cnt <= 3'd0;
					ph_sum8_Re <= 19'd0;
					ph_sum8_Im <= 19'd0;
				end
	else if(datin_val & (~sum_done)) begin
					ph_cnt <= ph_cnt + 1'b1;
					ph_sum8_Re <= ph_sum8_Re + {{3{datin_Re[15]}},datin_Re};
					ph_sum8_Im <= ph_sum8_Im + {{3{datin_Im[15]}},datin_Im};
				end					
end

always@(posedge clk) begin
	if (rst)	begin 
					ph_sum4_Re <= 18'd0;
					ph_sum4_Im <= 18'd0;
				end
	else if(start)begin 
					ph_sum4_Re <= 18'd0;
					ph_sum4_Im <= 18'd0;
				end
	else if((ph_cnt == 3'b010)|(ph_cnt == 3'b011)|(ph_cnt == 3'b110)|(ph_cnt == 3'b111)) begin
					ph_sum4_Re <= ph_sum4_Re + {{2{datin_Re[15]}},datin_Re};
					ph_sum4_Im <= ph_sum4_Im + {{2{datin_Im[15]}},datin_Im};
				end					
end

always@(posedge clk) begin
	if (rst)							sum_done	<=	1'b0;
	else if (start)				sum_done	<=	1'b0;
	else if(ph_cnt == 3'b111)	sum_done	<=	1'b1;				
end

always@(posedge clk) begin
	if (rst)							sum_done	<=	1'b0;
	else if (start)				sum_done	<=	1'b0;
	else if(ph_cnt == 3'b111)	sum_done	<=	1'b1;				
end
always@(posedge clk) begin
	if (rst)	begin
					sum_val_p	<=	1'b0;
					ph_est_p		<= 1'b0;
					ph_oval		<= 1'b0;
				end
	else 		begin
					ph_oval		<= ph_est_p;
					ph_est_p		<= sum_val_p;
					sum_val_p	<=	(ph_cnt == 3'b111);	
				end
end

/*
reg [7:0] acc_cnt;
always@(posedge clk) begin
	if (rst)	begin 
					ph_acc_Re <= 16'd0;
					ph_acc_Im <= 16'd0;
					acc_cnt 	 <= 8'd0;
				end
	else if(ph_oval)begin 
					ph_acc_Re <= 16'd0;
					ph_acc_Im <= 16'd0;
					acc_cnt 	 <= 8'd0;
				end
	else if(acc) begin
				acc_cnt <= acc_cnt +1'b1;
					if (acc_cnt == 8'd95) begin
					ph_acc_Re <= ph_acc_Re + {asinbi[9:0], 6'd0}; // +64 *asinbi 	// Q3.13
					ph_acc_Im <= ph_acc_Im + {acosbi[9:0], 6'd0}; // +64 *acosbi	// Q3.13
					end
					else 
					begin
					ph_acc_Re <= ph_acc_Re + {{2{asinbi[13]}},asinbi};  	// Q3.13
					ph_acc_Im <= ph_acc_Im + {{2{acosbi[13]}},acosbi};		// Q3.13
					end
				end
end
*/
//assign ph_est_Re 	= {cosbi[14],cosbi} - ph_acc_Re; //Q3.13;
//assign ph_est_Im 	= {sinbi[14],sinbi} + ph_acc_Im; //Q3.13;
assign ph_est_Re 	= {cosbi[14],cosbi} ; //Q3.13;
assign ph_est_Im 	= {sinbi[14],sinbi} ; //Q3.13;
assign ph_Re		= ph_est_Re[15:0];		//Q3.13;
assign ph_Im		= ph_est_Im[15:0];		//Q3.13;

endmodule
