close all; clear all; clc;

T = 1/10000;
tau_rms = 0.2*T; % 20 us
N_h = 5;
Tc = T/4;

Kpdp = N_h;
tau = transpose((0:Kpdp-1) .* T);
pdp = exp(-tau/tau_rms)./tau_rms;
norm_pdp = pdp ./ sum(pdp);

rice_factor = 10^(2 / 10); % 2dB
C = sqrt(rice_factor/(rice_factor+1)); % Assuming normalized pdp

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

fdTc = 25e-5;
K = 12000;
g = generate_ch_coeff(Tc, fdTc/Tc, norm_pdp, C, N_h, K);

% Plot the channel h
figure;
subplot(1,3,1);
plot(0:K-1, abs(g(1,:)));
ylabel('|h_0(k)|');
subplot(1,3,2);
plot(0:K-1, abs(g(3,:)));
ylabel('|h_2(k)|');
subplot(1,3,3);
plot(0:K-1, abs(g(5,:)));
ylabel('|h_4(k)|');
