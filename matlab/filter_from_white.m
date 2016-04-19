function [y, rngstate_used] = filter_from_white(b, a, N, M, seed)
% FILTER_FROM_WHITE  Generate a r.p. with a given PSD
%   y = FILTER_FROM_WHITE(b, a, N, M) Randomly generate a r.p. by filtering
%   complex white noise with the discrete filter [b, a]. The output is an
%   NxM matrix where each row is an independent process with the given PSD.
%   The output is normalized in order to have a statistical power close to
%   1.
%   y = FILTER_FROM_WHITE(b, a, N, M, seed) Use the given seed to generate
%   the r.p.
%   [y, rngstate_used] = FILTER_FROM_WHITE(...) Return the rng state as it
%   was before the white noise generation.

if nargin < 5
    seed = 'shuffle';
end
rngstate_old = rng(seed);
rngstate_used = rng();
w = sqrt(0.5) .* (randn(N, M) + 1j*randn(N, M));
rng(rngstate_old);

y_unnorm = filter(b, a, w, [], 2);

H = freqz(b, a, 'whole', M);
Eh =  1/M * norm(H)^2;

y = y_unnorm ./ sqrt(Eh);
end
