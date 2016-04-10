close all; clear all; clc;

T = 1;
tau_rms = 0.2*T;
N_h = 5;
Tc = T/4;

Kpdp = 100;
tau = (0:Kpdp-1) .* T;
pdp = exp(-tau/tau_rms)./tau_rms;
norm_pdp = pdp ./ sum(pdp);

rice_factor = 10^(2 / 10); % 2dB
C = sqrt(rice_factor/(rice_factor+1));

% Plot of the PDP(0..4)
figure;
plot(0:4, 10*log10(norm_pdp(1:5)));
xlabel('i');
ylabel('M(iT) [dB]');

% Table of the PDP(0..4)
fprintf('Normalized PDP values:\n');
for i=0:4
    fprintf('  M(%dT) & \\SI{%.3f}{\\dB} \\\\\n', i, 10*log10(norm_pdp(i+1)));
end

H_dopp_a = [1.0000e+0, -4.4153e+0, 8.6283e+0, -9.4592e+0, 6.1051e+0, -1.3542e+0, -3.3622e+0, 7.2390e+0, -7.9361e+0, 5.1221e+0, -1.8401e+0, 2.8706e-1];

H_dopp_b = [1.3651e-4, 8.1905e-4, 2.0476e-3, 2.7302e-3, 2.0476e-3, 9.0939e-4, 6.7852e-4, 1.3550e-3, 1.8067e-3, 1.3550e-3, 5.3726e-4, 6.1818e-5, -7.1294e-5, -9.5058e-5, -7.1294e-5, -2.5505e-5, 1.3321e-5, 4.5186e-5, 6.0248e-5, 4.5186e-5, 1.8074e-5, 3.0124e-6];

% Generate the doppler spectrum
Kdopp = 1000;
Tp = 1;
w = sqrt(0.5) .* (randn(Kdopp, 1) + 1j*randn(Kdopp, 1));

% figure;
% histogram(real(w));
% figure;
% histogram(imag(w));
% bandpower(w)

h_ds = hann(2*Kdopp);
h_ds = h_ds(Kdopp:2*Kdopp);

out = filter(h_ds, 1, w);

figure;
plot((0:Kdopp-1) * T, 20*log10(abs(fft(out))));





