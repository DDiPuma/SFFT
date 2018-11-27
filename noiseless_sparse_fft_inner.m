function result = noiseless_sparse_fft_inner(x, kp, X_p, alpha)
% Compute the inner rounds of an SFFT

n = length(x);
L = n;

% Choose Beta such that B is a power of 2
% Note that this restricts n to roughly 2^8 or higher to have meaningful bins
Beta = kp/(2^(floor(log2(n)-5)));

B = kp/Beta;
delta = 1/(4*n^2*L);

rng(0, 'simdTwister');
sigma = 2*randi([0 n/2-1], 1, 1) + 1;
b = randi([1 n], 1, 1);

U = hash_to_bins(x, X_p, sigma, 0, b, B, delta, alpha);
U_p = hash_to_bins(x, X_p, sigma, 1, b, B, delta, alpha);

W = zeros(size(X_p));

J = find(abs(U) > 0.5);

for j_idx=J
    a = U(j_idx)./U_p(j_idx);
    idx = mod(modular_inverse(sigma, n) * round(angle(a)*n/(2*pi)), n);
    v = round(U(j_idx));
    W(idx+1) = v;
end

result = W;

end