close all

NLOP = 1;    % number of loop
NFFT = 256;      % Number of FFT points
NC   = 192;      % Number of subcarriers
NDS  = 2;        % Number of Data symbol per frame
NS   = NDS*NLOP;   % number of symbols
NP   = 8;        % Number of pilots in symbol -88 -63 -38 -13 13 38 63 88
CP   = 32;       % cyclic prefix length
PRE  = 2;        % preamble symbol = 2

% Read data in ============================================================
Para_fid = fopen('OFDM_TX_bit_symbols_Len.txt', 'r');
Para = fscanf(Para_fid, '%d ');
Sym_len  = Para(1);
NLOP  = Para(2);
SNR  = Para(3);
toff = Para(4);
FOFF = Para(5);
fclose(Para_fid);
t_peak = toff + 32 + 3 * 64;
t_cor = toff + 288+1;

NDS  = Sym_len/NC; %number of Data symbol excluding preamble
Flen = (NFFT+CP)*(PRE + NDS);

datin_fid = fopen('OFDM_TX_bit_symbols.txt', 'r');
bit_symbols_in = fscanf(datin_fid, '%d ');
fclose(datin_fid);

datin_fid = fopen('RTL_OFDM_SYS_Ch_Sim_Re.txt', 'r');
dat_Re = fscanf(datin_fid, '%d ');
fclose(datin_fid);

datin_fid = fopen('RTL_OFDM_SYS_Ch_Sim_Im.txt', 'r');
dat_Im = fscanf(datin_fid, '%d ');
fclose(datin_fid);

rx_in =  dat_Re./(2^15) + 1i*dat_Im./(2^15);
rx_in = rx_in.';
rx_in = reshape(rx_in, toff+Flen, NLOP);

% Read data out of RTL ====================================================
%=================== TX process =============================
datout_fid = fopen('RTL_OFDM_TX_1_Pilots_Insert_Re.txt', 'r');
Pilots_Insert_Re_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
datout_fid = fopen('RTL_OFDM_TX_1_Pilots_Insert_Im.txt', 'r');
Pilots_Insert_Im_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
Pilots_Insert_rtl = (Pilots_Insert_Re_rtl./2^15) + 1i*(Pilots_Insert_Im_rtl./2^15);

datout_fid = fopen('RTL_OFDM_TX_2_IFFT_Mod_Re.txt', 'r');
IFFT_Mod_Re_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
datout_fid = fopen('RTL_OFDM_TX_2_IFFT_Mod_Im.txt', 'r');
IFFT_Mod_Im_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
IFFT_Mod_rtl = (IFFT_Mod_Re_rtl./2^15) + 1i*(IFFT_Mod_Im_rtl./2^15);

datout_fid = fopen('RTL_OFDM_TX_3_Tx_Out_Re.txt', 'r');
Tx_Out_Re_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
datout_fid = fopen('RTL_OFDM_TX_3_Tx_Out_Im.txt', 'r');
Tx_Out_Im_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
Tx_Out_rtl = (Tx_Out_Re_rtl./2^15) + 1i*(Tx_Out_Im_rtl./2^15);

%=================== RX process =============================
datout_fid = fopen('RTL_OFDM_RX_1_Synch_datout_Re.txt', 'r');
Synch_datout_Re_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
datout_fid = fopen('RTL_OFDM_RX_1_Synch_datout_Im.txt', 'r');
Synch_datout_Im_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
Synch_datout_rtl = (Synch_datout_Re_rtl./2^15) + 1i*(Synch_datout_Im_rtl./2^15);


datout_fid = fopen('RTL_OFDM_RX_2_FreComp_datout_Re.txt', 'r');
FreComp_datout_Re_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
datout_fid = fopen('RTL_OFDM_RX_2_FreComp_datout_Im.txt', 'r');
FreComp_datout_Im_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
FreComp_datout_rtl = (FreComp_datout_Re_rtl./2^14) + 1i*(FreComp_datout_Im_rtl./2^14);

