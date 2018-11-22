function result = noiseless_sparse_fft_inner(x, kp, outer, alpha)
% Compute the inner rounds of an SFFT

Beta = 1e-9;
n = size(x);
L = n;

B = kp/Beta;
delta = 1/(4*n^2*L);

rng(0, 'twister');
sigma = 2*randi([0 n/2-1], 1, 1) + 1;
b = randi([1 n], 1, 1);

u = hash_to_bins(x, outer, sigma, 0, b, B, delta, alpha);
u_p = hash_to_bins(x, outer, sigma, 1, b, B, delta, alpha);

w = zeros(size(x));

J = find(u > 0.5);

for j=J
    a = u(j)/u_p(j);
    % TODO - check sigma^-1
    % By my understanding, that should not be an integer
    % That's going to be a problem in about 2 lines
    % I assume inverse has some other meaning in modulo arithmetic
    i = sigma^-1 * mod(round(arg(a)*n/(2*pi)), n);
    v = round(u(j));
    w(i) = v
end

result = w;

end
