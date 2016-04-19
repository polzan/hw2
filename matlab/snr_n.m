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
    SNRc(r-3,nuovoind) = SNR_corr;
    SNRl(r-3,nuovoind) = SNR_ls;
    SNRtc(r-3,nuovoind) = SNR_theo_corr;
    SNRtl(r-3,nuovoind) = SNR_theo_ls;
    EPSILONc(r-3,nuovoind) = epsilon/L; 
    EPSILONl(r-3,nuovoind) = sigma2w_est;
    nuovoind = nuovoind+1;
end 
end
for setting = 1:r-5
hold all
plot(linspace(0,length(EPSILONc),length(EPSILONc)),10*log10(EPSILONc(setting,:)));
plot(linspace(0,length(EPSILONc),length(EPSILONc)),10*log10(EPSILONl(setting,:)),'--');
xlabel('N');    ylabel('e/L');
ylim([-40 0])
legend('correlation (L=63)','ls(L=63)','correlation (L=127)','ls (L=127)','correlation (L=255)','ls (L=255)');
end
figure;
for setting = 1:r-3
hold all
plot(2:2^(setting+3)-1,SNRc(setting,1:2^(setting+3)-2),'--');

ylabel('SNR db');    xlabel('N_fil');
title('Correlation method');
ylim([-4 15])
legend('experimental (L=63)','experimental (L=127)','experimental (L=255)');
end
for setting = 1:r-3
plot(2:2^(setting+3)-1,SNRtc(setting,1:2^(setting+3)-2),'r');
legend('experimental (L=63)','experimental (L=127)','experimental (L=255)');
end
figure;
for setting = 1:r-3
hold all
plot(2:2^(setting+3)-1,SNRl(setting,1:2^(setting+3)-2),'--');

title('Ls method');
ylabel('SNR db');    xlabel('N_fil');
ylim([-4 15])
legend('experimental (L=63)''experimental (L=127)','experimental (L=255)');

end
for setting = 1:r-3
plot(2:2^(setting+3)-1,SNRtl(setting,1:2^(setting+3)-2),'r');
end