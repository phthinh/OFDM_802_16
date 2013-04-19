`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:58:32 11/10/2012 
// Design Name: 
// Module Name:    Ch_PhaseTrack 
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
module PhaseTrack(
	input 			CLK_I, RST_I,
	input [31:0] 	DAT_I,						// DAT_I_Im[31:16] DAT_I_Re[15:0] in Q3.13 (Q7.9)
	input 			WE_I, STB_I, CYC_I,
	output			ACK_O,
	
	output reg [31:0]	DAT_O,					// DAT_I_Im[31:16] DAT_I_Re[15:0] in Q3.13 (Q7.9)
	output reg		CYC_O,STB_O,
	output 			WE_O, 
	input				ACK_I	
    );
//parameter P_P = 16'h5A82;	// +1/aqrt(2) in Q1.15
//parameter P_N = 16'hA57E;	// -1/aqrt(2) in Q1.15 
parameter P_P = 16'h7FFF;	// +1 in Q1.15
parameter P_N = 16'h8001;	// -1 in Q1.15 
//parameter P_seq = 128'h3A3A3A3A3A3A3A3A3AC5C5C5C5C5C5C5
reg 		 Pil 	 [0:127]; //[1] :signed bit of imaginary part, [0] :signed bit of real part of long preamble,
initial $readmemh("./MY_SOURCES/Pilot_seq.txt", Pil);


parameter IDLE   = 2'b00,
			 RXPI   = 2'b01,
			 ESTI   = 2'b10,
		    COMP   = 2'b11;
reg [1:0] status;

reg [31:0]  idat;
reg 			iena;
wire 			istart, out_halt, datin_val;
wire 			idat_val;

assign 		datin_val = (WE_I) & STB_I & CYC_I;
assign 		out_halt  =  STB_O  & (~ACK_I);
assign 		ACK_O     =  datin_val &(~out_halt) & (~ph_est);
assign		istart	 =  CYC_I  & (~CYC_I_pp);

reg 	CYC_I_pp;
always @(posedge CLK_I) begin
	if(RST_I)	CYC_I_pp <= 1'b1;
	else  		CYC_I_pp <= CYC_I;
end
always @(posedge CLK_I) begin
	if(RST_I) 				idat <= 32'd0;
	else if ( ACK_O ) 	idat <= DAT_I;
end
always @(posedge CLK_I) begin
	if(RST_I)  				iena <= 1'b0;
	else if (datin_val)	iena <= 1'b1;
	else 						iena <= 1'b0;
end

wire [15:0] pilot;
reg  [6:0] 	pil_rdcnt;
reg  [7:0]	dat_cnt;

reg 			Ph_acc;
wire			Ph_start;
wire [15:0] Ph_Re;
wire [15:0] Ph_Im;
wire			Ph_est_val;


wire [31:0] Ph_CmxMul_A; 			//[31:16]: imaginary part, [15:0]: real part
wire [31:0] Ph_CmxMul_B; 			//[31:16]: imaginary part, [15:0]: real part
wire [79:0] Ph_CmxMul_dout;		//[72:40]: imaginary part, [32:0]: real part
wire  		Ph_CmxMul_ival;
wire 			Ph_CmxMul_oval;

wire [15:0] mult_Re, mult_Im;
reg			ph_rxp, ph_est;
	
assign idat_val =	(ph_rxp)? iena : (Ph_acc & iena);
always@(posedge CLK_I) begin
	if (RST_I)	 		  			dat_cnt <= 8'd0;
	else if (idat_val) begin
		if(dat_cnt == 8'd199)	dat_cnt <= 8'd0;
		else							dat_cnt <= dat_cnt + 1'b1;
	end
end	

always@(posedge CLK_I) begin
	if (RST_I)	 	begin
							status <= IDLE;
							ph_rxp <= 1'b0;
							ph_est <= 1'b0;
							Ph_acc <= 1'b0;							
					end
	else if (istart)	begin
							status <= IDLE;
							ph_rxp <= 1'b0;
							ph_est <= 1'b0;
							Ph_acc <= 1'b0;							
					end
	else	begin
		case (status) 
			IDLE: begin
					if (datin_val) begin 
							status <= RXPI;
							ph_rxp <= 1'b1;
					end
					end
			RXPI: begin
					if (dat_cnt == 8'd7) begin 
							status <= ESTI;
							ph_rxp <= 1'b0;
							ph_est <= 1'b1;
					end
					end
			ESTI: begin
					if (Ph_est_val) begin 
							status <= COMP;
							ph_est <= 1'b0;							
							Ph_acc <= 1'b1;
					end
					end	
			COMP: begin
					if (dat_cnt == 8'd199) begin 
							status <= IDLE;	
							Ph_acc <= 1'b0;							
					end
					end					
		endcase	
	end
end

always@(posedge CLK_I) begin
	if (RST_I)	 		  					pil_rdcnt <= 7'd0;
	else if (istart) 						pil_rdcnt <= 7'd0;
	else if(iena & (status == RXPI))	pil_rdcnt <= pil_rdcnt +1'b1;
end
//assign 	pilot[31:16]	= (Pil[pil_rdcnt][1])? P_N: P_P;
assign 	pilot[15:0] 	= (Pil[pil_rdcnt])? P_N: P_P;

assign	Ph_start 		= iena & (dat_cnt == 8'd0);
PhTrack_Est Ph_Est_ins(
	.clk(CLK_I), .rst(RST_I), .start(Ph_start), .acc(Ph_acc & iena),
	.datin_Re(mult_Re),
	.datin_Im(mult_Im),
	.datin_val(Ph_CmxMul_oval & (ph_rxp|ph_est)),
	.ph_Re(Ph_Re),
	.ph_Im(Ph_Im),
	.ph_oval(Ph_est_val)
);
assign	mult_Re = Ph_CmxMul_dout[30:15];		// in format Q3.13 (Q7.9)
assign	mult_Im = Ph_CmxMul_dout[70:55];		// in format Q3.13 (Q7.9)

assign   Ph_CmxMul_A 		 = idat;				// Q3.13 (Q7.9)
assign	Ph_CmxMul_B[15:0]  = (ph_rxp)? pilot[15:0] :   Ph_Re;		// Q1.15 : Q3.13 (Q7.9)
assign	Ph_CmxMul_B[31:16] = (ph_rxp)? 16'd0		 : (~Ph_Im + 1'b1); //imaginary part of pilot is zero.

assign	Ph_CmxMul_ival 	 = idat_val;

Ch_CmxMul Ph_CmxMul_ins(
	.aclk(CLK_I), // input aclk	
	.aresetn(~RST_I), // input aresetn
	.aclken(1'b1), // input aclken
	.s_axis_a_tvalid(Ph_CmxMul_ival), // input s_axis_a_tvalid
	.s_axis_a_tdata(Ph_CmxMul_A), // input [31 : 0] s_axis_a_tdata
	.s_axis_b_tvalid(Ph_CmxMul_ival), // input s_axis_b_tvalid
	.s_axis_b_tdata(Ph_CmxMul_B), // input [31 : 0] s_axis_b_tdata
	.m_axis_dout_tvalid(Ph_CmxMul_oval), // ouput m_axis_dout_tvalid
	.m_axis_dout_tdata(Ph_CmxMul_dout)); // ouput [79 : 0] m_axis_dout_tdata [32:0]:real part; [72:40]:imaginary part.



reg [5:0] ph_track_delay; // because of multiplier latency.
always @(posedge CLK_I) begin
	if(RST_I) 							ph_track_delay <= 6'd0;
	else if (CYC_O)					ph_track_delay <= {(idat_val & Ph_acc), ph_track_delay[5:1]};
end
wire 		ph_track_oval = ph_track_delay[0];

always @(posedge CLK_I) begin
	if(RST_I) 								CYC_O <= 1'b0;
	else if (Ph_CmxMul_ival)			CYC_O <= 1'b1;
	else if(~(ph_track_oval|CYC_I))	CYC_O <= 1'b0;
end
assign WE_O = CYC_O;

always @(posedge CLK_I) begin
	if(RST_I) 	begin
		DAT_O <= 32'd0;
		STB_O <= 1'b0;
		end
	else if(ph_track_oval & Ph_CmxMul_oval) 	begin	
		STB_O <= 1'b1;
		if ((~out_halt))	DAT_O <= {Ph_CmxMul_dout[68:53], Ph_CmxMul_dout[28:13]};		//Q3.13 (Q7.9)
		end		
	else STB_O <= 1'b0;
end

endmodule
