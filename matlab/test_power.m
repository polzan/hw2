close all; clear all; clc;

Tp = 0.001;
N_ch = 5;
Kp = 1000000;

w = sqrt(0.5) .* (randn(N_ch, Kp) + 1j*randn(N_ch, Kp));

%b = 1;
%a = conv([1 -exp(1j*2*pi*0.25)], [1 -exp(-1j*2*pi*0.25)]);
[b, a] = butter(25, 0.125*pi);
y = filter_from_white(b, a, N_ch, Kp, Tp, 'shuffle');

figure;
Fs = 1/Tp;
f = linspace(0, Fs, Kp);
plot(f, 20*log10(abs(fft(y(1,:)))));

E_w = Tp * sum(abs(w(1,:)).^2);
E_y = Tp * sum(abs(y(1,:)).^2);
fprintf('Pow of y: %f\nPow of w: %f\n', E_y / (Tp*Kp), E_w / (Tp * Kp));

H = freqz(b, a, 'whole', 1024);
energy_H = sum(abs(H).^2);
