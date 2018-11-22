function permuted = permute(sigma, a, b, x)

n = size(x);
permuted = zeros(size(x));

for i=1:n
    x_idx = mod(round(sigma*(i-a)), n) + 1;
    omega = exp(-2*pi*i/n);
    permuted(i) = x(x_idx) * omega^(sigma*b*i);
end

end
