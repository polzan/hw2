close all; clear all; clc;

T = 1; % Symbol period?
tau_rms = 0.2*T;
N_h = 5;
Tc = T/4;

Kpdp = N_h;
tau = transpose((0:Kpdp-1) .* Tc);
pdp = exp(-tau/tau_rms)./tau_rms;
norm_pdp = pdp ./ sum(pdp);

rice_factor = 10^(2 / 10); % 2dB
C = sqrt(rice_factor/(rice_factor+1)); % Assuming normalized pdp

% Plot of the PDP(0..4)
figure;
plot(0:4, 10*log10(norm_pdp(1:5)));
xlabel('i');
ylabel('M(iT_c) [dB]');
print('plot_pdp', '-depsc');

% Table of the PDP(0..4)
fprintf('Normalized PDP values:\n');
for i=0:4
    fprintf('  M(%dT_c) & \\SI{%.3f}{\\dB} \\\\\n', i, 10*log10(norm_pdp(i+1)));
end

fdTc = 25e-5;
fd = fdTc / Tc;
K = 80000;
seed = 1992830049;
h = generate_ch_response(Tc, fd, norm_pdp, C, N_h, K, seed);

% Plot the channel h
Kplot = 12000;
figure;
subplot(1,3,1);
plot(0:Kplot-1, abs(h(1,1:Kplot)));
ylabel('|h_0(kT_c)|');
xlabel('k');
ylim([0 1.5]);
xlim([0 Kplot-1]);
subplot(1,3,2);
plot(0:Kplot-1, abs(h(3,1:Kplot)));
ylabel('|h_2(kT_c)|');
xlabel('k');
ylim([0 1.5]);
xlim([0 Kplot-1]);
subplot(1,3,3);
plot(0:Kplot-1, abs(h(5,1:Kplot)));
ylabel('|h_4(kT_c)|');
xlabel('k');
ylim([0 1.5]);
xlim([0 Kplot-1]);
%set(gcf, 'PaperPosition', [0 0 1600 900])
print('plot_h_coeff', '-depsc');

fprintf('The coherence time is %.3fT\n', 1/(10*fdTc))

% PSD 
Kf = 80000; % We need the resolution to see D
f = linspace(0, 1/Tc, Kf);
D = classical_doppler_spectrum(f, fd);
kfd = ceil(fdTc*Kf);
D(Kf - kfd +1:Kf) = flip(D(1:kfd));
%D = D ./ sum(D); % Must integrate to 1
theor_spec = D .* (norm_pdp(1) - C^2);
theor_spec(1) = theor_spec(1) + C^2*Kf;
theor_spec(Kf) = theor_spec(1);

welch_D = 5000;
welch_S = 1200;
%welch = psd_welch_estim(transpose(h(1,:)), rectwin(welch_D), welch_D, welch_S, Kf);
welch = pwelch(h(1,:), rectwin(welch_D), welch_S, Kf);

figure;
hold all;

% Draw the vertical line at fd
theor_spec_db = 10*log10(theor_spec);
i_inf = find(theor_spec_db == -Inf);
theor_spec_db(i_inf) = -1000;

plot(f, 10*log10(welch));
plot(f, theor_spec_db);
xlabel('lambda');
ylabel('dB');
legend('Welch', 'Theoretical');
ylim([-40, 10]);
print('plot_psd', '-depsc');

figure;
hold all;
plot(f, 10*log10(welch));
plot(f, theor_spec_db);
xlabel('lambda');
ylabel('dB');
legend('Welch', 'Theoretical');
xlim([0, 3*fd]);
ylim([-20, 30]);
print('plot_psd_detail', '-depsc');

% Histogram of h_0
h_0_abs = abs(h(1,:)) ./ sqrt(norm_pdp(1));
[pdf, a_pdf] = empirical_pdf(h_0_abs, 2048);
a_theo = linspace(0, 3, 2048);
theo_pdf = rice_pdf(a_theo, rice_factor);

figure;
hold all;
plot(a_pdf, pdf);
plot(a_theo, theo_pdf);
xlim([0 3]);
ylim([0 2]);
ylabel('p(a)')
xlabel('a');
legend('Estimated', 'Rice');
print('plot_pdf', '-depsc');
