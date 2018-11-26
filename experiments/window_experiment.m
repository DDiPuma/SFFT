n = 2^7;
B = 2^2;

H = [ones(n/B, 1); zeros(n-n/B, 1)];
h = ifft(H);

sigma = B*sqrt(log(n));

g = gausswin(n, 1/sigma);
G = fft(g);

f = g.*h;
F = fft(f);

figure;
title("Frequency Response of Achieved Filter");
plot(abs(F));
figure;
title("Impulse Response of Achieved Filter");
plot(abs(f));
