close all

NLOP = 1;    % number of loop
NFFT = 256;      % Number of FFT points
NC   = 192;      % Number of subcarriers
NDS  = 1;        % Number of Data symbol per frame
NS   = NDS*NLOP; % number of symbols
NP   = 8;        % Number of pilots in symbol -88 -63 -38 -13 13 38 63 88
CP   = 32;       % cyclic prefix length
PRE  = 2;        % preamble symbol = 2

SNR = 200;
FOFF = 0;
toff = 0;

% Read data in ============================================================
Para_fid = fopen('RTL_ChEstEqu_datin_len.txt', 'r');
Para = fscanf(Para_fid, '%d ');
Flen  = Para(1);
fclose(Para_fid);

NDS = Flen/(NFFT) - 1; %number of Data symbol excluding preamble

datin_fid = fopen('ChEstEqu_sym_Re.txt', 'r');
ch_sym_Re = fscanf(datin_fid, '%f ');
fclose(datin_fid);
datin_fid = fopen('ChEstEqu_sym_Im.txt', 'r');
ch_sym_Im = fscanf(datin_fid, '%f ');
fclose(datin_fid);
ch_sym =  ch_sym_Re + 1i*ch_sym_Im;
ch_sym = ch_sym.';
ch_sym = reshape(ch_sym, NFFT, NDS+1);


datin_fid = fopen('ChEstEqu_datin_Re.txt', 'r');
dat_Re = fscanf(datin_fid, '%f ');
fclose(datin_fid);

datin_fid = fopen('ChEstEqu_datin_Im.txt', 'r');
dat_Im = fscanf(datin_fid, '%f ');
fclose(datin_fid);

ch_datin =  dat_Re + 1i*dat_Im;
ch_datin = ch_datin.';
ch_datin = reshape(ch_datin, NFFT, NDS+1);

% Read data out of RTL ====================================================
datout_fid = fopen('RTL_ChEstEqu_datout_Re.txt', 'r');
ChEstEqu_datout_Re_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
datout_fid = fopen('RTL_ChEstEqu_datout_Im.txt', 'r');
ChEstEqu_datout_Im_rtl = fscanf(datout_fid, '%d ');
fclose(datout_fid);
ChEstEqu_datout_rtl = (ChEstEqu_datout_Re_rtl./2^6) + 1i*(ChEstEqu_datout_Im_rtl./2^6);

% Simulate with data in ===================================================
ch_sym = reshape(ch_sym,NFFT,NDS+1);
ch_sym(:,1) =[];
ch_sym(102:156,:)=[];
ch_sym(1,:) = [];
ch_sym = reshape(ch_sym,1,(NC+NP)*NDS);

[DL_preamble, UL_preamble, pre64, pre128, peven] = preamble_802_16(); 
ch_est = peven.' .* conj(ch_datin(:,1));
ch_est([2:2:100, 158:2:256]) = ch_est([3:2:101, 157:2:255]);
ch_datout = ch_datin(:,2:NDS+1) .* repmat(ch_est,1,NDS);
ch_datout(102:156,:)=[];
ch_datout(1,:)=[];
ChEstEqu_datout_sim = reshape(ch_datout,1,(NC+NP)*NDS);
% Compare Simulation vs RTL ===============================================
figure(1)
hold on 
plot(1:length(ChEstEqu_datout_sim), abs(ChEstEqu_datout_sim),'o-b');
plot(1:length(ChEstEqu_datout_rtl), abs(ChEstEqu_datout_rtl),'.-r');
title ('ChEstEqu\_datout\_sim vs ChEstEqu\_datout\_rtl')
legend('ChEstEqu\_datout\_sim','ChEstEqu\_datout\_rtl')
% xlim([1 1000]);
hold off

figure(2)
hold on 
plot(1:length(ChEstEqu_datout_sim), angle(ChEstEqu_datout_sim),'o-b');
plot(1:length(ch_sym), angle(ch_sym),'.-r');
title ('ChEstEqu\_datout\_sim vs ch\_sym\_datin')
legend('ChEstEqu\_datout\_sim','ch\_sym\_datin')
% xlim([1 1000]);
hold off

