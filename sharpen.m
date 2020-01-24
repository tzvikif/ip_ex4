%{
basically Bsharp. 

   Input:   f - a grayscale image array in the range [0..255].
            P - the radius for the high pass filter
            lambda  - ratio parameter
   Output:   newIm - grayscale image in the range [0..255] same size as im.
   Method:  sharpen. using high pass filter to add more "power" to high
   frequencies.
%}
function newIm = sharpen(f,P,lambda)
    [M,N]=size(f);
    F=fft2(double(f));
    u=0:(M-1);
    v=0:(N-1);
    idx=find(u>M/2);
    u(idx)=u(idx)-M;
    idy=find(v>N/2);
    v(idy)=v(idy)-N;
    [V,U]=meshgrid(v,u);
    D=sqrt(U.^2+V.^2);
    H=double(D>=P);
    G=H.*F;
    newIm=real(ifft2(double(lambda.*G+F)));
end