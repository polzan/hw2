function [ h_ls, sigma2w_estim, epsilon_des] = ls_method(x, d, N_fil)
phi = zeros(N_fil, N_fil);
theta = zeros(1,N_fil);
L = length(x);

for i = 0:N_fil-1
    for t = 0:N_fil-1
         phi(i+1,t+1) = circshift(x(1:L),i,2)*circshift(x(1:L),t,2)';
%        phi(i+1,t+1) = circshift(x,i,2)*circshift(x,t,2)';
    end
end


for m = 0 : N_fil-1
     theta(1,m+1) = d(1:L)*circshift(x(1:L),m,2)';
%    theta(1,m+1) = d*circshift(x,m,2)';

end

h_ls = linsolve(phi,theta');


epsilon_des = sum(abs(d).^2);
e_min = epsilon_des - theta*h_ls;
sigma2w_estim = e_min/L;

% cost_f = epsilon_des - h_ls'*theta' - theta*h_ls +  h_ls'*phi'*h_ls;

h_ls = h_ls';

end

