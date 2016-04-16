close all; clear all; clc;

Tq, fd, pdp, C, N_c, K

if fd > 0
    M = round(0.1 / (fd*Tq));
    Tp = M*Tq;
    [Hb, Ha] = classical_doppler_spectrum();
else
    error('to do');
    M = 1;
    Tp = Tq;
    Hb = 1;
    Ha = 1;    
end

% Std complex white noise input
Kp = ceil(K/M);
w = sqrt(0.5) .* (randn(N_c, Kp) + 1j*randn(N_c, Kp));
% Random proc with the Doppler PSD
g_1 = filter(Hb,Ha, w, [], 2);
H = freqz(Hb, Ha, 'whole', 1024);
g_1 = g_1 ./ bandpower(H); % Normalize the power to 1

figure;
f = linspace(0, 1, Kp);
plot(f, 20*log10(abs(fft(g_1(1,:)))));

g_int = interp(g_1, M);

bandpower(g_int)

figure;
f = linspace(0, 1, K);
plot(f, 20*log10(abs(fft(g_int(1,:)))));

g = g_1;