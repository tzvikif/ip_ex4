function f = inversFiltering2(g,h,lambda)
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