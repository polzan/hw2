function y = rice_pdf(x, K)
assert(all(x >= 0));
y = 2*(1+K) * x .* exp(-K-(1+K) * x.^2) .* besseli(0, 2*x*sqrt(K*(1+K)));
end
