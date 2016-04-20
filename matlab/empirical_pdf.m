function [f, x] = empirical_pdf(V,nbin)
  [counts, centers] = hist(V,nbin);
  step = centers(2)-centers(1);
  x = centers;
  f = counts/sum(counts)/step;
end
