%%authors: דפנה קופל 209051036 , צבי פישר 037580644
%%
close all;
im = readImage('wolf.tif');
Fim = fft2(im);
showFFT(Fim);
% as we can see there are 4 points of interest.
magnitudeFim = abs(Fim);
magnitudeFim(1,1) = 0;
% find the max values in the FFT(exclude the DC)
M = max(magnitudeFim,[],'all');
[u,v] = find(M==magnitudeFim);
% now i know the indices of that frequency(row,col). in order not to cancel that
% frequency(insert zero) i use the mean.
r = 2;
averaged = cleanImageMean(Fim(u(1)-r:u(1)+r,v(1)-r:v(1)+r),radius,2);
averaged = averaged(r+1,r+1);
Fim(u(1),v(1)) = averaged;
averaged2 = conj(averaged);
Fim(u(2),v(2)) = averaged2;
% i found that those are the frequency is at:
u1 = 20;v1 = 226;
u2 = 238;v2 = 32;
averaged = cleanImageMean(Fim(u1(1)-r:u1(1)+r,v1(1)-r:v1(1)+r),radius,2);
averaged = averaged(r+1,r+1);
Fim(u1,v1) = averaged;
Fim(u2,v2) = conj(averaged);

showFFT(Fim);
cleanedIm = ifft2(Fim);
showImage(cleanedIm);
%%