function result = noiseless_sparse_fft_inner(x, kp, X_p, alpha)
% Compute the inner rounds of an SFFT

n = size(x);
L = n;

% Choose Beta such that B is a power of 2
% Note that this restricts n to fairly 2^7 or higher to have meaningful bins
Beta = kp*2^-(log2(n)-6);

B = kp/Beta;
delta = 1/(4*n^2*L);

rng(0, 'twister');
sigma = 2*randi([0 n/2-1], 1, 1) + 1;
b = randi([1 n], 1, 1);

u = hash_to_bins(x, X_p, sigma, 0, b, B, delta, alpha);
u_p = hash_to_bins(x, X_p, sigma, 1, b, B, delta, alpha);

w = zeros(size(x));

J = find(u > 0.5);

for j=J
    a = u(j)/u_p(j);
    i = mod(modular_inverse(sigma, n) * round(arg(a)*n/(2*pi)), n);
    v = round(u(j));
    w(i) = v
end

result = w;

end
