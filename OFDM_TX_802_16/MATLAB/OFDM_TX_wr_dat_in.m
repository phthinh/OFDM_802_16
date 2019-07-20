clear all
close all
mkdir('../','work/data');
%dur  = 3.2e-6;  
NLOP = 2;    % number of loop
NFFT = 256;      % Number of FFT points
NC   = 192;      % Number of subcarriers
NDS  = 2;        % Number of Data symbol per frame
NS   = NDS*NLOP;   % number of symbols
NP   = 8;        % Number of pilots in symbol -88 -63 -38 -13 13 38 63 88
CP   = 32;       % cyclic prefix length
PRE  = 2;        % preamble symbol = 2
MOD  = 0;        % Data modulation 0:QPSK, 1:BPSK, 2:QAM16, 3:QAM64

% data in for TX ==========================================================
switch(MOD)
    case 1,     bit_symbols = round( 1*rand(1, NS*(NC)));       
    case 0,     bit_symbols = round( 3*rand(1, NS*(NC)));  
    case 2,     bit_symbols = round(15*rand(1, NS*(NC))); 
    case 3,     bit_symbols = round(63*rand(1, NS*(NC)));        
end

Len = NC * NDS;
%write data to file =======================================================
fid = fopen('../work/data/OFDM_TX_bit_symbols_Len.txt', 'w');
fprintf(fid, '%d ', Len);
fprintf(fid, '%d ', NLOP);
fprintf(fid, '%d ', MOD);
fclose(fid);

fid = fopen('../work/data/OFDM_TX_bit_symbols.txt', 'w');
fprintf(fid, '%d ', bit_symbols);
fclose(fid);

fid = fopen('../work/data/RTL_OFDM_TX_bit_symbols.txt', 'w');
fprintf(fid, '%x ', bit_symbols);
fclose(fid);
%write Preamble ===========================================================
[DL_preamble, UL_preamble, pre64, pre128, peven] = preamble_802_16();   
%DL_preamble_nor = DL_preamble ./ max(abs(DL_preamble));
DL_preamble_nor = DL_preamble;

Preamble_rtl = DL_preamble_nor .*(2^15);
Preamble_Re  = typecast(int16(real(Preamble_rtl)),'uint16');
Preamble_Im  = typecast(int16(imag(Preamble_rtl)),'uint16');

Pre = uint32(Preamble_Im) * (2^16) + uint32(Preamble_Re);
fid = fopen('../MY_SOURCES/Pre.txt', 'w');
fprintf(fid, '%8x ', Pre);
fclose(fid);


