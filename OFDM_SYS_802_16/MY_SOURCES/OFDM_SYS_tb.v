`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:36:36 12/29/2012 
// Design Name: 
// Module Name:    OFDM_SYS_tb 
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
module OFDM_SYS_tb(
    );
reg 	rst, clk;
reg 	we_i, stb_i, cyc_i;
reg	[1:0] dat_in;
reg			 ack_i;
wire 			 ack_o;
wire 	[7:0] dat_out;
wire			 we_o, stb_o, cyc_o;

OFDM_SYS UUT(
	.CLK_I(clk), .RST_I(rst),
	.DAT_I(dat_in),
	.WE_I(we_i), 
	.STB_I(stb_i),
	.CYC_I(cyc_i),
	.SNR_I(4'd10),
	.ACK_O(ack_o),	
	.DAT_O(dat_out),
	.WE_O (we_o), 
	.STB_O(stb_o),
	.CYC_O(cyc_o),
	.ACK_I(ack_i)	
    );

wire [31:0] QPSK_Mod_datout 	= UUT.QPSK_Mod_ins.DAT_O;	
wire			QPSK_Mod_we_o		= UUT.QPSK_Mod_ins.WE_O; 
wire			QPSK_Mod_stb_o		= UUT.QPSK_Mod_ins.STB_O; 
wire			QPSK_Mod_cyc_o		= UUT.QPSK_Mod_ins.CYC_O;
wire 			QPSK_Mod_ack_o		= UUT.QPSK_Mod_ins.ACK_O;

wire [31:0] Pilots_Insert_datout	= UUT.Pilots_Insert_ins.DAT_O;	
wire			Pilots_Insert_we_o	= UUT.Pilots_Insert_ins.WE_O; 
wire			Pilots_Insert_stb_o	= UUT.Pilots_Insert_ins.STB_O; 
wire			Pilots_Insert_cyc_o	= UUT.Pilots_Insert_ins.CYC_O;
wire 			Pilots_Insert_ack_o	= UUT.Pilots_Insert_ins.ACK_O;

wire [31:0] IFFT_Mod_datout 	= UUT.IFFT_Mod_ins.DAT_O;	
wire			IFFT_Mod_we_o		= UUT.IFFT_Mod_ins.WE_O; 
wire			IFFT_Mod_stb_o		= UUT.IFFT_Mod_ins.STB_O; 
wire			IFFT_Mod_cyc_o		= UUT.IFFT_Mod_ins.CYC_O;
wire 			IFFT_Mod_ack_o		= UUT.IFFT_Mod_ins.ACK_O;

wire [31:0] Tx_Out_datout 		= UUT.Tx_Out_ins.DAT_O;	
wire			Tx_Out_we_o			= UUT.Tx_Out_ins.WE_O; 
wire			Tx_Out_stb_o		= UUT.Tx_Out_ins.STB_O; 
wire			Tx_Out_cyc_o		= UUT.Tx_Out_ins.CYC_O;
wire 			Tx_Out_ack_o		= UUT.Tx_Out_ins.ACK_O;
//=====================================================================================
wire [31:0] Ch_Sim_datout 	= UUT.Ch_Sim_ins.DAT_O;
wire 			Ch_Sim_we_o	 	= UUT.Ch_Sim_ins.WE_O;
wire 			Ch_Sim_stb_o	= UUT.Ch_Sim_ins.STB_O;
wire 			Ch_Sim_cyc_o	= UUT.Ch_Sim_ins.CYC_O;
wire 			Ch_Sim_ack_o	= UUT.Ch_Sim_ins.ACK_O;
//=====================================================================================
wire [31:0] Synch_datout 	= UUT.Synch_ins.DAT_O;
wire 			Synch_we_o	 	= UUT.Synch_ins.WE_O;
wire 			Synch_stb_o	 	= UUT.Synch_ins.STB_O;
wire 			Synch_cyc_o	 	= UUT.Synch_ins.CYC_O; 
wire 			Synch_ack_o	 	= UUT.Synch_ins.ACK_O;

wire [31:0] FreComp_datout 	= UUT.FreComp_ins.DAT_O;
wire 			FreComp_we_o		= UUT.FreComp_ins.WE_O;
wire 			FreComp_stb_o		= UUT.FreComp_ins.STB_O;
wire 			FreComp_cyc_o		= UUT.FreComp_ins.CYC_O;
wire 			FreComp_ack_o		= UUT.FreComp_ins.ACK_O;
wire [15:0] FreComp_phase_rot 		= UUT.FreComp_ins.phase_rot;
wire 			FreComp_phase_acc_rdy 	= UUT.FreComp_ins.phase_acc_rdy;
wire 			FreComp_phase_acc_ce 	= (~UUT.FreComp_ins.out_halt);

wire [31:0] RemoveCP_datout = UUT.RemoveCP_ins.DAT_O;
wire 			RemoveCP_we_o	 = UUT.RemoveCP_ins.WE_O;
wire 			RemoveCP_stb_o	 = UUT.RemoveCP_ins.STB_O;
wire 			RemoveCP_cyc_o	 = UUT.RemoveCP_ins.CYC_O;
wire 			RemoveCP_ack_o	 = UUT.RemoveCP_ins.ACK_O;

wire [31:0] FFT_datout 	= UUT.FFT_ins.DAT_O;
wire 			FFT_we_o		= UUT.FFT_ins.WE_O;
wire 			FFT_stb_o	= UUT.FFT_ins.STB_O;
wire 			FFT_cyc_o	= UUT.FFT_ins.CYC_O;
wire 			FFT_ack_o	= UUT.FFT_ins.ACK_O;

wire [31:0] iCFO_EstComp_datout 	= UUT.iCFO_EstComp_ins.DAT_O;
wire 			iCFO_EstComp_we_o		= UUT.iCFO_EstComp_ins.WE_O;
wire 			iCFO_EstComp_stb_o	= UUT.iCFO_EstComp_ins.STB_O;
wire 			iCFO_EstComp_cyc_o	= UUT.iCFO_EstComp_ins.CYC_O;
wire 			iCFO_EstComp_ack_o	= UUT.iCFO_EstComp_ins.ACK_O;

wire [31:0] Ch_EstEqu_datout 	= UUT.Ch_EstEqu_ins.DAT_O;
wire 			Ch_EstEqu_we_o		= UUT.Ch_EstEqu_ins.WE_O;
wire 			Ch_EstEqu_stb_o	= UUT.Ch_EstEqu_ins.STB_O;
wire 			Ch_EstEqu_cyc_o	= UUT.Ch_EstEqu_ins.CYC_O;
wire 			Ch_EstEqu_ack_o	= UUT.Ch_EstEqu_ins.ACK_O;

wire [31:0] PhaseTrack_datout = UUT.PhaseTrack_ins.DAT_O;
wire 			PhaseTrack_we_o	= UUT.PhaseTrack_ins.WE_O;
wire 			PhaseTrack_stb_o	= UUT.PhaseTrack_ins.STB_O;
wire 			PhaseTrack_cyc_o	= UUT.PhaseTrack_ins.CYC_O;
wire 			PhaseTrack_ack_o	= UUT.PhaseTrack_ins.ACK_O;
wire 			PhaseTrack_ack_i	= UUT.PhaseTrack_ins.ACK_I;


parameter    NSAM  = 10*(256+32);
reg [1:0] 	 datin [NSAM - 1:0];
integer 	ii, lop_cnt;
integer  Len, NLOP, para_fin;


initial 	begin
		rst 		= 1'b1;
		clk 		= 1'b0;	
		we_i		= 1'b0;
		stb_i		= 1'b0;
		cyc_i		= 1'b0;
		ii 		= 0;
		dat_in	= 2'd0;
		
		para_fin = $fopen("./MATLAB/OFDM_SYS_tb/OFDM_TX_bit_symbols_Len.txt","r");
		$fscanf(para_fin, "%d ", Len);
		$fscanf(para_fin, "%d ", NLOP);
		$fclose(para_fin);

		$readmemh("./MATLAB/OFDM_SYS_tb/OFDM_TX_bit_symbols.txt", datin);
	
	#25rst		= 1'b0;
end

always #10 	clk 		= ~clk;

reg wr_datin, wr_frm_pp;	

reg 		wr_frm; 
initial 	begin	
	wr_frm   = 1'b0; 
	wr_datin = 1'b1;
	ack_i    = 1'b1;
	lop_cnt  = 0;
	#600;
	forever begin
		@(posedge clk);
				
		if (~(lop_cnt == NLOP)) begin
			ii=0;
			wr_frm   = 1'b1;
			dat_in 	<= datin[ii + lop_cnt*Len];			
			@(negedge cyc_o);
			#600;
			lop_cnt = lop_cnt +1;
		end
	end
end	

	
always @(posedge clk) begin	
	if(rst) 	begin
		ii <= 0;	
		dat_in <= datin[ii + lop_cnt*Len];	
		wr_frm_pp <= 1'b0;
		end
	else if(wr_frm) begin
		cyc_i 	 <= 1'b1; 	
		wr_frm_pp <= wr_frm;
		
		if (~wr_datin) begin	
			stb_i		<= 1'b0;
			cyc_i		<= 1'b0;
			we_i 		<= 1'b0;
			end
		else if (~wr_frm_pp) begin
			wr_frm_pp <= wr_frm;
			ii 		<= ii+1;	
			stb_i		<= 1'b1;
			cyc_i		<= 1'b1;	
			we_i		<= 1'b1;	
			end
		else if ((ii == Len)&(ack_o)) begin 
			we_i		<= 1'b0;
			stb_i		<= 1'b0;
			cyc_i		<= 1'b0;	
			wr_frm	<= 1'b0;
			end
		else if (ack_o) begin
			//dat_in 	<= dat_in + 1'b1;	
			dat_in 	<= datin[ii + lop_cnt*Len];
			ii 		<= ii+1;	
			stb_i		<= 1'b1;
			cyc_i		<= 1'b1;
			we_i		<= 1'b1;	
			end	
		end			
	else begin
		wr_frm_pp <= wr_frm;
		we_i		<= 1'b0;
		stb_i		<= 1'b0;
		cyc_i		<= 1'b0;
		end	

end

integer datout_fo, datout_cnt;
integer Pilots_Insert_datout_Re_fo, Pilots_Insert_datout_Im_fo;
integer IFFT_Mod_datout_Re_fo, 		IFFT_Mod_datout_Im_fo;
integer Tx_Out_datout_Re_fo, 			Tx_Out_datout_Im_fo;

integer Ch_Sim_datout_Re_fo, 			Ch_Sim_datout_Im_fo;

integer Synch_datout_Re_fo, 			Synch_datout_Im_fo;     
integer FreComp_datout_Re_fo, 		FreComp_datout_Im_fo, 			FreComp_phase_rot_fo;
integer RemoveCP_datout_Re_fo, 		RemoveCP_datout_Im_fo;
integer FFT_datout_Re_fo, 				FFT_datout_Im_fo;
integer iCFO_EstComp_datout_Re_fo, 	iCFO_EstComp_datout_Im_fo;
integer Ch_EstEqu_datout_Re_fo, 		Ch_EstEqu_datout_Im_fo;
integer PhaseTrack_datout_Re_fo, 	PhaseTrack_datout_Im_fo;


initial begin
	datout_cnt = 0;	
	datout_fo = $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_SYS_datout.txt");		
	
	
	Pilots_Insert_datout_Re_fo = $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_TX_1_Pilots_Insert_Re.txt");		
	Pilots_Insert_datout_Im_fo = $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_TX_1_Pilots_Insert_Im.txt");
	IFFT_Mod_datout_Re_fo 		= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_TX_2_IFFT_Mod_Re.txt");		
	IFFT_Mod_datout_Im_fo 		= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_TX_2_IFFT_Mod_Im.txt");
	Tx_Out_datout_Re_fo 			= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_TX_3_Tx_Out_Re.txt");		
	Tx_Out_datout_Im_fo 			= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_TX_3_Tx_Out_Im.txt");
	
	Ch_Sim_datout_Re_fo 			= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_SYS_Ch_Sim_Re.txt");		
	Ch_Sim_datout_Im_fo 			= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_SYS_Ch_Sim_Im.txt");
	
	Synch_datout_Re_fo 			= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_RX_1_Synch_datout_Re.txt");	
	Synch_datout_Im_fo 			= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_RX_1_Synch_datout_Im.txt");	
	FreComp_datout_Re_fo 		= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_RX_2_FreComp_datout_Re.txt");
	FreComp_datout_Im_fo 		= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_RX_2_FreComp_datout_Im.txt");
	FreComp_phase_rot_fo 		= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_RX_2_FreComp_phase_rot.txt");	
	RemoveCP_datout_Re_fo 		= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_RX_3_RemoveCP_datout_Re.txt");
	RemoveCP_datout_Im_fo 		= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_RX_3_RemoveCP_datout_Im.txt");
	FFT_datout_Re_fo 				= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_RX_4_FFT_datout_Re.txt");	
	FFT_datout_Im_fo 				= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_RX_4_FFT_datout_Im.txt");	
	iCFO_EstComp_datout_Re_fo  = $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_RX_5_iCFO_EstComp_datout_Re.txt");	
	iCFO_EstComp_datout_Im_fo  = $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_RX_5_iCFO_EstComp_datout_Im.txt");
	Ch_EstEqu_datout_Re_fo 		= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_RX_6_Ch_EstEqu_datout_Re.txt");	
	Ch_EstEqu_datout_Im_fo 		= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_RX_6_Ch_EstEqu_datout_Im.txt");	
	PhaseTrack_datout_Re_fo 	= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_RX_7_PhaseTrack_datout_Re.txt");	
	PhaseTrack_datout_Im_fo 	= $fopen("./MATLAB/OFDM_SYS_tb/RTL_OFDM_RX_7_PhaseTrack_datout_Im.txt");
	
	forever begin
		@(posedge clk);
		if ((we_o)&&(stb_o)&&(cyc_o)&&(ack_i)) begin
			$fwrite(datout_fo,"%d ",dat_out);			
			datout_cnt = datout_cnt + 1;			
			end	
			
		if ((Pilots_Insert_we_o)&&(Pilots_Insert_stb_o)&&(Pilots_Insert_cyc_o)&&(IFFT_Mod_ack_o)) begin
			$fwrite(Pilots_Insert_datout_Re_fo,"%d ",$signed(Pilots_Insert_datout[15:0]));
			$fwrite(Pilots_Insert_datout_Im_fo,"%d ",$signed(Pilots_Insert_datout[31:16]));						
			end
		if ((IFFT_Mod_we_o)&&(IFFT_Mod_stb_o)&&(IFFT_Mod_cyc_o)&&(Tx_Out_ack_o)) begin
			$fwrite(IFFT_Mod_datout_Re_fo,"%d ",$signed(IFFT_Mod_datout[15:0]));
			$fwrite(IFFT_Mod_datout_Im_fo,"%d ",$signed(IFFT_Mod_datout[31:16]));	
			end
		if ((Tx_Out_we_o)&&(Tx_Out_stb_o)&&(Tx_Out_cyc_o)&&(Ch_Sim_ack_o)) begin
			$fwrite(Tx_Out_datout_Re_fo,"%d ",$signed(Tx_Out_datout[15:0]));
			$fwrite(Tx_Out_datout_Im_fo,"%d ",$signed(Tx_Out_datout[31:16]));		
			end
			
			
		if ((Ch_Sim_we_o) & (Ch_Sim_stb_o) & (Ch_Sim_cyc_o) &(Synch_ack_o)) begin 
			$fwrite(Ch_Sim_datout_Re_fo,"%d ", $signed(Ch_Sim_datout[15:0])); 	
			$fwrite(Ch_Sim_datout_Im_fo,"%d ", $signed(Ch_Sim_datout[31:16])); 			
			end
			
		
		if ((Synch_we_o) & (Synch_stb_o) & (Synch_cyc_o) &(FreComp_ack_o)) begin 
			$fwrite(Synch_datout_Re_fo,"%d ", $signed(Synch_datout[15:0])); 	
			$fwrite(Synch_datout_Im_fo,"%d ", $signed(Synch_datout[31:16])); 			
			end
		if ((FreComp_we_o) & (FreComp_stb_o) & (FreComp_cyc_o) &(RemoveCP_ack_o)) begin	
			$fwrite(FreComp_datout_Re_fo,"%d ", $signed(FreComp_datout[15:0]));
			$fwrite(FreComp_datout_Im_fo,"%d ", $signed(FreComp_datout[31:16]));				
			end
		if (FreComp_phase_acc_rdy & FreComp_phase_acc_ce) begin			
			$fwrite(FreComp_phase_rot_fo,"%d ",$signed(FreComp_phase_rot));			
		end	
		if ((RemoveCP_we_o) & (RemoveCP_stb_o) & (RemoveCP_cyc_o) &(FFT_ack_o)) begin	
			$fwrite(RemoveCP_datout_Re_fo,"%d ", $signed(RemoveCP_datout[15:0]));
			$fwrite(RemoveCP_datout_Im_fo,"%d ", $signed(RemoveCP_datout[31:16]));
			end
		if ((FFT_we_o) & (FFT_stb_o) & (FFT_cyc_o) &(iCFO_EstComp_ack_o)) begin 
			$fwrite(FFT_datout_Re_fo,"%d ", $signed(FFT_datout[15:0]));		
			$fwrite(FFT_datout_Im_fo,"%d ", $signed(FFT_datout[31:16]));					
			end
		if ((iCFO_EstComp_we_o) & (iCFO_EstComp_stb_o) & (iCFO_EstComp_cyc_o) &(Ch_EstEqu_ack_o)) begin 
			$fwrite(iCFO_EstComp_datout_Re_fo,"%d ", $signed(iCFO_EstComp_datout[15:0]));		
			$fwrite(iCFO_EstComp_datout_Im_fo,"%d ", $signed(iCFO_EstComp_datout[31:16]));					
			end	
		if ((Ch_EstEqu_we_o) & (Ch_EstEqu_stb_o) & (Ch_EstEqu_cyc_o) &(PhaseTrack_ack_o)) begin 
			$fwrite(Ch_EstEqu_datout_Re_fo,"%d ", $signed(Ch_EstEqu_datout[15:0]));		
			$fwrite(Ch_EstEqu_datout_Im_fo,"%d ", $signed(Ch_EstEqu_datout[31:16]));								
			end
		if ((PhaseTrack_we_o) & (PhaseTrack_stb_o) & (PhaseTrack_cyc_o) & (PhaseTrack_ack_i)) begin 
			$fwrite(PhaseTrack_datout_Re_fo,"%d ", $signed(PhaseTrack_datout[15:0]));		
			$fwrite(PhaseTrack_datout_Im_fo,"%d ", $signed(PhaseTrack_datout[31:16]));		
			end
	end
end

reg stop_chk;
initial  begin
	stop_chk = 1'b0;
	//#30000	stop_chk = 1'b1;
	forever begin
		@(posedge clk);				
		if (lop_cnt == NLOP) begin
			#100;
			stop_chk = 1'b1;
		end
	end
end
initial begin
	forever begin
	@(posedge clk);
	if (stop_chk)	begin
		$fclose(datout_fo);
		
		$fclose(Pilots_Insert_datout_Re_fo);
		$fclose(Pilots_Insert_datout_Im_fo);		
		$fclose(IFFT_Mod_datout_Re_fo);
		$fclose(IFFT_Mod_datout_Im_fo);		
		$fclose(Tx_Out_datout_Re_fo);
		$fclose(Tx_Out_datout_Im_fo);
		
		$fclose(Ch_Sim_datout_Re_fo);
		$fclose(Ch_Sim_datout_Im_fo);
		
		$fclose(Synch_datout_Re_fo);
		$fclose(Synch_datout_Im_fo);
		$fclose(FreComp_datout_Re_fo);
		$fclose(FreComp_datout_Im_fo);
		$fclose(FreComp_phase_rot_fo);
		$fclose(RemoveCP_datout_Re_fo);
		$fclose(RemoveCP_datout_Im_fo);
		$fclose(FFT_datout_Re_fo);
		$fclose(FFT_datout_Im_fo);
		$fclose(iCFO_EstComp_datout_Re_fo);
		$fclose(iCFO_EstComp_datout_Im_fo);
		$fclose(Ch_EstEqu_datout_Re_fo);
		$fclose(Ch_EstEqu_datout_Im_fo);
		$fclose(PhaseTrack_datout_Re_fo);
		$fclose(PhaseTrack_datout_Im_fo);		
		
		$stop;
		end		
	end
end

endmodule
