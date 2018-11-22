function result = hash_to_bins(x, outer, sigma, a, b, B, delta, alpha)

y = zeros(size(x));
y_p = zeros(size(x));
u = zeros(size(x));

for j=1:B
    y(j*n/B) = window(B, alpha, delta) .* permute(sigma, a, b, x);
end

for j=1:B
    y_p(j*n/B) = y(j*n/B) - % TODO
end

for j=1:B
    u(j) = y_p(j*n/b)
end

end
