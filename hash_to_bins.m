function U = hash_to_bins(x, X_p, sigma, a, b, B, delta, alpha)

n = length(x);
Y_p = zeros(size(x));
U = zeros(size(x));

[g, G_p] = window(B, n, alpha, delta);

% Note - jn/B is an integer provided that B is a power of 2

y = g .* permute_signal(sigma, a, b, x);
Y = fft(y);

Y_new = zeros(size(x));
for j=1:B
   Y_new(j) = Y(mod(j*n/B, n) + 1);
end

Y = Y_new;

% TODO - We need the FFT of the permutation of x_p, I think
% Of course, the paper's notation is nebulous as always
c = conv(G_p, permute_signal(sigma, a, b, X_p));
for j=1:B
    Y_p(mod(j*n/B, n) + 1) = Y(mod(j*n/B, n) + 1) - c(mod(j*n/B, n) + 1);
end

for j=1:B
    U(j) = Y_p(mod(j*n/B, n) + 1);
end

end
