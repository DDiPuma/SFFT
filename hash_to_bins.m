function result = hash_to_bins(x, outer, sigma, a, b, B, delta, alpha)

n = size(x);
y = zeros(size(x));
y_p = zeros(size(x));
u = zeros(size(x));

% Note - jn/B is an integer provided that B is a power of 2

for j=1:B
    y(mod(j*n/B, n)) = window(B, alpha, delta) .* permute(sigma, a, b, x);
end

for j=1:B
    y_p(mod(j*n/B, n)) = y(mod(j*n/B, n)) - % TODO
end

for j=1:B
    u(j) = y_p(mod(j*n/B, n))
end

end