datout_fid = fopen('RTL_OFDM_RX_2_FreComp_phase_rot.txt', 'r');
FreComp_phase_rot_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
Phase_rot_comp_rtl = FreComp_phase_rot_rtl ./ 2^13;

datout_fid = fopen('RTL_OFDM_RX_3_RemoveCP_datout_Re.txt', 'r');
RemoveCP_datout_Re_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
datout_fid = fopen('RTL_OFDM_RX_3_RemoveCP_datout_Im.txt', 'r');
RemoveCP_datout_Im_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
RemoveCP_datout_rtl = (RemoveCP_datout_Re_rtl./2^14) + 1i*(RemoveCP_datout_Im_rtl./2^14);


datout_fid = fopen('RTL_OFDM_RX_4_FFT_datout_Re.txt', 'r');
FFT_datout_Re_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
datout_fid = fopen('RTL_OFDM_RX_4_FFT_datout_Im.txt', 'r');
FFT_datout_Im_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
FFT_datout_rtl = (FFT_datout_Re_rtl./2^11) + 1i*(FFT_datout_Im_rtl./2^11);

datout_fid = fopen('RTL_OFDM_RX_5_iCFO_EstComp_datout_Re.txt', 'r');
iCFO_EstComp_datout_Re_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
datout_fid = fopen('RTL_OFDM_RX_5_iCFO_EstComp_datout_Im.txt', 'r');
iCFO_EstComp_datout_Im_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
iCFO_EstComp_datout_rtl = (iCFO_EstComp_datout_Re_rtl./2^11) + 1i*(iCFO_EstComp_datout_Im_rtl./2^11);

datout_fid = fopen('RTL_OFDM_RX_6_Ch_EstEqu_datout_Re.txt', 'r');
Ch_EstEqu_datout_Re_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
datout_fid = fopen('RTL_OFDM_RX_6_Ch_EstEqu_datout_Im.txt', 'r');
Ch_EstEqu_datout_Im_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
Ch_EstEqu_datout_rtl = (Ch_EstEqu_datout_Re_rtl./2^9) + 1i*(Ch_EstEqu_datout_Im_rtl./2^9);

datout_fid = fopen('RTL_OFDM_RX_7_PhaseTrack_datout_Re.txt', 'r');
PhaseTrack_datout_Re_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
datout_fid = fopen('RTL_OFDM_RX_7_PhaseTrack_datout_Im.txt', 'r');
PhaseTrack_datout_Im_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
PhaseTrack_datout_rtl = (PhaseTrack_datout_Re_rtl./2^9) + 1i*(PhaseTrack_datout_Im_rtl./2^9);


datout_fid = fopen('RTL_OFDM_SYS_datout.txt', 'r');
OFDM_SYS_datout_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
bit_symbols_rtl = OFDM_SYS_datout_rtl;

% Simulate with data in ===================================================
%=================== TX process =============================
NS   = NDS*NLOP;
bit_symbols = reshape(bit_symbols,NC,NS);
%QPSK =====================================================================
QPSK = 1- 2.*mod(bit_symbols,2) + 1i *(1- 2.*floor(bit_symbols/2));

%insert subcarriers & pilots ==============================================
% pilot ===================================================================
Pil = Pilots(NDS);
Pil = repmat(Pil,1,NLOP);
symbol = [ zeros(1,NS); QPSK(1  :12, :);  ...
              Pil(1,:); QPSK(13 :36, :); ...
              Pil(2,:); QPSK(37 :60, :); ...
              Pil(3,:); QPSK(61 :84, :); ...
              Pil(4,:); QPSK(85 :96, :); ...
           zeros(NFFT-NC-NP-1,NS); ...
                        QPSK(97 :108,:); ...    
              Pil(5,:); QPSK(109:132,:); ...
              Pil(6,:); QPSK(133:156,:); ...
              Pil(7,:); QPSK(157:180,:); ...
              Pil(8,:); QPSK(181:192,:); ];
Pilots_Insert_sim = reshape(symbol, 1, NFFT*NS);
%IFFT =================================================================
tx_d =  ifft(symbol, NFFT);

