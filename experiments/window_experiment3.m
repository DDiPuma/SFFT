% Given a window G and parameters B, delta, sigma
% Find Ghat_p that satisfies the constraints

% Ghat_p(i) = 1 for abs(i) <= (1-sigma)n/(2B)
% Ghat_p(i) = 0 for abs(i) >= n/(2B)
% Ghat_p(i) is between [0,1] for all i
% infinity norm Ghat_p - Ghat < sigma

B=2^5; n=2^10; alpha=B*sqrt(log(n));
temp_gaussian = gausswin(n,alpha);
temp_cheby = chebwin(n,alpha);
H_boxcar = boxcar(n/B);
Ghat = fftshift(conv(fft(temp_cheby), H_boxcar, 'same'));
% Ghat = Ghat/max(Ghat);
sigma = .5;
% Ghat_p = zeros(n,1);
% 
% Ghat_p(n/2) = 1;
% for j = 1:(n/2)
%     if j <= (1-sigma)*n/(2*B)
%         Ghat_p((n/2)+j) = 1;
%         Ghat_p((n/2)-j) = 1;
%     end
%     if j >= n/(2*B)
%         Ghat_p((n/2)+j) = 0;
%         Ghat_p((n/2)+1-j) = 0;
%     end
% end

cvx_begin
    variable Ghat_p(n)
    minimize( norm(Ghat_p-Ghat,Inf))
    subject to
        norm(Ghat_p-Ghat,Inf) <= sigma
        Ghat_p >= 0; Ghat_p <= 1;
        for j = 1:(n/2)
            if j <= (1-sigma)*n/(2*B)
                Ghat_p((n/2)+j) == 1;
                Ghat_p((n/2)-j) == 1;
            elseif j >= n/(2*B)
                Ghat_p((n/2)+j) == 0;
                Ghat_p((n/2)+1-j) == 0;
            end
        end
cvx_end