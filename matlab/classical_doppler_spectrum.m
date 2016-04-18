function D = classical_doppler_spectrum(f, fd)
D = zeros(length(f), 1);
i_nonzero = find(abs(f) < fd);
D(i_nonzero) = 1/(pi*fd) .* 1./sqrt(1-(f(i_nonzero)./fd).^2);
end