%Add CP ===============================================================
tx_d = [tx_d(NFFT-CP+1: NFFT,:); tx_d];

IFFT_Mod_sim = reshape(tx_d, 1, (NFFT+CP)*NS);
%Add Preamble =========================================================
tx_out = zeros((NFFT+CP), (PRE + NDS)*NLOP);

[DL_preamble, UL_preamble, pre64, pre128, peven] = preamble_802_16();   
preamb = reshape(DL_preamble, NFFT+CP, PRE);
for ii = 0:NLOP -1,
    tx_out(:,(PRE + NDS)*ii+1) = preamb(:,1);
    tx_out(:,(PRE + NDS)*ii+2) = preamb(:,2);
    if (NDS ~=0 )
        for jj = 1:NDS,
            tx_out(:,(PRE + NDS)*ii+2+jj) = tx_d(:,ii*NDS+jj);            
        end
    end
end
Tx_Out_sim = reshape(tx_out, 1, (NFFT+CP)*(PRE + NDS)*NLOP);

%=================== RX process =============================
datin_fid = fopen('Synch_known_coeff_rtl.txt', 'r');
known_coeff = fscanf(datin_fid, '%d ');
fclose(datin_fid);
known_coeff = [known_coeff; known_coeff]./2;
known_coeff = repmat(known_coeff,1,NLOP);

datin_fid = fopen('Synch_thres_coeff_q05.txt', 'r');
thr_coeff = fscanf(datin_fid, '%f ');
thr_coeff = repmat(thr_coeff, 1, NLOP);
fclose(datin_fid);

[DL_preamble, UL_preamble, pre64, pre128, peven] = preamble_802_16();

R_sim = zeros(Flen,NLOP);  
P_sim = zeros(Flen,NLOP);

R_thr_sim = zeros(Flen,NLOP);  
P_mag_sim = zeros(Flen,NLOP);

Fir_reg = zeros(128,NLOP);
ACR_Mult      = zeros(Flen,NLOP);
ACR_Mult_d128 = zeros(Flen,NLOP);
rx_in_d64     = [zeros(64,NLOP); rx_in];

for d = 1: Flen,
    ACR_Mult(d,:) = conj(rx_in(d,:)) .* rx_in_d64(d,:);    
    if (d==1),  P_sim(d,:) = ACR_Mult(d,:);        
    else        P_sim(d,:) =  P_sim(d-1,:) + ACR_Mult(d,:) - ACR_Mult_d128(1,:);
    end  
    for m = 1:127,
        ACR_Mult_d128(m,:) = ACR_Mult_d128(m+1,:);                     
    end
    ACR_Mult_d128(128,:) = ACR_Mult(d,:);
    P_mag_sim(d,:) = abs(P_sim(d,:));
    for m = 1:127,
        Fir_reg(m,:) = Fir_reg(m+1,:) + abs(rx_in(d,:)).^2 .* known_coeff(128-m+1,:);                     
    end
    Fir_reg(128,:) = abs(rx_in(d,:)).^2 .* known_coeff(1,:);
    R_sim(d,:) = Fir_reg(1,:);
    R_thr_sim(d,:) = R_sim(d,:).* thr_coeff(SNR+1,:);
end

% Timing synchronisation toff_est = t_cor =================================
% & remove short preamble 
Synch_datout = rx_in(t_cor:Flen + toff,:);
Synch_datout_sim = reshape(Synch_datout, (NFFT+CP)*(NDS+1)*NLOP, 1);

% FFO & IFO estimation ====================================================
foff_est_sim = angle(P_sim(t_peak))/64;
FOFF_est_sim = (foff_est_sim * 256) / (2*pi);
noff= round(FOFF / 4)*4;

% use this to compensate both integer & fractional CFO, so do not need the
% rotating symbol and adding pre-integer CFO below ========================
% foff_est_sim = 2*pi*noff/256 - foff_est_sim; 
% =========================================================================

% add pre-rotated IFO to shift integer CFO alway positive =================
preoff= -12;
foff_est_sim = 2*pi*preoff/256 - foff_est_sim;

