function g = generate_ch_response(Tq, fd, pdp, C, N_ch, K, seed)
if fd == 0
    g_t = sqrt(pdp) .* (randn(N_ch, 1) + 1j*randn(N_ch, 1));
    g = repmat(g_t, 1, K);
elseif fd > 0
    M = round(0.1 / (fd*Tq)); % Interpolation factor to get the desired fd
    %Tp = M*Tq;
    [Hb, Ha] = classical_doppler_filter(); % This assumes fd*Tp = 0.1
    
    dopp_length = 250; %Tp
    interp_length = 2*4*M + 1; % Tq
    
    Kp = ceil(K/M) + dopp_length + ceil(interp_length/M); % Num of samples to simulate
    g_dopp = filter_from_white(Hb, Ha, N_ch, Kp, seed);
    g_dopp = g_dopp(:, dopp_length:Kp); % Drop the transient of h_ds
    
    % Interpolate
    g_dopp_int = zeros(N_ch, K);
    for i=1:N_ch
        g_int_i = interp(g_dopp(i,:), M, 4, 0.5); % FIR length 2nr+1, bandwidth alphaFs
        g_dopp_int(i,:) = g_int_i(interp_length:interp_length+K-1); % Drop the transient of the interpolator
    end
    
    % Set the power with the PDP
    g = zeros(N_ch, K);
    for i=1:K
        g(2:N_ch,i) = sqrt(pdp(2:N_ch)) .* g_dopp_int(2:N_ch, i);
    end
    
    % Add the constant gain
    g(1,:) = g_dopp_int(1, :) .* sqrt(pdp(1) - C^2) + C;
end
end
