function g, G_p = window(B, n, delta, alpha)
% Compute a window and its Fourier transform
% B is bandwidth, delta is error tolerance

Boxcar = [ones(n/B, 1); zeros(n-n/B, 1)];
boxcar = ifft(Boxcar);

sigma = B*sqrt(log(n));

gauss = gausswin(n, 1/sigma);

g = gauss.*boxcar;
G_p = fft(g);

end
