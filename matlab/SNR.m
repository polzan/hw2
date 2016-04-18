function [ snr ] = SNR( sigma2w, L, ref, estim, snr_type)
    
N_fil = length(estim);  %length estimation filter

if length(ref) < length(estim)
ref = [ref zeros(1,N_fil-length(ref))]; %to compare
end

if N_fil < length(ref)
estim = [estim zeros(1,length(ref)-N_fil)]; %to compare
end

S = sum(ref.^2)/sigma2w;   %%for theo and ls %%norm??

switch snr_type
    case 'corr'
        snr = 10*log10(sigma2w/(sum(abs(estim-ref).^2))); %%norm or distance?
    case 'ls'
        snr = 10*log10(sigma2w/(sum(abs(estim-ref).^2)));
    case 'theo_corr'
        snr = 10*log10(L/(N_fil+1/L*((N_fil-2)*sum(abs(ref).^2)/sigma2w+S)));
    case 'theo_ls'
        snr = 10*log10(((L+1)*(L+1-N_fil))/(N_fil*(L+2-N_fil)));
    otherwise
        error('unknown SNR type');
end



end

