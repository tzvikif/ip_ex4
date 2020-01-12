%%authors: דפנה קופל 209051036 , צבי פישר 037580644
%%
im = readImage('wolf.tif');
Fim = fft2(im);
D = log(1+abs(Fim));
D = fftshift(D);
%colormap gray;
%imagesc(D);
%find max
magnitudeFim = abs(Fim);

Fim(1,1) = 0;
m = find(max(abs(Fim),[],'all'));
a = 5;
%%
