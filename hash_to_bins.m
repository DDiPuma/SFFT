function U = hash_to_bins(x, X_p, sigma, a, b, B, delta, alpha)

n = size(x);
Y = zeros(size(x));
Y_p = zeros(size(x));
U = zeros(size(x));

g, G_p = window(B, n, alpha, delta);

% Note - jn/B is an integer provided that B is a power of 2

for j=1:B
   Y(mod(j*n/B, n)) = g .* permute_signal(sigma, a, b, x);
end

for j=1:B
    % TODO - We need the FFT of the permutation of x_p, I think
    % Of course, the paper's notation is nebulous as always
    Y_p(mod(j*n/B, n)) = Y(mod(j*n/B, n)) - conv(G_p, permute_signal(sigma, a, b, X_p));
end

for j=1:B
    U(j) = Y_p(mod(j*n/B, n))
end

end
