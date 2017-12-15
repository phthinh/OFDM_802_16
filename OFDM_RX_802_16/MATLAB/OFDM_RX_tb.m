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
Para_fid = fopen('RTL_OFDM_RX_datin_len.txt', 'r');
Para = fscanf(Para_fid, '%d ');
NLOP = Para(1);
Flen  = Para(2);
SNR  = Para(3);
toff = Para(4);
fclose(Para_fid);
t_peak = toff + 32 + 3 * 64;
t_cor = toff + 288+1;

NDS = (Flen-toff)/288 - 2; %number of Data symbol excluding preamble

datin_fid = fopen('OFDM_RX_bit_symbols.txt', 'r');
bit_symbols_in = fscanf(datin_fid, '%d ');
fclose(datin_fid);

datin_fid = fopen('OFDM_RX_datin_Re.txt', 'r');
dat_Re = fscanf(datin_fid, '%f ');
fclose(datin_fid);

datin_fid = fopen('OFDM_RX_datin_Im.txt', 'r');
dat_Im = fscanf(datin_fid, '%f ');
fclose(datin_fid);

rx_in =  dat_Re + 1i*dat_Im;
rx_in = rx_in.';
rx_in = reshape(rx_in, Flen, NLOP);

% Read data out of RTL ====================================================
datout_fid = fopen('RTL_OFDM_RX_datout.txt', 'r');
OFDM_RX_datout_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
%===== Remove Long Preamble ========== 
%bit_symbols_rtl = OFDM_RX_datout_rtl((length(OFDM_RX_datout_rtl) - NDS*256 + 1): ...
%                                      length(OFDM_RX_datout_rtl));

%===== Remove pilot ==========                                 
% bit_symbols_rtl = reshape(bit_symbols_rtl,256,NDS);
% bit_frm_rtl = bit_symbols_rtl;
% bit_symbols_rtl(244,:) = [];
% bit_symbols_rtl(219,:) = [];
% bit_symbols_rtl(194,:) = [];
% bit_symbols_rtl(169,:) = [];
% bit_symbols_rtl(102:156,:) = [];
% bit_symbols_rtl(89,:) = [];
% bit_symbols_rtl(64,:) = [];
% bit_symbols_rtl(39,:) = [];
% bit_symbols_rtl(14,:) = [];
% bit_symbols_rtl(1,:) = [];
% bit_symbols_rtl = reshape(bit_symbols_rtl,NDS*size(bit_symbols_rtl,1),1);

datout_fid = fopen('RTL_OFDM_RX_Synch_datout_Re.txt', 'r');
Synch_datout_Re_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
datout_fid = fopen('RTL_OFDM_RX_Synch_datout_Im.txt', 'r');
Synch_datout_Im_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
Synch_datout_rtl = (Synch_datout_Re_rtl./2^14) + 1i*(Synch_datout_Im_rtl./2^14);


% datout_fid = fopen('RTL_OFDM_RX_FreComp_datout_Re.txt', 'r');
% FreComp_datout_Re_rtl = fscanf(datout_fid, '%d ');
% fclose(datout_fid);
% datout_fid = fopen('RTL_OFDM_RX_FreComp_datout_Im.txt', 'r');
% FreComp_datout_Im_rtl = fscanf(datout_fid, '%d ');
% fclose(datout_fid);
% FreComp_datout_rtl = (FreComp_datout_Re_rtl./2^14) + 1i*(FreComp_datout_Im_rtl./2^14);

% datout_fid = fopen('RTL_OFDM_RX_FreComp_phase_rot.txt', 'r');
% FreComp_phase_rot_rtl = fscanf(datout_fid, '%d ');
% fclose(datout_fid);
% Phase_rot_comp_rtl = FreComp_phase_rot_rtl ./ 2^13;

datout_fid = fopen('RTL_OFDM_RX_RemoveCP_datout_Re.txt', 'r');
RemoveCP_datout_Re_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
datout_fid = fopen('RTL_OFDM_RX_RemoveCP_datout_Im.txt', 'r');
RemoveCP_datout_Im_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
RemoveCP_datout_rtl = (RemoveCP_datout_Re_rtl./2^14) + 1i*(RemoveCP_datout_Im_rtl./2^14);


datout_fid = fopen('RTL_OFDM_RX_FFT_datout_Re.txt', 'r');
FFT_datout_Re_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
datout_fid = fopen('RTL_OFDM_RX_FFT_datout_Im.txt', 'r');
FFT_datout_Im_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
FFT_datout_rtl = (FFT_datout_Re_rtl./2^11) + 1i*(FFT_datout_Im_rtl./2^11);