% FFO compensation with Pre-rotated IFO ===================================
nn = (287+(1:(NFFT+CP)*(NDS+1)))';
nn = repmat(nn,1,NLOP);
Phase_rot_comp = -(foff_est_sim).*nn;
FreComp_datout = Synch_datout .* (exp(1i*Phase_rot_comp));
Phase_rot_comp_sim = reshape(Phase_rot_comp,(NFFT+CP)*(NDS+1)*NLOP,1);
FreComp_datout_sim = reshape(FreComp_datout,(NFFT+CP)*(NDS+1)*NLOP,1);
% Remove Cyclic Prefix  ===================================================
%RemoveCP_datout_sim = [];
%for ii = 1:NLOP,
RemoveCP_datout  = reshape(FreComp_datout,288,NDS+1,NLOP);
RemoveCP_datout(1:32,:,:)= [];
RemoveCP_datout  = reshape(RemoveCP_datout,(NDS+1)*256,NLOP);
RemoveCP_datout_sim = reshape(RemoveCP_datout,(NDS+1)*256*NLOP,1);

% FFT for OFDM symbols demodulation =======================================
FFT_symbol = reshape(RemoveCP_datout_sim,256,NDS+1, NLOP);
FFT_symbol = fft(FFT_symbol,256,1);
FFT_datout = reshape(FFT_symbol,(NDS+1)*256,NLOP);
FFT_datout_sim = reshape(FFT_datout,(NDS+1)*256*NLOP,1);

% Rotate symbol to compensate integer CFO =================================
n_rot = -preoff + noff;
OFDM_symbol_IFO_Comp = zeros(NFFT, NDS+1, NLOP);
OFDM_symbol_IFO_Comp(1:256-n_rot,:,:) = FFT_symbol(n_rot+1:256,:,:);
OFDM_symbol_IFO_Comp(256-n_rot+1:256,:,:) = FFT_symbol(1:n_rot,:,:);
OFDM_symbol = reshape(OFDM_symbol_IFO_Comp,(NDS+1)*256,NLOP);
iCFO_EstComp_datout_sim = reshape(OFDM_symbol, (NDS+1)*NFFT*NLOP,1);

% Channel Estimation & Compensation =======================================
lp = peven([3:2:101 157:2:255]);
rx_carrier = OFDM_symbol_IFO_Comp([2:101 157:256],:,:)/4; % remove DC and guard symbols
rx_carrier = rx_carrier;
pre_car = reshape(rx_carrier(:,1,:),200,NLOP);  %take the long preamble symbol
pre_car = pre_car([2:2:100 101:2:199],:);       %take the even carrier only for channel estimation
dat_car = rx_carrier(:,2:NDS+1,:);

pre_cof = (lp./max(abs(lp))).';
pre_cof = repmat(pre_cof,1,NLOP);
ch_cof = pre_cof .* conj(pre_car);

ch_equ_cof = zeros(200,1,NLOP);
ch_equ_cof([1:2:199],1,:) = ch_cof;
ch_equ_cof([2:2:200],1,:) = ch_cof;

dat_car_equ = dat_car .* repmat(ch_equ_cof,1,NDS);
dat_car_reorder = zeros(200,NDS,NLOP);

dat_car_reorder(1:8,:,:)= dat_car_equ([13 38 63 88 113 138 163 188],:,:);
dat_car_reorder(9:200,:,:)= dat_car_equ([1:12 14:37 39:62 64:87 89:112 114:137 ...
                                       139:162 164:187 189:200],:,:);
                                   
Ch_EstEqu_datout_sim = reshape(dat_car_reorder,NDS*200*NLOP,1);

