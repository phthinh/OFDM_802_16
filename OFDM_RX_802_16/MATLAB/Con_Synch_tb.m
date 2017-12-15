close all

NLOP = 1;    % number of loop
NFFT = 256;      % Number of FFT points
NC   = 192;      % Number of subcarriers
NDS  = 1;        % Number of Data symbol per frame
NS   = NDS*NLOP; % number of symbols
NP   = 8;        % Number of pilots in symbol -88 -63 -38 -13 13 38 63 88
CP   = 32;       % cyclic prefix length
PRE  = 2;        % preamble symbol = 2



N = 256;
M = N/4;


% Read data in ============================================================
Para_fid = fopen('RTL_OFDM_RX_datin_len.txt', 'r');
Para = fscanf(Para_fid, '%d ');
NLOP = Para(1);
Flen  = Para(2);
SNR  = Para(3);
toff = Para(4);
fclose(Para_fid);

t_peak = toff + 16 + 3 * 16;
t_cor = toff + (PRE-1)*(NFFT+CP) + 1;

NDS = (Flen-toff)/(NFFT+CP) - PRE; %number of Data symbol excluding preamble

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
datout_fid = fopen('RTL_Synch_datout_Re.txt', 'r');
Synch_datout_Re_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
datout_fid = fopen('RTL_Synch_datout_Im.txt', 'r');
Synch_datout_Im_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
Synch_datout_rtl = (Synch_datout_Re_rtl./2^14) + 1i*(Synch_datout_Im_rtl./2^14);

datout_fid = fopen('RTL_Synch_P_metric_Re.txt', 'r');
P_metric_Re_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
datout_fid = fopen('RTL_Synch_P_metric_Im.txt', 'r');
P_metric_Im_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
P_metric_rtl = (P_metric_Re_rtl./2^15) + 1i*(P_metric_Im_rtl./2^15);

datout_fid = fopen('RTL_Synch_R_metric.txt', 'r');
R_metric_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
R_metric_rtl = R_metric_rtl ./ 2^15;

datout_fid = fopen('RTL_Synch_CR_out_mag.txt', 'r');
CR_out_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
%CR_out_rtl = CR_out_rtl ./ 2^15;
% 
% Simulate with data in ===================================================
datin_fid = fopen('../MY_SOURCES/Synch_known_coeff_802_16.txt', 'r');
known_coeff = fscanf(datin_fid, '%d ');
fclose(datin_fid);
known_coeff = repmat(known_coeff,1,NLOP);

[DL_preamble, UL_preamble, pre64, pre128, peven] = preamble_802_16();  
preamble_nor = DL_preamble; 

SynLen = toff+ PRE * (NFFT+CP);

P_sim           = zeros(SynLen,NLOP);
P_Abs_sim       = zeros(SynLen,NLOP);
P_diff          = zeros(SynLen,NLOP);
ACR_Mult        = zeros(SynLen,NLOP);
ACR_Mult_d64    = zeros(SynLen,NLOP);
rx_in_d64       = [zeros(64,NLOP); rx_in];

R_sim = zeros(SynLen,NLOP);  
R_thr_sim = zeros(SynLen,NLOP);  
rx_AbsSqr = abs(rx_in(1:SynLen,:)).^2;
rx_AbsSqr_d64 = [zeros(64,NLOP); abs(rx_in(1:SynLen,:)).^2];

CR_Reg     = zeros(1,1*M);
Pre_ref =  1 - 2.*mod(known_coeff,2)  - 1i *(1- 2.*floor(known_coeff/2));
rx_in_sb =  ((1-2*(real(rx_in)<0))+ 1i * (1-2*(imag(rx_in)<0)));

