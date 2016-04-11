function y = filter_from_white(b, a, N, M, Tp, seed)
rngstate = rng(seed);
w = sqrt(0.5) .* (randn(N, M) + 1j*randn(N, M));
rng(rngstate);

% Random proc with the PSD specified by H = B/A
y_ = filter(b, a, w, [], 2);
H = freqz(b, a, 'whole', M);
H_energy = Tp * sum(abs(H).^2);
H_power = H_energy / (Tp*M);
y = y_ ./ sqrt(H_power); % Normalize the PSD to integrate to 1
end
