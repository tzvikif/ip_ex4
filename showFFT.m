function D = showFFT(Fim)
    figure;
    D = log(1+abs(Fim));
    D = fftshift(D);
    colormap gray;
    imagesc(D);
end