for d = 1: SynLen,
    ACR_Mult(d,:) = conj(rx_in(d,:)) .* rx_in_d64(d,:);    
    if (d==1),  P_sim(d,:) = ACR_Mult(d,:);        
    else        P_sim(d,:) =  P_sim(d-1,:) + ACR_Mult(d,:) - ACR_Mult_d64(1,:);
    end  
    for m = 1:64,
        ACR_Mult_d64(m,:) = ACR_Mult_d64(m+1,:);                     
    end
    ACR_Mult_d64(64,:)  = ACR_Mult(d,:);
    P_Abs_sim(d,:)   = abs(P_sim(d,:));
    
    if (d<65),  P_diff(d,:) = P_Abs_sim(d,:);        
    else        P_diff(d,:) = P_Abs_sim(d,:) - P_Abs_sim(d-64,:);
    end

    %rx_AbsSqr(d,:)      = abs(rx_in(d,:)).^2;
    if (d==1),  R_sim(d,:) =  rx_AbsSqr(d,:);        
    else        R_sim(d,:) =  R_sim(d-1,:) + rx_AbsSqr(d,:) - rx_AbsSqr_d64(d,:);
    end  
    R_thr_sim(d,:) = R_sim(d,:)/2;
    
     
    %cross correlation
    CR_out_sim(d) = (rx_in_sb(d) * Pre_ref(1*M))/2 + CR_Reg(1*M-1);
    for m = (1*M-1):-1:2,
       CR_Reg(m) =  (rx_in_sb(d) * Pre_ref(m))/2 + CR_Reg(m-1);                     
    end   
    CR_reg(1) = (rx_in_sb(d) * Pre_ref(1))/2;
end
figure (100)
plot(1:SynLen,P_Abs_sim,'.-b');
hold on
plot(1:SynLen,R_thr_sim,'.-r');
figure (101)
plot(1:SynLen,abs(CR_out_sim),'o-b');
figure (102)
plot(1:SynLen,abs(CR_out_sim)./max(CR_out_sim),'o-b');
hold on
plot(1:SynLen,P_Abs_sim ./ max(P_Abs_sim),'o-g');
plot(1:SynLen,P_diff ./ max(P_Abs_sim),'.-c');
plot(1:SynLen,R_thr_sim./ max(P_Abs_sim),'o-k');
plot(1:SynLen,rx_in(1:SynLen) ./ max(rx_in(1:SynLen)),'o-r');

% Timing synchronisation toff_est = t_cor =================================
% & remove short preamble 

Synch_datout = rx_in(t_cor:Flen,:);
Synch_datout_sim = reshape(Synch_datout, ((NFFT+CP)*(NDS + 1))*NLOP, 1);

% Compare Simulation vs RTL ===============================================
figure(1)
hold on 
plot(1:length(Synch_datout_sim), real(Synch_datout_sim),'o-b');
plot(1:length(Synch_datout_rtl), real(Synch_datout_rtl),'.-r');
legend('Synch\_datout\_sim','Synch\_datout\_rtl')
title ('Synch\_datout\_sim vs Synch\_datout\_rtl')
hold off

figure(2)
hold on 
plot(1:length(P_sim),real(P_sim),'o-g');
plot(1:length(P_metric_rtl), real(P_metric_rtl),'.-r');
legend('P\_Metric\_sim','P\_Metric\_rtl')
title ('Real part of P\_Metric\_sim vs P\_Metric\_rtl')
hold off

figure(3)
hold on 
plot(1:length(P_sim),imag(P_sim),'o-g');
plot(1:length(P_metric_rtl), imag(P_metric_rtl),'.-r');
legend('P\_Metric\_sim','P\_Metric\_rtl')
title ('Imaginary part of P\_Metric\_sim vs P\_Metric\_rtl')
hold off

figure(4)
hold on 
plot(1:length(R_sim),R_sim,'o-g');
plot(1:length(R_metric_rtl), R_metric_rtl,'.-r');
title ('R\_Metric\_sim vs R\_Metric\_rtl')
legend('R\_Metric\_sim','R\_Metric\_rtl')
hold off

figure(5)
hold on 
plot(1:length(CR_out_sim),abs(CR_out_sim),'o-g');
plot(1:length(CR_out_rtl), abs(CR_out_rtl),'.-r');
legend('CR\_Out\_sim','CR\_Out\_rtl')
title ('CR\_Out\_sim vs CR\_Out\_rtl')
hold off