% datout_fid = fopen('RTL_OFDM_RX_iCFO_EstComp_datout_Re.txt', 'r');
% iCFO_EstComp_datout_Re_rtl = fscanf(datout_fid, '%d ');
% fclose(datout_fid);
% datout_fid = fopen('RTL_OFDM_RX_iCFO_EstComp_datout_Im.txt', 'r');
% iCFO_EstComp_datout_Im_rtl = fscanf(datout_fid, '%d ');
% fclose(datout_fid);
% iCFO_EstComp_datout_rtl = (iCFO_EstComp_datout_Re_rtl./2^11) + 1i*(iCFO_EstComp_datout_Im_rtl./2^11);

datout_fid = fopen('RTL_OFDM_RX_Ch_EstEqu_datout_Re.txt', 'r');
Ch_EstEqu_datout_Re_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
datout_fid = fopen('RTL_OFDM_RX_Ch_EstEqu_datout_Im.txt', 'r');
Ch_EstEqu_datout_Im_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
Ch_EstEqu_datout_rtl = (Ch_EstEqu_datout_Re_rtl./2^6) + 1i*(Ch_EstEqu_datout_Im_rtl./2^6);

datout_fid = fopen('RTL_OFDM_RX_PhaseTrack_datout_Re.txt', 'r');
PhaseTrack_datout_Re_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
datout_fid = fopen('RTL_OFDM_RX_PhaseTrack_datout_Im.txt', 'r');
PhaseTrack_datout_Im_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
PhaseTrack_datout_rtl = (PhaseTrack_datout_Re_rtl./2^0) + 1i*(PhaseTrack_datout_Im_rtl./2^0);

% Simulate with data in ===================================================
datin_fid = fopen('Synch_known_coeff_rtl.txt', 'r');
known_coeff = fscanf(datin_fid, '%d ');
fclose(datin_fid);
known_coeff = [known_coeff; known_coeff]./2;
known_coeff = repmat(known_coeff,1,NLOP);

% datin_fid = fopen('Synch_thres_coeff_q05.txt', 'r');
% thr_coeff = fscanf(datin_fid, '%f ');
% thr_coeff = repmat(thr_coeff, 1, NLOP);
% fclose(datin_fid);

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
    %R_thr_sim(d,:) = R_sim(d,:).* thr_coeff(SNR+1,:);
    R_thr_sim(d,:) = R_sim(d,:).* 0.5;
end

% Timing synchronisation toff_est = t_cor =================================
% & remove short preamble 
Synch_datout = rx_in(t_cor:Flen ,:);
% Synch_datout_sim = reshape(Synch_datout, (NFFT+CP)*(NDS+1)*NLOP, 1);

% FFO & IFO estimation ====================================================
foff_est_sim = angle(P_sim(t_peak))/64;
% FOFF_est_sim = (foff_est_sim * 256) / (2*pi)
% noff= round(FOFF / 4)*4;

% use this to compensate both integer & fractional CFO, so do not need the
% rotating symbol and adding pre-integer CFO below ========================
% foff_est_sim = 2*pi*noff/256 - foff_est_sim; 
% =========================================================================

% add pre-rotated IFO to shift integer CFO alway positive =================
% preoff= -12;
% %preoff = 0;
% foff_est_sim = 2*pi*preoff/256 - foff_est_sim;
% foff_est_sim = floor(foff_est_sim *2^13) /2^13
% % FFO compensation with Pre-rotated IFO ===================================
% %nn = (287+(1:(NFFT+CP)*(NDS+1)))';
nn = ((0:(NFFT+CP)*(NDS+1)-1))';

nn = repmat(nn,1,NLOP);
Phase_rot_comp = -(foff_est_sim).*nn;
FreComp_datout = Synch_datout .* (exp(1i*Phase_rot_comp));
Phase_rot_comp_sim = reshape(Phase_rot_comp,(NFFT+CP)*(NDS+1)*NLOP,1);
Synch_datout_sim = reshape(FreComp_datout,(NFFT+CP)*(NDS+1)*NLOP,1);

% Remove Cyclic Prefix  ===================================================
%RemoveCP_datout_sim = [];
%for ii = 1:NLOP,
RemoveCP_datout  = reshape(FreComp_datout,NFFT+CP,NDS+1,NLOP);
RemoveCP_datout(1:CP,:,:)= [];
RemoveCP_datout  = reshape(RemoveCP_datout,(NDS+1)*NFFT,NLOP);
RemoveCP_datout_sim = reshape(RemoveCP_datout,(NDS+1)*NFFT*NLOP,1);

