 clear all; close all; clc;
r = 8;      %at least 4
SNRc = zeros(1,2^r-2);
SNRl = zeros(1,2^r-2);
SNRtc = zeros(1,2^r-2);
SNRtl = zeros(1,2^r-2);
EPSILONc = zeros(1,2^r-2);
EPSILONl = zeros(1,2^r-2);
nuovoind = 1;
for r = 6:8
    nuovoind = 1;
for N_fil = 2:2^r-1
    part1_ok;
    SNRc(r-5,nuovoind) = SNR_corr;
    SNRl(r-5,nuovoind) = SNR_ls;
    SNRtc(r-5,nuovoind) = SNR_theo_corr;
    SNRtl(r-5,nuovoind) = SNR_theo_ls;
    EPSILONc(r-5,nuovoind) = epsilon/L; 
    EPSILONl(r-5,nuovoind) = sigma2w_est;
    nuovoind = nuovoind+1;
end 
end
for setting = 1:r-5
hold all
plot(linspace(0,length(EPSILONc),length(EPSILONc)),10*log10(EPSILONc(setting,:)));
plot(linspace(0,length(EPSILONc),length(EPSILONc)),10*log10(EPSILONl(setting,:)),'--');
xlabel('N_f');    ylabel('e/L');
ylim([-18 0])
legend('correlation (L=63)','ls(L=63)','correlation (L=127)','ls (L=127)','correlation (L=255)','ls (L=255)');
end
figure;
for setting = 1:r-5
hold all
plot(2:2^(setting+5)-1,SNRc(setting,1:2^(setting+5)-2),'--');

ylabel('SNR db');    xlabel('N_f');
title('Correlation method');
ylim([-4 15]); xlim([0 255]);
legend('experimental (L=63)','experimental (L=127)','experimental (L=255)');
end
for setting = 1:r-5
plot(2:2^(setting+5)-1,SNRtc(setting,1:2^(setting+5)-2),'r');
legend('experimental (L=63)','experimental (L=127)','experimental (L=255)');
end
figure;
for setting = 1:r-5
hold all
plot(2:2^(setting+5)-1,SNRl(setting,1:2^(setting+5)-2),'--');

title('Ls method');
ylabel('SNR db');    xlabel('N_f');
ylim([-4 15]);   xlim([0 255]);
legend('experimental (L=63)','experimental (L=127)','experimental (L=255)');

end
for setting = 1:r-5
plot(2:2^(setting+5)-1,SNRtl(setting,1:2^(setting+5)-2),'r');
end