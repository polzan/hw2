function g = generate_ch_response(Tq, fd, pdp, C, N_ch, K)
if fd == 0
    error('to do');
elseif fd > 0
    M = round(0.1 / (fd*Tq)); % Interpolation factor to get the desired fd
    Tp = M*Tq;
    [Hb, Ha] = classical_doppler_spectrum(); % This assumes fd*Tp = 0.1
    
    % TODO: Add the transient duration!
    Kp = ceil(K/M); % Simulate the samples needed to interpolate
    g_dopp = filter_from_white(Hb, Ha, N_ch, Kp);
    
    % Interpolate
    g_dopp_int = zeros(N_ch, K);
    for i=1:N_ch
        g_int_i = interp(g_dopp(i,:), M, 4, 0.5); % FIR length 2nr+1, bandwidth alphaFs
        g_dopp_int(i,:) = g_int_i(1:K);
    end
    
    % Set the power with the PDP
    g = zeros(N_ch, K);
    for i=1:K
        g(:,i) = sqrt(pdp) .* g_dopp_int(:, i);
    end
    
    % Add the constant gain
    g(1,:) = g(1,:) + C;
end
end
