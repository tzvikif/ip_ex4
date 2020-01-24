%{
inverse Filtering assuming convolution +  noise.

   Input:   g - a grayscale image array in the range [0..255].
            lambda – ratio parameter
            h - the mask
   Output:   f - grayscale image in the range [0..255] same size as im.
   Method:  wienerFiltering. using U,V to decrease power at high
   frequencies.
%}
function f = wienerFiltering(g,h,lambda)
    rows = size(g,1);
    cols = size(g,2);
    u=0:(rows-1);
    v=0:(cols-1);
    idx=find(u>rows/2);
    u(idx)=u(idx)-rows;
    idy=find(v>cols/2);
    v(idy)=v(idy)-cols;
    [V,U]=meshgrid(v,u);
    
    M = sqrt(U.^2+V.^2);
    G = fft2(g);
    
    H = fft2(h,rows,cols);
    
    F=G.*(conj(H))./(conj(H).*H + lambda.*M);
    %F=ifftshift(F);
    f=uint8(abs(ifft2(F)));
end