% FFT for OFDM symbols demodulation =======================================
FFT_symbol = reshape(RemoveCP_datout_sim,NFFT,NDS+1, NLOP);
FFT_symbol = fft(FFT_symbol,NFFT,1);
FFT_datout = reshape(FFT_symbol,(NDS+1)*NFFT,NLOP);
FFT_datout_sim = reshape(FFT_datout,(NDS+1)*NFFT*NLOP,1);
% 
% % Rotate symbol to compensate integer CFO =================================
% n_rot = -preoff + noff;
% OFDM_symbol_IFO_Comp = zeros(NFFT, NDS+1, NLOP);
% OFDM_symbol_IFO_Comp(1:256-n_rot,:,:) = FFT_symbol(n_rot+1:256,:,:);
% OFDM_symbol_IFO_Comp(256-n_rot+1:256,:,:) = FFT_symbol(1:n_rot,:,:);
% OFDM_symbol = reshape(OFDM_symbol_IFO_Comp,(NDS+1)*256,NLOP);
% iCFO_EstComp_datout_sim = reshape(OFDM_symbol, (NDS+1)*NFFT*NLOP,1);

% Channel Estimation & Compensation =======================================

FFT_datout = reshape(FFT_datout,NFFT,NDS+1, NLOP);
Ch_EstEqu_datout = zeros(NDS*(NC+NP),NLOP);
for ii = 1:NLOP,
    ch_est = peven.' .* conj(FFT_datout(:,1,ii));
    ch_est([2:2:100, 158:2:256]) = ch_est([3:2:101, 157:2:255]);
    ch_datout = FFT_datout(:,2:NDS+1,ii) .* repmat(ch_est,1,NDS);
    ch_datout(102:156,:)=[];
    ch_datout(1,:)=[];
    Ch_EstEqu_datout(:,ii) = reshape(ch_datout,(NC+NP)*NDS,1);                         
end
Ch_EstEqu_datout_sim = reshape(Ch_EstEqu_datout,NDS*(NC+NP)*NLOP,1);

%==========================================================================
Pil_ref = [1 1 -1 -1 -1 1 -1 1].';
Pil_ref = repmat(Pil_ref,1,NDS);
Pil_ind = [13 38 63 88 113 138 163 188].';
PhaseTrack_datin = reshape(Ch_EstEqu_datout,(NC+NP),NDS,NLOP);
PhaseTrack_datout = zeros(NDS*(NC+NP),NLOP);
for ii = 1:NLOP,
    Rx_Pil = PhaseTrack_datin(Pil_ind,:,ii);
    %Rx_Pil = Rx_Pil ./ (abs(Rx_Pil));
    Ph_est = 1/8*(sum(Rx_Pil .* Pil_ref));
    Ph_comp = ones((NC+NP),1) * conj(Ph_est);
    PhaseTrack_comp = PhaseTrack_datin(:,:,ii) .* Ph_comp;
    PhaseTrack_datout(:,ii) = reshape(PhaseTrack_comp,(NC+NP)*NDS,1);
end
PhaseTrack_datout_sim = reshape(PhaseTrack_datout, NDS*(NC+NP)*NLOP,1);

%==========================================================================



% QPSK symbol demodulation ================================================
bit_symbols_out = 2*(imag(PhaseTrack_datout_sim)>0) + 1*(real(PhaseTrack_datout_sim)>0);
bit_symbols_out = reshape(bit_symbols_out,(NC+NP),NDS,NLOP);
bit_symbols_out(Pil_ind,:,:) =[];
bit_symbols_sim = reshape(bit_symbols_out, NDS*(NC)*NLOP,1);

OFDM_RX_datout_rtl = reshape(OFDM_RX_datout_rtl,(NC+NP),NDS,NLOP);
OFDM_RX_datout_rtl(Pil_ind,:,:) =[];
OFDM_RX_datout_rtl = reshape(OFDM_RX_datout_rtl, NDS*(NC)*NLOP,1);
bit_symbols_rtl = OFDM_RX_datout_rtl;
% bit_symbols_sim = reshape(bit_symbols_sim,NDS*size(bit_symbols_sim,1),1);

% Compare Simulation vs RTL ===============================================
figure(1)
hold on 
plot(1:length(Synch_datout_rtl), real(Synch_datout_rtl),'.-r');
plot(1:length(Synch_datout_sim), real(Synch_datout_sim),'o-b');
title ('Synch\_datout\_rtl vs Synch\_datout\_sim')
legend('Synch\_datout\_rtl','Synch\_datout\_sim')
% xlim([1 1000]);
hold off

