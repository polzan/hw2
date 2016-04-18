close all; clear all; clc;

[b, a] = classical_doppler_spectrum();

%l = impzlength(b,a);
l = 250;
[h,t] = impz(b,a, round(2*l));
maxafter = max(abs(h(l:length(h))));

fprintf('The filter length is %d, after that the max amplitude is %f\n', l, maxafter);

figure;
hold all;
stem(t, h);
plot(t, maxafter * ones(length(t),1), 'Color', 'red');
plot(t, -maxafter * ones(length(t),1), 'Color', 'red');
xlabel('k');
ylabel('h_{ds}(kTp)');
ylim([-1e-5 1e-5]);
