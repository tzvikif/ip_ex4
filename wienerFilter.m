function [Wiener] = wienerFilter(in_img, H, SNR)

G=fftshift(fft2(in_img));
F3=G.*H ./(H.^2 + (1/SNR));
F3=ifftshift(F3);
Wiener=uint8(abs(ifft2(F3)));

end
    