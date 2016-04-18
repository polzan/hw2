function [h_corr,cost_f] = correlation_method(x, d, N_fil)
L = length(x);
% x = x(N:N+L-1);     %rc signal
h_corr=zeros(1, N_fil);
for m = 0 : N_fil-1
    h_corr(1,m+1) = 1/L*d(1:1 + L-1)*circshift(x(1:L),m,2)';
    %h_corr(1,m+1) = 1/L*d*circshift(x,m,2)';
end


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

epsilon_des = sum(abs(d).^2);
cost_f = epsilon_des - h_corr*theta' - theta*h_corr' +  h_corr*phi'*h_corr';
end

