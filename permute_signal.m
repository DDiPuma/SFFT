function permuted = permute_signal(sigma, a, b, x)

n = length(x);
permuted = zeros(size(x));

for idx=1:n
    x_idx = mod(sigma*round(idx-a), n) + 1;
    omega = exp(-2*pi*idx/n);
    permuted(idx) = x(x_idx) * omega^(sigma*b*idx);
end

end
