function inverse = modular_inverse(a, m)
% Find the modular inverse of a in modulo m
% Returns -1 on failure

% Matrix-ified version of the algorithm described in
% https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm

mat = [0 1;
       m a];

while mat(2, 2) ~= 0
    quot = floor(mat(2, 1) / mat(2, 2));
    
    mat = [mat(:, 2) mat(:, 1)-quot*mat(:, 2)];
end

t = mat(1, 2);
r = mat(2, 2);

if t < 0
    t = t + m;
end

if r > 1
    t = -1;
end

inverse = t;

end
