n = 2^17;
B = 2^12;

H = [ones(n/B, 1); zeros(n-n/B, 1)];
h = ifft(H);

sigma = B*sqrt(log(n));

g = gausswin(n, 1/sigma);
G = fft(g);

f = g.*h;
F = fft(f);

figure;
plot(abs(F));
title("Frequency Response of Achieved Filter");
figure;
plot(abs(f));
title("Impulse Response of Achieved Filter");

