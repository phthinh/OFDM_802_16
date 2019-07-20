clear all
close all
mkdir('../','work/data');

%dur  = 3.2e-6;  
NLOP = 2;    % number of loop
NFFT = 256;      % Number of FFT points
NC   = 192;      % Number of subcarriers
NDS  = 2;        % Number of Data symbol per frame
NS   = NDS*NLOP; % number of symbols
NP   = 8;        % Number of pilots in symbol -88 -63 -38 -13 13 38 63 88
CP   = 32;       % cyclic prefix length
PRE  = 2;        % preamble symbol = 2
FBIT = 6;

Nfail = zeros(2,4);

N = 128;
M = N/2;
L = 32;
C = 2*M; %length of computed received samples for Mp

SNR =  40;
FOFF = 0;
toff = 8;
tcor = toff+33+3*M;

%OFDM TX Create NLOP frames for simulation ================================
%data
bit_symbols = round(3*rand(NC, NS));

%QPSK =================================================================
QPSK    = 2.*mod(bit_symbols,2)-1 + 1i *(2.*floor(bit_symbols/2)-1);
QPSK    = QPSK *(1/sqrt(2));   
bit_symbols_stream = reshape(bit_symbols,NC*NS,1);
%insert subcarriers & pilots ==========================================
% pilot ===============================================================
Pil = Pilots(NDS);
Pil = repmat(Pil,1,NLOP);
%Pil = zeros(8,NS);
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

%IFFT =================================================================
tx_d =  ifft(symbol, NFFT, 1);

%Add CP ===============================================================
tx_d = [tx_d(NFFT-CP+1: NFFT,:); tx_d];

%Add Preamble =========================================================
tx_out = zeros((NFFT+CP), (PRE + NDS)*NLOP);

[DL_preamble, UL_preamble, pre64, pre128, peven] = preamble_802_16();   
DL_preamble_nor = DL_preamble; 
preamb = reshape(DL_preamble_nor, NFFT+CP, PRE);
for ii = 0:NLOP -1,
    tx_out(:,(PRE + NDS)*ii+1) = preamb(:,1);
    tx_out(:,(PRE + NDS)*ii+2) = preamb(:,2);
    if (NDS ~=0 )
        for jj = 1:NDS,
            tx_out(:,(PRE + NDS)*ii+2+jj) = tx_d(:,ii*NDS+jj);            
        end
    end
end
tx_out = reshape(tx_out, (NFFT+CP)*(PRE + NDS)*NLOP,1);
%==========================================================================   