%==========================================================================
Ph_datin = dat_car_reorder/4;
Ph_pil_sim = Ph_datin(1:8,:,:);
Ph_dat_sim = Ph_datin(9:200,:,:);
Pil = Pilots(NDS);
Pil_ref = Pil /sqrt(2);
Ph_pil = zeros(8,NDS,NLOP);
Ph_est = zeros(NFFT,NDS,NLOP);
for ii = 1:NLOP,
    Ph_pil(:,:,ii) =  Ph_pil_sim(:,:,ii) .* conj(Pil_ref);

    Var1   = sum(real(Ph_pil(1:8,:,ii))); % = 8cosbi - 4NFFT*asinbi
    Var2   = sum(real(Ph_pil([3 4 7 8],:,ii))); % = 4cosbi - 2NFFT*asinbi - (63+88-13-38)*asinbi
    asinbi = (1/(128))*((Var1/2) - Var2);
    cosbi  = (1/8)*(Var1 + 4*NFFT*asinbi);

    Var3   = sum(imag(Ph_pil(1:8,:,ii))); % = 8sinbi + 4NFFT*acosbi
    Var4   = sum(imag(Ph_pil([3 4 7 8],:,ii))); % = 4sinbi + 2NFFT*acosbi + (63+88-13-38)*acosbi
    acosbi = (1/(128))*(Var4 - (Var3/2));
    sinbi  = (1/8)*(Var3 - 4*NFFT*acosbi);

    %Ph_est = zeros(NFFT,NDS);
    k=(0:NFFT-1).';
    for n = 1:NDS,
        Ph_est(:,n,ii) = (cosbi(n) - asinbi(n) * k) + 1i.*(sinbi(n) + acosbi(n)*k);
        %Ph_est(:,n,ii) = (cosbi(n) - 0 * k) + 1i.*(sinbi(n) + 0*k);
    end

    Pilot_indices = [14 39 64 89 169 194 219 244];          
end
    Ph_est([1 Pilot_indices 102:156],:,:) = [];
    Ph_est_sim = reshape(Ph_est, NDS*192*NLOP, 1);
    PhaseTrack_datout_sim = Ph_dat_sim .* conj(Ph_est);
    PhaseTrack_datout_sim = reshape(PhaseTrack_datout_sim, NDS*192*NLOP,1);
%==========================================================================
% QPSK symbol demodulation ================================================
bit_symbols_sim = 2*(imag(PhaseTrack_datout_sim)<0) + 1*(real(PhaseTrack_datout_sim)<0);
%bit_symbols_sim = reshape(bit_symbols_sim,NDS*size(bit_symbols_sim,1),1);

% Compare Simulation vs RTL ===============================================
figure(21);
hold on
plot(1:length(Pilots_Insert_rtl), real(Pilots_Insert_rtl),'o-b');
plot(1:length(Pilots_Insert_sim), real(Pilots_Insert_sim),'x-r');
ylim([-3 3]);
title ('Pilots\_Insert\_rtl vs Pilots\_Insert\_sim')
legend('Pilots\_Insert\_rtl','Pilots\_Insert\_sim')

figure(22);
hold on
plot(1:length(IFFT_Mod_rtl), real(IFFT_Mod_rtl),'o-b');
plot(1:length(IFFT_Mod_sim), real(IFFT_Mod_sim),'x-r');
title ('IFFT\_Mod\_rtl vs IFFT\_Mod\_sim')
legend('IFFT\_Mod\_rtl','IFFT\_Mod\_sim')

figure(23);
hold on
plot(1:length(Tx_Out_rtl), real(Tx_Out_rtl),'x-r');
plot(1:length(Tx_Out_sim), real(Tx_Out_sim),'o-b');
title ('Tx\_Out\_rtl vs Tx\_Out\_sim')
legend('Tx\_Out\_rtl','Tx\_Out\_sim')

figure(1)
hold on
plot(1:length(Synch_datout_rtl), real(Synch_datout_rtl),'x-r');
plot(1:length(Synch_datout_sim), real(Synch_datout_sim),'o-b');
title ('Synch\_datout\_rtl vs Synch\_datout\_sim')
legend('Synch\_datout\_rtl','Synch\_datout\_sim')
%xlim([1 1000]);

figure(2)
hold on
plot(1:length(Phase_rot_comp_rtl),Phase_rot_comp_rtl,'x-r');
plot(1:length(Phase_rot_comp_sim),angle(exp(1i*Phase_rot_comp_sim)),'o-b');
title ('Phase\_rot\_comp\_rtl vs Phase\_rot\_comp\_sim')
legend('Phase\_rot\_comp\_rtl','Phase\_rot\_comp\_sim')


