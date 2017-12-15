clear all
close all

%dur  = 3.2e-6;  
NLOP = 2;    % number of loop
NFFT = 256;      % Number of FFT points
NC   = 192;      % Number of subcarriers
NDS  = 1;        % Number of Data symbol per frame
NS   = NDS*NLOP;   % number of symbols
NP   = 8;        % Number of pilots in symbol -88 -63 -38 -13 13 38 63 88
CP   = 32;       % cyclic prefix length
PRE  = 2;        % preamble symbol = 2
SNR  = 30;

FOFF = 0;
toff = 0;
% data in for TX ==========================================================
bit_symbols = round(3*rand(1, NC*NS));

Len = NC * NDS;
%write data to file =======================================================
fid = fopen('OFDM_TX_bit_symbols_Len.txt', 'w');
fprintf(fid, '%d ', Len);
fprintf(fid, '%d ', NLOP);
fprintf(fid, '%d ', SNR);
fprintf(fid, '%d ', toff);
fprintf(fid, '%d ', FOFF);
fclose(fid);

fid = fopen('OFDM_TX_bit_symbols.txt', 'w');
fprintf(fid, '%d ', bit_symbols);
fclose(fid);

%write Preamble ===========================================================
[DL_preamble, UL_preamble, pre64, pre128, peven] = preamble_802_16();   

Preamble_rtl = DL_preamble .*(2^15);
Preamble_Re  = typecast(int16(real(Preamble_rtl)),'uint16');
Preamble_Im  = typecast(int16(imag(Preamble_rtl)),'uint16');

Pre = uint32(Preamble_Im) * (2^16) + uint32(Preamble_Re);
fid = fopen('../../MY_SOURCES/Pre.txt', 'w');
fprintf(fid, '%8x ', Pre);
fclose(fid);