%frequency offset adding ==============================================
n=0:(CP+NFFT)*(PRE + NDS)-1;
freoffs = exp(1i*2*pi*FOFF*(n.'./NFFT));    
tx_temp = reshape(tx_out, (CP+NFFT)*(PRE + NDS), NLOP);
tx_temp = tx_temp .* repmat(freoffs,1,NLOP);   
tx_out  = reshape(tx_temp,1,length(tx_out));

%AWGN channel simulation ==============================================
%rx_in = tx_out;  
rx_in = reshape(tx_out,(CP+NFFT)*(PRE + NDS), NLOP);
%rx_in = [rx_in(length(rx_in)- toff + 1 : length(rx_in)) rx_in(1:length(rx_in))];
toff_mat = zeros(toff,NLOP);
rx_in = [toff_mat; rx_in];
rx_in = reshape(rx_in,1,((CP+NFFT)*(PRE + NDS) + toff) * NLOP);
rx_in = awgn(rx_in ,SNR,'measured');   
rx_in = 0.5*(rx_in ./ max(abs(rx_in)));
%rx_in = rx_in .*2;

known_pre = pre64;
abs_pre = abs(pre64).^2;
known_coeff = round((abs_pre./max(abs_pre)).*2)./2;

known_coeff_rtl = typecast(int8(real(known_coeff(1:64).*2)),'uint8');
fid = fopen('../work/data/Synch_known_coeff_rtl.txt', 'w');
fprintf(fid, '%x ', known_coeff_rtl);
fclose(fid);

%write data to file =======================================================
fid = fopen('../work/data/OFDM_RX_bit_symbols.txt', 'w');
fprintf(fid, '%d ', bit_symbols_stream);
fclose(fid);

Len = length(rx_in);
fid = fopen('../work/data/OFDM_RX_datin_Re.txt', 'w');
fprintf(fid, '%f ', real(rx_in));
fclose(fid);
fid = fopen('../work/data/OFDM_RX_datin_Im.txt', 'w');
fprintf(fid, '%f ', imag(rx_in));
fclose(fid);

datin_rtl = rx_in(1:Len) .*(2^15);
datin_Re = typecast(int16(real(datin_rtl)),'uint16');
datin_Im = typecast(int16(imag(datin_rtl)),'uint16');

SNR_w = round(SNR);
if (SNR >15), SNR_w = 15; end
Flen = 288 *(PRE+NDS) + toff;
fid = fopen('../work/data/RTL_OFDM_RX_datin_len.txt', 'w');
fprintf(fid, '%d %d %d %d', NLOP, Flen, SNR_w, toff);
fclose(fid);
fid = fopen('../work/data/RTL_OFDM_RX_datin_Re.txt', 'w');
fprintf(fid, '%4x ', datin_Re);
fclose(fid);
fid = fopen('../work/data/RTL_OFDM_RX_datin_Im.txt', 'w');
fprintf(fid, '%4x ', datin_Im);
fclose(fid);


% data cofficient for system synthesis ==================================== 
known_coeff = 2*(imag(pre64(32+(1:1*M)))<0) + 1*(real(pre64(32+(1:1*M))<0));
known_coeff_rtl = typecast(int8(known_coeff),'uint8');
fid = fopen('../MY_SOURCES/Synch_known_coeff_802_16.txt', 'w');
fprintf(fid, '%x ', known_coeff_rtl);
fclose(fid);

known_coeff = 2*(imag(peven([3:2:101, 157:2:255]))<0) + 1*(real(peven([3:2:101, 157:2:255]))<0);
known_coeff_rtl = typecast(int8(known_coeff),'uint8');
fid = fopen('../MY_SOURCES/ChEstEqu_lpre.txt', 'w');
fprintf(fid, '%x ', known_coeff_rtl);
fclose(fid);

% % for C = 2*M;
% % AWGN_Q 2M
% if (FBIT == 3 ),
%     % threshold for nSUI = 0; C = 2M; Q=3; np =8; 2p
%     thres_coeff =  [4.18 4.00 4.76 6.12 5.69 8.00 7.33 6.91 8.00 8.00 8.00 8.00*ones(1, 6)];
% elseif (FBIT == 4 ),    
%     % threshold for nSUI = 0; C = 2M; Q=4; np =8; 2p
%     thres_coeff =  [1.83 2.16 2.12 2.06 2.84 2.47 2.89 3.00 3.29 3.00 3.20 3.20*ones(1, 6)];
% elseif (FBIT == 5 ),    
%     % threshold for nSUI = 0; C = 2M; Q=5; np =8; 2p
%     thres_coeff =  [1.19 1.28 1.44 1.65 1.70 1.76 1.82 1.88 1.94 2.00 2.00 2.00*ones(1, 6)];
% elseif (FBIT == 6 ),    
%     % threshold for nSUI = 0; C = 2M; Q=6; np =8; 2p
%     thres_coeff =  [1.06 1.15 1.27 1.42 1.52 1.62 1.70 1.75 1.75 1.75 1.75 1.75*ones(1, 6)];
% elseif (FBIT == 7 ),    
%     % threshold for nSUI = 0; C = 2M; Q=7; np =8; 2p
%     thres_coeff =  [0.97 1.09 1.16 1.26 1.38 1.50 1.60 1.60 1.60 1.60 1.60 1.60*ones(1, 6)];
% elseif (FBIT == 12 ),    
%     % threshold for nSUI = 0; C = 2M; Q=12; np =8; 2p
%     thres_coeff =  [0.90 0.99 1.04 1.14 1.24 1.34 1.44 1.54 1.54 1.54 1.54 1.54*ones(1, 6)];
% elseif (FBIT == 15 ),    
%     % threshold for nSUI = 0; C = 2M; Q=12; np =8; 2p
%     thres_coeff =  [0.90 0.99 1.04 1.14 1.24 1.34 1.44 1.54 1.54 1.54 1.54 1.54*ones(1, 6)];
% end
% 
% thres_coeff_rtl = typecast(int32(thres_coeff .* 2^15),'uint32');
% fid = fopen('../MY_SOURCES/RTL_Synch_thres_coeff_q05.txt', 'w');
% fprintf(fid, '%5x ', thres_coeff_rtl(1:16));
% fclose(fid);
% 
% fid = fopen('Synch_thres_coeff_q05.txt', 'w');
% fprintf(fid, '%f ', thres_coeff);
% fclose(fid);
% 
