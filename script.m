%%authors: דפנה קופל 209051036 , צבי פישר 037580644
%% wolf.tif
close all;
clear;
im = readImage('wolf.tif');
showImage(im);
Fim = fft2(im);
showFFT(Fim);
fprintf('as we can see there are 4 points of interest.\n');
mypause;
% as we can see there are 4 points of interest.
magnitudeFim = abs(Fim);
magnitudeFim(1,1) = 0;
% find the max values in the FFT(exclude the DC)
M = max(magnitudeFim,[],'all');
[u,v] = find(M==magnitudeFim);
% now i know the indices of that frequency(row,col). in order not to cancel that
% frequency(insert zero) i use the mean.
r = 2;
averaged = cleanImageMean(Fim(u(1)-r:u(1)+r,v(1)-r:v(1)+r),r,2);
averaged = averaged(r+1,r+1);
Fim(u(1),v(1)) = averaged;
averaged2 = conj(averaged);
Fim(u(2),v(2)) = averaged2;
fprintf('After cleaning 2 points.\n');
showImage(ifft2(Fim));
showFFT(Fim);
mypause;
% i found that those are the frequency is at:
u1 = 20;v1 = 226;
u2 = 238;v2 = 32;
averaged = cleanImageMean(Fim(u1(1)-r:u1(1)+r,v1(1)-r:v1(1)+r),r,2);
averaged = averaged(r+1,r+1);
Fim(u1,v1) = averaged;
Fim(u2,v2) = conj(averaged);
fprintf('After cleaning 4 points.\n');
showFFT(Fim);
cleanedIm = ifft2(Fim);
showImage(cleanedIm);
%% lateShow
close all;
clear;
im = readImage('lateShow.tif');
showImage(im);

% find image dimentions.
rmax = size(im,1);
cmax = size(im,2);
[r,c] = find(im);
ul = [min(r),min(c)];   %upper left point
br = [max(r),max(c)];   %bottom right point
smallIm = im(ul(1):br(1),ul(2):br(2));
showImage(smallIm);
smallImRowSize = size(smallIm,1);
smallImColSize = size(smallIm,2);
tFim = fft2( smallIm );
zeroPadded = zeros(smallImRowSize,smallImColSize);
zeroPaddedFim = [zeroPadded,zeroPadded,zeroPadded;...
    zeroPadded,tFim,zeroPadded;...
    zeroPadded,zeroPadded,zeroPadded];
% padd with zeros
Fim = zeros(rmax,cmax);
%FimShifted = fftshift(tFim);
%FimShifted(1:smallImRowSize,1:smallImColSize) = fftshift(tFim);

%Fim = fftshift(FimShifted);





%Fim(ul(1):br(1),-ul(2):br(2)) = tFim;
%Fim(1:smallImRowSize/2,1:smallImColSize/2) = tFim(smallImRowSize/2+1:smallImRowSize,smallImColSize/2+1:smallImColSize);
%Fim(rmax-smallImRowSize/2+1:rmax,1:smallImColSize/2) = tFim(1:smallImRowSize/2,1:smallImColSize/2);
%Fim(1:smallImRowSize/2,cmax-smallImColSize/2+1:cmax) = ... 
%   tFim(smallImRowSize/2+1:smallImRowSize,1:smallImColSize/2);
%Fim(rmax-smallImRowSize/2+1:rmax,cmax-smallImColSize/2+1:cmax) = ...
%    tFim(1:smallImRowSize/2,1:smallImColSize/2);

showFFT(fftshift(zeroPaddedFim));
%showFFT(Fim);

extractedIm = ifft2(zeroPaddedFim);
showImage(extractedIm);
%% windows.tif
%{
Assuming gaussian noise without blurring.
%}
alpha = 0.6;
std = 10;
radius = 3;
close all;
im = readImage('windows.tif');
%showImage(im);
f = baysianDenoising1(im,alpha,radius,std);
showImage(f);
