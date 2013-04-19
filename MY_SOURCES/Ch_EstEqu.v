`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:28 11/06/2012 
// Design Name: 
// Module Name:    Ch_EstEqu 
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
module Ch_EstEqu(
	input 			CLK_I, RST_I,
	input [31:0] 	DAT_I,						// DAT_I_Im[31:16] DAT_I_Re[15:0] in format 1.15 (Q5.11)
	input 			WE_I, STB_I, CYC_I,
	output			ACK_O,
	
	output reg [31:0]	DAT_O,					// DAT_O_Im[31:16] DAT_O_Re[15:0] in format 3.13 (Q7.9)
	output reg		CYC_O,STB_O,
	output 			WE_O, 
	input				ACK_I	
    );

parameter LP_P = 16'h5A82;	// +1/aqrt(2) in Q1.15
parameter LP_N = 16'hA57E;	// -1/aqrt(2) in Q1.15 
reg [1:0] lp 	 [0:99]; //[1] :signed bit of imaginary part, [0] :signed bit of real part of long preamble,
initial $readmemh("./MY_SOURCES/Synch_known_lpre.txt", lp);
reg [7:0] reorder [0:199]; //[1] :signed bit of imaginary part, [0] :signed bit of real part of long preamble,
initial $readmemh("./MY_SOURCES/reorder_map.txt", reorder);

reg [31:0]  idat;
reg 			iena;
wire 			istart, out_halt, datin_val;
wire			buf_full;

assign 		datin_val = (WE_I) & STB_I & CYC_I;
assign 		out_halt  =  STB_O  & (~ACK_I);
assign 		ACK_O     =  datin_val & (~buf_full);
assign		istart	 =  CYC_I  & (~CYC_I_pp);

reg 	CYC_I_pp;
always @(posedge CLK_I) begin
	if(RST_I)	CYC_I_pp <= 1'b1;
	else  		CYC_I_pp <= CYC_I;
end
always @(posedge CLK_I) begin
	if(RST_I) 				idat <= 32'd0;
	else if (ACK_O) 		idat <= DAT_I;
end
always @(posedge CLK_I) begin
	if(RST_I)  				iena <= 1'b0;
	else if (ACK_O)		iena <= 1'b1;
	else 						iena <= 1'b0;
end


wire [31:0] buf_dat;
wire [7:0]	datin_cnt;
wire 			buf_almostfull;

reg [7:0]	rx_buf_rdcnt;	//read pointer of rx buffer
reg 			pop_ena;
reg 			half_buf_rd;
wire [7:0]  reorder_rdcnt;

wire [31:0] lg_pre;
wire [6:0]  pre_rdcnt;


reg  [31:0] ch_cof_mem [0:99];
wire [31:0] ch_cof;
wire [6:0]  ch_cof_rdcnt;
reg  [6:0]	ch_cof_wrcnt;

wire 			ch_est;
reg			ch_equ;
wire 			ch_EstEqu_ena;

wire [31:0] Ch_CmxMul_A; 			//[31:16]: imaginary part, [15:0]: real part
wire [31:0] Ch_CmxMul_B; 			//[31:16]: imaginary part, [15:0]: real part
wire [79:0] Ch_CmxMul_dout;		//[72:40]: imaginary part, [32:0]: real part
wire  		Ch_CmxMul_ival;
wire 			Ch_CmxMul_oval;

wire [15:0] mult_Re;
wire [15:0] mult_Im;

Ch_buf Ch_buf_ins(
	.clk(CLK_I), .rst(RST_I), .ena(iena), .start(istart),
	.datin(idat),
	.rd_addr(reorder_rdcnt),		 
	.datout(buf_dat),
	.dat_cnt(datin_cnt),
	.almostfull(buf_almostfull),
	.full(buf_full)
    );

assign  reorder_rdcnt = (ch_equ)? reorder[rx_buf_rdcnt] : rx_buf_rdcnt;			// read the pilot first then data carrier
always@(posedge CLK_I) begin
	if (RST_I) 									pop_ena	<= 1'b0;
	else if (buf_almostfull)				pop_ena	<= 1'b1;								
	else if ((rx_buf_rdcnt  == 8'd199))	pop_ena	<= 1'b0;								
end
always@(posedge CLK_I) begin
	if (RST_I) 									rx_buf_rdcnt	<= 8'd0;
	else if (rx_buf_rdcnt  == 8'd199)	rx_buf_rdcnt	<= 8'd0;
	else if (pop_ena & (~out_halt))		rx_buf_rdcnt	<= rx_buf_rdcnt + 1'b1;	
end
always@(posedge CLK_I) begin
	if (RST_I) 									half_buf_rd	<= 1'b0;
	else if (rx_buf_rdcnt == 8'd99)		half_buf_rd	<= 1'b1;
	else if (rx_buf_rdcnt == 8'd199)		half_buf_rd	<= 1'b0;								
end

assign 	ch_est 			= pop_ena & (~ch_equ);
assign 	ch_EstEqu_ena 	= ch_est | ch_equ;
always@(posedge CLK_I) begin
	if (RST_I)	 												ch_equ <= 1'b0;
	else if (pop_ena & (rx_buf_rdcnt  == 8'd199)) 	ch_equ <=(CYC_I)? 1'b1: 1'b0;		
end

assign  	pre_rdcnt 		= (ch_est)? rx_buf_rdcnt[7:1] :7'd0;
assign 	lg_pre[31:16]	= (lp[pre_rdcnt][1])? LP_N: LP_P;
assign 	lg_pre[15:0] 	= (lp[pre_rdcnt][0])? LP_N: LP_P;

assign 	ch_cof 			=  ch_cof_mem[ch_cof_rdcnt];			
assign  	ch_cof_rdcnt 	= (ch_equ)? reorder_rdcnt[7:1]:7'd0;
always@(posedge CLK_I) begin
	if (RST_I) 									ch_cof_wrcnt <= 7'd0;	
	else if (istart) 							ch_cof_wrcnt <= 7'd0;
	else if (Ch_CmxMul_oval & (~(ch_cof_wrcnt == 7'd100))) begin
													ch_cof_mem[ch_cof_wrcnt]	<= {mult_Im, mult_Re};
													ch_cof_wrcnt <= ch_cof_wrcnt + 1'b1;
													end
end

assign	mult_Re = Ch_CmxMul_dout[31:16];		//divide by 4
assign	mult_Im = Ch_CmxMul_dout[71:56];		//divide by 4

assign	Ch_CmxMul_A[15:0]  = buf_dat[15:0];
assign	Ch_CmxMul_A[31:16] = (ch_est)? (~buf_dat[31:16] + 1'b1)			: buf_dat[31:16];
assign   Ch_CmxMul_B 		 = (ch_est)? lg_pre									: ch_cof;
assign	Ch_CmxMul_ival 	 = (ch_est) ? (half_buf_rd^rx_buf_rdcnt[0]) 	: (ch_equ)? pop_ena : 1'b0;

Ch_CmxMul Ch_CmxMul_ins(
	.aclk(CLK_I), // input aclk	
	.aresetn(~RST_I), // input aresetn
	.aclken(~out_halt), // input aclken
	.s_axis_a_tvalid(Ch_CmxMul_ival), // input s_axis_a_tvalid
	.s_axis_a_tdata(Ch_CmxMul_A), // input [31 : 0] s_axis_a_tdata
	.s_axis_b_tvalid(Ch_CmxMul_ival), // input s_axis_b_tvalid
	.s_axis_b_tdata(Ch_CmxMul_B), // input [31 : 0] s_axis_b_tdata
	.m_axis_dout_tvalid(Ch_CmxMul_oval), // ouput m_axis_dout_tvalid
	.m_axis_dout_tdata(Ch_CmxMul_dout)); // ouput [79 : 0] m_axis_dout_tdata 


reg [5:0] ch_equ_delay; // because of multiplier latency.
always @(posedge CLK_I) begin
	if(RST_I) 							ch_equ_delay <= 6'd0;
	else if (CYC_O)					ch_equ_delay <= {ch_equ, ch_equ_delay[5:1]};
end
wire 		ch_equ_oval = ch_equ_delay[0];

always @(posedge CLK_I) begin
	if(RST_I) 							CYC_O <= 1'b0;
	else if (ch_EstEqu_ena)			CYC_O <= 1'b1;
	else if(~ch_equ_oval)			CYC_O <= 1'b0;
end
assign WE_O = CYC_O;

always @(posedge CLK_I) begin
	if(RST_I) 	begin
		DAT_O <= 32'd0;
		STB_O <= 1'b0;
		end
	else if(ch_equ_oval & Ch_CmxMul_oval) 	begin	
		STB_O <= 1'b1;
		if ((~out_halt))	DAT_O <= {mult_Im, mult_Re};			// Q3.13 (Q7.9)
		end		
	else STB_O <= 1'b0;
end


endmodule
