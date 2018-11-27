function U = hash_to_bins(x, X_p, sigma, a, b, B, delta, alpha)

n = length(x);
Y_p = zeros(B, 1);
y = zeros(B, 1);

[g, G_p] = window(B, n, alpha, delta);

% Note - jn/B is an integer provided that B is a power of 2

permuted = permute_signal(sigma, a, b, x);

for j=1:B
   y(j) = g(j*n/B) * permuted(j*n/B);
end

Y = fft(y);

% TODO - We need the FFT of the permutation of x_p, I think
% Of course, the paper's notation is nebulous as always
c = conv(G_p, permute_signal(sigma, a, b, X_p));
for j=1:B
    Y_p(j) = Y(j) - c(j*n/B);
end

U = Y_p;

end