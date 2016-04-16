close all; clear all; clc;

[b,a] = classical_doppler_spectrum();
delta = [1; zeros(1023, 1)];

h = filter(b, a, delta);

figure;
plot(0:length(h)-1, h);