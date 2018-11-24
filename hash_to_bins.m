function U = hash_to_bins(x, X_p, sigma, a, b, B, delta, alpha)

n = size(x);
Y = zeros(size(x));
Y_p = zeros(size(x));
U = zeros(size(x));

% Note - jn/B is an integer provided that B is a power of 2

for j=1:B
   Y(mod(j*n/B, n)) = window(B, alpha, delta) .* permute(sigma, a, b, x);
end

for j=1:B
    g, G_p = window(B, alpha, delta);
    % TODO - check that permuting X_p is the correct notation here
    Y_p(mod(j*n/B, n)) = Y(mod(j*n/B, n)) - conv(G_p, permute(sigma, a, b, X_p));
end

for j=1:B
    U(j) = Y_p(mod(j*n/B, n))
end

end
