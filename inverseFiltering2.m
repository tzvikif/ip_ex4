%{
inverse Filtering assuming convolution +  noise.

   Input:   g - a grayscale image array in the range [0..255].
            lambda – ratio parameter
            h - the mask
   Output:   f - grayscale image in the range [0..255] same size as im.
   Method:  inverseFiltering2. 
%}
function f = inverseFiltering2(g,h,lambda)
    rows = size(g,1);
    cols = size(g,2);
    G = fft2(g);
    
    H = fft2(h,rows,cols);
    
    F=G.*(conj(H))./(conj(H).*H + lambda);
    %F=ifftshift(F);
    f=uint8(abs(ifft2(F)));
end