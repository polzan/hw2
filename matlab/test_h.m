close all; clear all; clc;

fd = 0.4;
f = linspace(-2*fd, 2*fd, 4000);
D = classical_doppler_spectrum(f, fd);

figure;
plot(f, D);


sum(D)