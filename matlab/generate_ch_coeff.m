function g = generate_ch_coeff(Tq, fd, pdp, C, N_c, K)
if fd > 0
    M = round(0.1 / (fd*Tq));
    Tp = M*Tq;
    [Hb, Ha] = classical_doppler_spectrum(); % For fd*Tp = 0.1
else
    error('to do');
    M = 1;
    Tp = Tq;
    Hb = 1;
    Ha = 1;    
end

Kp = ceil(K/M);
g_p = filter_from_white(Hb, Ha, N_c, Kp, Tp, 'shuffle');

% Interpolate
g_int = zeros(N_c, K);
for i=1:N_c
g_int_i = interp(g_p(i,:), M);
g_int(i,:) = g_int_i(1:K);
end

% sum(abs(g_int).^2, 2) / K
% bandpower(g_int(1,:))

% Scale with the PDP
g = zeros(N_c, K);
for i=1:K
    g(:,i) = pdp .* g_int(:, i);
end

% Add the constant gain
g(1,:) = g(1,:) + C;
end
