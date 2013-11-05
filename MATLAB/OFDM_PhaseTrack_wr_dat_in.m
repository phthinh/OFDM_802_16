clear all
close all

NLOP = 1;    % number of loop
NFFT = 256;      % Number of FFT points
NC   = 192;      % Number of subcarriers
NDS  = 2;        % Number of Data symbol per frame
NS   = NDS*NLOP;   % number of symbols
NP   = 8;        % Number of pilots in symbol -88 -63 -38 -13 13 38 63 88
CP   = 32;       % cyclic prefix length
PRE  = 2;        % preamble symbol = 2

SNR = 200;
FOFF = 00;
toff = 0;

%OFDM TX Create NLOP frames for simulation ================================
%data
bit_symbols = round(3*rand(NC, NS));

%QPSK =================================================================
QPSK    = 2.*mod(bit_symbols,2)-1 + 1i *(2.*floor(bit_symbols/2)-1);
QPSK    = QPSK *(1/sqrt(2));   
dat_mod = QPSK;

% insert subcarriers & pilots =============================================
% pilots in symbol –21, –7, 7, and 21======================================
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
%peven is pilot symbols of long preamble in frequency domain
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
rx_in = reshape(tx_out,(CP+NFFT)*(PRE + NDS), NLOP);
toff_mat = zeros(toff,NLOP);
rx_in = [toff_mat; rx_in];
rx_in = reshape(rx_in,1,((CP+NFFT)*(PRE + NDS) + toff) * NLOP);
rx_in = awgn(rx_in ,SNR,'measured');   

% Synchronisation  ==============================================
rx_in = reshape(rx_in,(CP+NFFT)*(PRE + NDS) + toff, NLOP);
frm_len = (CP+NFFT)*(PRE + NDS) + toff;
tsyn  = (CP+NFFT)*(PRE-1) + toff + 1;
rx_in = rx_in(tsyn : frm_len,:);

nn = ((0:(NFFT+CP)*(NDS+1)-1));
FOFF_est = FOFF-0.00;
freoff_cmp = exp(-1i*2*pi*FOFF_est*(nn ./NFFT)).';

rx_syn = rx_in .* repmat(freoff_cmp,1,NLOP); 
%receive and remove CP ==============================================
rx = rx_syn(:,1);
rx = reshape(rx,(CP+NFFT),(NDS+1));
rx(1:CP,:) = [];

%fft ======================================================================
rx_sym = fft(rx,NFFT,1);
ch_sym = rx_sym(:,2:1+NDS);

%add channel response =====================================================
% ch_ph = rand(NFFT,1);
% ch_res = exp(1i*2*pi.*ch_ph);
% ch_res= repmat(ch_res,1,1+NDS);
% rx_ch_sym = ch_sym .* ch_res;
% rx_ch_sym = reshape(rx_ch_sym,NFFT*(1+NDS),1);
ch_sym(102:156,:)=[];
ch_sym(1,:) = [];
% PhaseTrack_sym = reshape(ch_sym, NFFT*(NDS),1);
PhaseTrack_sym = reshape(ch_sym, (NC+NP)*(NDS),1);
%write data to file =======================================================
tx_sym = reshape(symbol,NFFT*(NDS),1);
fid = fopen('PhaseTrack_Txsym_Re.txt', 'w');
fprintf(fid, '%f ', real(tx_sym));
fclose(fid);
fid = fopen('PhaseTrack_Txsym_Im.txt', 'w');
fprintf(fid, '%f ', imag(tx_sym));
fclose(fid);

fid = fopen('PhaseTrack_datin_Re.txt', 'w');
fprintf(fid, '%f ', real(PhaseTrack_sym));
fclose(fid);
fid = fopen('PhaseTrack_datin_Im.txt', 'w');
fprintf(fid, '%f ', imag(PhaseTrack_sym));
fclose(fid);

Len = length(PhaseTrack_sym);
datin_rtl = PhaseTrack_sym(1:Len) .*(2^6);
datin_Re = typecast(int16(real(datin_rtl)),'uint16');
datin_Im = typecast(int16(imag(datin_rtl)),'uint16');

Flen = NFFT*(NDS);
fid = fopen('RTL_PhaseTrack_datin_len.txt', 'w');
fprintf(fid, '%d', Len);
fclose(fid);
fid = fopen('RTL_PhaseTrack_datin_Re.txt', 'w');
fprintf(fid, '%4x ', datin_Re);
fclose(fid);
fid = fopen('RTL_PhaseTrack_datin_Im.txt', 'w');
fprintf(fid, '%4x ', datin_Im);
fclose(fid);    

