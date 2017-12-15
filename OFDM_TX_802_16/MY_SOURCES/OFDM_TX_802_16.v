`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:41:04 04/12/2013 
// Design Name: 
// Module Name:    OFDM_TX_802_16 
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
module OFDM_TX_802_16(
   input 			CLK_I, RST_I,
	input [5:0] 	DAT_I,
	input 			CYC_I, WE_I, STB_I, 
	output			ACK_O,
	
	output [31:0]	DAT_O,
	output			CYC_O, STB_O,
	output			WE_O,
	input				ACK_I	
    );

wire [31:0] DAT_Mod_DAT_O;
wire 			DAT_Mod_WE_O; 
wire			DAT_Mod_STB_O;
wire			DAT_Mod_CYC_O;
wire			DAT_Mod_ACK_I;	 
DAT_Mod DAT_Mod_Ins(
	.CLK_I(CLK_I), .RST_I(RST_I),
	.DAT_I(DAT_I[3:0]),
	.WE_I (WE_I), 
	.STB_I(STB_I),
	.CYC_I(CYC_I),
	.ACK_O(ACK_O),	
	
	.DAT_O(DAT_Mod_DAT_O),
	.WE_O (DAT_Mod_WE_O ), 
	.STB_O(DAT_Mod_STB_O),
	.CYC_O(DAT_Mod_CYC_O),
	.ACK_I(DAT_Mod_ACK_I)	
    );

wire [31:0] Pilots_Insert_DAT_O;
wire 			Pilots_Insert_WE_O; 
wire			Pilots_Insert_STB_O;
wire			Pilots_Insert_CYC_O;
wire			Pilots_Insert_ACK_I;	 
Pilots_Insert Pilots_Insert_Ins(
	.CLK_I(CLK_I), .RST_I(RST_I),
	.DAT_I(DAT_Mod_DAT_O),
	.WE_I (DAT_Mod_WE_O), 
	.STB_I(DAT_Mod_STB_O),
	.CYC_I(DAT_Mod_CYC_O),
	.ACK_O(DAT_Mod_ACK_I),	
	
	.DAT_O(Pilots_Insert_DAT_O),
	.WE_O (Pilots_Insert_WE_O ), 
	.STB_O(Pilots_Insert_STB_O),
	.CYC_O(Pilots_Insert_CYC_O),
	.ACK_I(Pilots_Insert_ACK_I)	
    );
	 
	 
wire [31:0] IFFT_Mod_DAT_O;
wire 			IFFT_Mod_WE_O; 
wire			IFFT_Mod_STB_O;
wire			IFFT_Mod_CYC_O;
wire			IFFT_Mod_ACK_I;	 
IFFT_Mod 	IFFT_Mod_Ins(
	.CLK_I(CLK_I), .RST_I(RST_I),
	.DAT_I(Pilots_Insert_DAT_O),
	.WE_I (Pilots_Insert_WE_O), 
	.STB_I(Pilots_Insert_STB_O),
	.CYC_I(Pilots_Insert_CYC_O),
	.ACK_O(Pilots_Insert_ACK_I),	
	
	.DAT_O(IFFT_Mod_DAT_O),
	.WE_O (IFFT_Mod_WE_O ), 
	.STB_O(IFFT_Mod_STB_O),
	.CYC_O(IFFT_Mod_CYC_O),
	.ACK_I(IFFT_Mod_ACK_I)	
    );


wire [31:0] Tx_Out_DAT_O;
wire 			Tx_Out_WE_O; 
wire			Tx_Out_STB_O;
wire			Tx_Out_CYC_O;
wire			Tx_Out_ACK_I;	 
Tx_Out 		Tx_Out_Ins(
	.CLK_I(CLK_I), .RST_I(RST_I),
	.DAT_I(IFFT_Mod_DAT_O),
	.WE_I (IFFT_Mod_WE_O), 
	.STB_I(IFFT_Mod_STB_O),
	.CYC_I(IFFT_Mod_CYC_O),
	.ACK_O(IFFT_Mod_ACK_I),	
	
	.DAT_O(Tx_Out_DAT_O),
	.WE_O (Tx_Out_WE_O ), 
	.STB_O(Tx_Out_STB_O),
	.CYC_O(Tx_Out_CYC_O),
	.ACK_I(Tx_Out_ACK_I)	
    );

assign Tx_Out_ACK_I  = ACK_I;
assign DAT_O			= Tx_Out_DAT_O;
assign WE_O				= Tx_Out_WE_O;
assign STB_O			= Tx_Out_STB_O;
assign CYC_O			= Tx_Out_CYC_O;


endmodule

