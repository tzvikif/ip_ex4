%{
Denoises image using median filtering.

   Input:   im - a grayscale image array in the range [0..255].
            radius – the radius of the filtering mask. Filtering mask is square.
            Thus window at location r,c is coordinated: [r-radius:r+radius,c-radius:c+radius]

   Output:  cleanIm - grayscale image in the range [0..255] same size as im.

   Method:  Apply median filtering with neighborhood of radius maskSize.
            You may loop over the image pixels. You may used matlab function median.
            No need to compute at pixels where the neighborhood extends
            beyond the bounds of the image. Set these pixels to 0 so that cleanIm is same size as im.
%}
function cleanIm = cleanImageMedian (im, varargin)
    if nargin == 2
      radiusRow = varargin{1};
      radiusCol = radiusRow;
    else
        radiusRow = varargin{1};
        radiusCol = varargin{2};
    end
    
    imRowSize = size(im,1);
    imColSize = size(im,2);
    bigIm = zeros(imRowSize+2*radiusRow,imColSize+2*radiusCol);
    bigIm(1+radiusRow:imRowSize+radiusRow,1+radiusCol:imColSize+radiusCol) = im;
    cleanIm = zeros(imRowSize,imColSize);
    for r=1+radiusRow:imRowSize+radiusRow
        for c=1+radiusCol:imColSize+radiusCol
            mask = bigIm(r-radiusRow:r+radiusRow,c-radiusCol:c+radiusCol);
            cleanIm(r-radiusRow,c-radiusCol) = median(mask,'all');
        end
    end
end