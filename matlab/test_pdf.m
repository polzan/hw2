close all; clear all; clc;

x = linspace(0, 3, 2048);

rice = rice_pdf(x, 2);
D = classical_doppler_spectrum(x, 0.1/3);
D = D ./ sqrt(sum(D));

figure;
hold all;
plot(x, rice);
plot(x, D);

C = conv(rice, D, 'same');

plot(x, C);