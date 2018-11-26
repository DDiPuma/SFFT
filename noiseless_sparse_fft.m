function X_p = noiseless_sparse_fft(x, k)
% Compute the exactly k-sparse SFFT of x

X_p = zeros(size(x));

for t=0:log(k)
    k_t = k/2^t;
    alpha_t = 2^-t;
    X_p = X_p + noiseless_sparse_fft_inner(x, k_t, X_p, alpha_t);
end

end
