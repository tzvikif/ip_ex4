function f = baysianDenoising1(g,alpha,radius,std)
    rows = size(g,1);
    cols = size(g,2);
    f = zeros(rows,cols);
    bigG = zeros(rows+2*radius,rows+2*radius);
    bigG(1+radius:cols+radius,1+radius:cols+radius) = g;
    W = cleanImageMean(ones(radius*2+1),radius,std);
    for i=1+radius:rows+radius
        for j=1+radius:cols+radius
            %Neighbors of pixel BigG(i,j)
            Ns = bigG(i-radius:i+radius,j-radius:j+radius);
            fs = (1-alpha).*bigG(i,j) + ...
                alpha*sum(Ns.*W,'all')/(sum(W,'all'));
            f(i,j) = fs;
        end
    end
    f = f(radius+1:radius+rows,radius+1:radius+cols);
end