clear all; close all; clc;
r = 4;      %at least 4
SNRc = zeros(1,2^r-2);
SNRl = zeros(1,2^r-2);
SNRtc = zeros(1,2^r-2);
SNRtl = zeros(1,2^r-2);
EPSILONc = zeros(1,2^r-2);
EPSILONl = zeros(1,2^r-2);
nuovoind = 1;
for N_fil = 2:2^r-1
    part1_ok;
    SNRc(1,nuovoind) = SNR_corr;
    SNRl(1,nuovoind) = SNR_ls;
    SNRtc(1,nuovoind) = SNR_theo_corr;
    SNRtl(1,nuovoind) = SNR_theo_ls;
    EPSILONc(1,nuovoind) = epsilon/L; 
    EPSILONl(1,nuovoind) = sigma2w_est;
    nuovoind = nuovoind+1;
end 
hold all
plot(linspace(0,length(EPSILONc),length(EPSILONc)),10*log10(EPSILONc));
plot(linspace(0,length(EPSILONc),length(EPSILONc)),10*log10(EPSILONl),'--');
xlabel('N');    ylabel('e/L');
ylim([-40 0])
legend('correlation','ls');
figure;
hold all
plot(linspace(2,length(SNRc),length(SNRc)),SNRc);
plot(linspace(2,length(SNRc),length(SNRc)),SNRtc,'r');
ylabel('SNR db');    xlabel('N');
title('Correlation method');
legend('experimental','theoretical');
figure;
hold all
plot(linspace(2,length(SNRc),length(SNRc)),SNRl);
plot(linspace(2,length(SNRc),length(SNRc)),SNRtl,'r');
title('Ls method');
ylabel('SNR db');    xlabel('N');
legend('experimental','theoretical');