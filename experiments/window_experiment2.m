B=64;
N=2^10; alpha=B*sqrt(log(N));
G_gaussian = gausswin(N,alpha); % alpha is recipricol of standard deviation
G_cheby = chebwin(N,alpha); % alpha determines the dielobe attenuation
figure;
stem(G_gaussian)
title('Ggaussian')
figure;
stem(G_cheby)
title('Gcheby')
figure;
stem(abs(fftshift(fft(G_gaussian))))
title('Ghatgaussian')
figure;
stem(abs(fftshift(fft(G_cheby))))
title('Ghatcheby')


H_boxcar = boxcar(N/B);
figure;
stem(H_boxcar)
title('Hboxcar')


Fhat_gaussian = conv(fft(G_gaussian), H_boxcar);
Fhat_cheby = conv(fft(G_cheby), H_boxcar);
figure;
Fhat_gaussian = fftshift(Fhat_gaussian);
Fhat_cheby = fftshift(Fhat_cheby);
stem(abs(Fhat_gaussian))
title('Fhatgaussian')
figure;
stem(abs(Fhat_cheby))
title('Fhatcheby')

figure;
stem(abs(ifft(Fhat_gaussian)))
title('Fgaussian')
figure;
stem(abs(ifft(Fhat_cheby)))
title('Fcheby')