% figure(2)
% hold on 
% plot(1:length(Phase_rot_comp_rtl),Phase_rot_comp_rtl,'.-r');
% plot(1:length(Phase_rot_comp_sim),angle(exp(1i*Phase_rot_comp_sim)),'o-g');
% title ('Phase\_rot\_comp\_rtl vs Phase\_rot\_comp\_sim')
% legend('Phase\_rot\_comp\_rtl','Phase\_rot\_comp\_sim')
% hold off

% figure(3)
% hold on 
% plot(1:length(FreComp_datout_rtl), imag(FreComp_datout_rtl),'.-r');
% plot(1:length(FreComp_datout_sim), imag(FreComp_datout_sim),'o-b');
% title ('FreComp\_datout\_rtl vs FreComp\_datout\_sim')
% legend('FreComp\_datout\_rtl','FreComp\_datout\_sim')
% hold off

figure(4)
hold on 
plot(1:length(RemoveCP_datout_rtl), angle(RemoveCP_datout_rtl),'.-r');
plot(1:length(RemoveCP_datout_sim), angle(RemoveCP_datout_sim),'o-b');
title ('RemoveCP\_datout\_rtl vs RemoveCP\_datout\_sim')
hold off

figure(5)
hold on 
plot(1:length(FFT_datout_rtl), real(FFT_datout_rtl),'.-r');
plot(1:length(FFT_datout_sim), real(FFT_datout_sim),'o-b');
title ('FFT\_datout\_rtl vs FFT\_datout\_sim')
legend ('FFT\_datout\_rtl','FFT\_datout\_sim')
hold off

% figure(6)
% hold on 
% plot(1:length(iCFO_EstComp_datout_rtl), real(iCFO_EstComp_datout_rtl),'.-r');
% plot(1:length(iCFO_EstComp_datout_sim), real(iCFO_EstComp_datout_sim),'o-b');
% title ('iCFO\_EstComp\_datout\_rtl vs iCFO\_EstComp\_datout\_sim')
% legend ('iCFO\_EstComp\_datout\_rtl','iCFO\_EstComp\_datout\_sim')
% hold off

figure(7)
hold on 
plot(1:length(Ch_EstEqu_datout_rtl), angle(Ch_EstEqu_datout_rtl),'.-r');
plot(1:length(Ch_EstEqu_datout_sim), angle(Ch_EstEqu_datout_sim),'o-b');
title ('Ch\_EstEqu\_datout\_rtl vs Ch\_EstEqu\_datout\_sim')
legend('Ch\_EstEqu\_datout\_rtl', 'Ch\_EstEqu\_datout\_sim')
hold off

figure(8)
hold on 
plot(1:length(PhaseTrack_datout_rtl), angle(PhaseTrack_datout_rtl),'.-r');
plot(1:length(PhaseTrack_datout_sim), angle(PhaseTrack_datout_sim),'o-b');
title ('PhaseTrack\_datout\_rtl vs PhaseTrack\_datout\_sim')
legend('PhaseTrack\_datout\_rtl', 'PhaseTrack\_datout\_sim')
hold off

figure(10)
hold on 
plot(1:length(bit_symbols_rtl), bit_symbols_rtl,'.-r');
plot(1:length(bit_symbols_in), bit_symbols_in,'o-b');
title ('bit\_symbols\_rtl vs bit\_symbols\_in')
legend('bit\_symbols\_rtl','bit\_symbols\_in')
hold off

figure(11)
hold on 
plot(1:length(bit_symbols_in), bit_symbols_in,'.-r');
plot(1:length(bit_symbols_sim), bit_symbols_sim,'o-b');
title ('bit\_symbols\_in vs bit\_symbols\_sim')
legend('bit\_symbols\_in','bit\_symbols\_sim')
ylim([-1 4]);
hold off

figure(12)
hold on 
plot(1:length(bit_symbols_rtl), bit_symbols_rtl,'.-r');
plot(1:length(bit_symbols_sim), bit_symbols_sim,'o-b');
title ('bit\_symbols\_rtl vs bit\_symbols\_sim')
legend('bit\_symbols\_rtl','bit\_symbols\_sim')
ylim([-1 4]);
hold off

% L_pre_pattern = abs((FFT_datout_sim(1:256)./6)).^2;
% figure(13)
% hold on 
% plot(1:length(peven), L_pre_pattern,'.-r');
% plot(1:length(peven), abs(peven).^2,'x-b');
% title ('L\_pre\_pattern vs abs(peven).^2')
% ylim([-1 5]);
% hold off




