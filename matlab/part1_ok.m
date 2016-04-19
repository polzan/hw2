%clear all; close all; clc;      %comment to use snr_n.m
%params

N = 15;
%N_fil = 15;   %comment to use snr_n.m
%r = 9;      %comment to use snr_n.m
a = 0.68129;
sigma2w = 0.3;
n = 0:N-1;
L = 2^r-1;          
h = a.^n.*ones(1,N);        %filter impulse response

% generate functions
x_in = pn_seq(L,1,N-1);       %input (+N-1 transient)
x = x_in(N:L+N-1);      %rc signal

for i = 0:L-1
z(i+1) = h*fliplr(x_in(i+1:N+i))';      %z and d shifted of N-1 samples(+1 matlab)
end
rng(2^10-1);
w = sqrt(sigma2w)*randn(1,length(z));
d = z + w;


[H_corr, epsilon] = correlation_method(x, d, N_fil);
[H_ls, sigma2w_est, epsilon_d] = ls_method(x, d, N_fil);
SNR_corr = SNR(sigma2w, L,h,H_corr,'corr');
SNR_ls = SNR(sigma2w, L,h,H_ls,'ls');
SNR_theo_corr = SNR(sigma2w, L,h, H_ls,'theo_corr');     
SNR_theo_ls = SNR(sigma2w, L,h, H_ls,'theo_ls');        



% %%%%%%%%%%%%%%%%%%%plot h%%%%%%%%%%%%%%%
% hold all            %comment all to use snr_n.m
% plot(linspace(0,length(h),length(h)),h,'r');
% plot(linspace(0,length(H_corr),length(H_corr)),H_corr);
% plot(linspace(0,length(H_corr),length(H_corr)),H_ls,'--');
% legend('theoretical','correlation','ls');
% xlabel('n');   ylabel('h(n)');
