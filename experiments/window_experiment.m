n = 8192;
B = 32;

delta = 1e-3;

alpha = 0.25;

C = (1-alpha/2)/(2*B);
sigma = (4*B/alpha)*sqrt(2*log(n/delta));

num_ones = floor(abs(n*(C - sqrt(2*log(n/delta))/sigma)));

num_zeros = n - ceil(abs(n*(C + sqrt(2*log(n/delta))/sigma)));

% Initialize the ones where they need to be
% Put zeros everywhere else
G_p = [ones(num_ones, 1);
    zeros(n - num_ones, 1)];

% Now fill in the CDF values everywhere else
for i=(num_ones+1):(n-num_zeros)
    G_p(i) = cdf('Normal', sigma*(i+C)/n, 0, sigma) - cdf('Normal', sigma*(i-C)/n, 0, sigma);
end
