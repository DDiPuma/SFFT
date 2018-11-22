function result = noiseless_sparse_fft(x, k)
% Compute the exactly k-sparse SFFT of x

result = zeros(k, 1);

for t=0:log(k)
    k_t = k/2^t;
    alpha_t = 2^-t;
    result = result + noiseless_sparse_fft_inner(x, k, result, alpha_t);
end

end