figure(3)
hold on
plot(1:length(FreComp_datout_rtl), imag(FreComp_datout_rtl),'x-r');
plot(1:length(FreComp_datout_sim), imag(FreComp_datout_sim),'o-b');
title ('FreComp\_datout\_rtl vs FreComp\_datout\_sim')
legend('FreComp\_datout\_rtl','FreComp\_datout\_sim')

figure(4)
hold on
plot(1:length(RemoveCP_datout_rtl), real(RemoveCP_datout_rtl),'x-r');
plot(1:length(RemoveCP_datout_sim), real(RemoveCP_datout_sim),'o-b');
title ('RemoveCP\_datout\_rtl vs RemoveCP\_datout\_sim')

figure(5)
hold on
plot(1:length(FFT_datout_rtl), real(FFT_datout_rtl),'x-r');
plot(1:length(FFT_datout_sim), real(FFT_datout_sim),'o-b');
title ('FFT\_datout\_rtl vs FFT\_datout\_sim')
legend ('FFT\_datout\_rtl','FFT\_datout\_sim')

figure(6)
hold on
plot(1:length(iCFO_EstComp_datout_rtl), abs(iCFO_EstComp_datout_rtl),'x-r');
plot(1:length(iCFO_EstComp_datout_sim), abs(iCFO_EstComp_datout_sim),'o-b');
title ('iCFO\_EstComp\_datout\_rtl vs iCFO\_EstComp\_datout\_sim')
legend ('iCFO\_EstComp\_datout\_rtl','iCFO\_EstComp\_datout\_sim')

figure(7)
hold on
plot(1:length(Ch_EstEqu_datout_rtl), real(Ch_EstEqu_datout_rtl),'x-r');
plot(1:length(Ch_EstEqu_datout_sim), real(Ch_EstEqu_datout_sim),'o-b');
title ('Ch\_EstEqu\_datout\_rtl vs Ch\_EstEqu\_datout\_sim')
legend('Ch\_EstEqu\_datout\_rtl', 'Ch\_EstEqu\_datout\_sim')

figure(8)
hold on
plot(1:length(PhaseTrack_datout_rtl), imag(PhaseTrack_datout_rtl),'x-r');
plot(1:length(PhaseTrack_datout_sim), imag(PhaseTrack_datout_sim),'o-b');
title ('PhaseTrack\_datout\_rtl vs PhaseTrack\_datout\_sim')
legend('PhaseTrack\_datout\_rtl', 'PhaseTrack\_datout\_sim')

figure(10)
hold on
plot(1:length(bit_symbols_rtl), bit_symbols_rtl,'x-r');
plot(1:length(bit_symbols_in), bit_symbols_in,'o-b');
title ('bit\_symbols\_rtl vs bit\_symbols\_in')
legend('bit\_symbols\_rtl','bit\_symbols\_in')

figure(11)
hold on
plot(1:length(bit_symbols_in), bit_symbols_in,'x-r');
plot(1:length(bit_symbols_sim), bit_symbols_sim,'o-b');
title ('bit\_symbols\_in vs bit\_symbols\_sim')
legend('bit\_symbols\_in','bit\_symbols\_sim')
ylim([-1 4]);

figure(12)
hold on
plot(1:length(bit_symbols_rtl), bit_symbols_rtl,'x-r');
plot(1:length(bit_symbols_sim), bit_symbols_sim,'o-b');
title ('bit\_symbols\_rtl vs bit\_symbols\_sim')
legend('bit\_symbols\_rtl','bit\_symbols\_sim')
ylim([-1 4]);

L_pre_pattern = abs((FFT_datout_sim(1:256))).^2;
figure(13)
hold on
plot(1:length(peven), L_pre_pattern,'x-r');
plot(1:length(peven), abs(peven).^2,'o-b');
title ('L\_pre\_pattern vs abs(peven).^2')
legend('L\_pre\_pattern','abs(peven).^2')
ylim([-1 5]);




