clear;
% simple function that smooths a given input image with
% a gaussin that is defined within the code of this function
ColorIm = imread('vcv.jpg');
ColorIm = double(ColorIm);

%greyscale either before or after applying filter
%GrayIm = (ColorIm(:,:,1) + ColorIm(:,:,2) + im(:,:,3)) / 3;

%create gaussin filter
% --> adjust these to adjust filtering
% --> xArray = -(3*sigma):(3*sigma)
sigma = 4; 
xArray = -(3*sigma):(3*sigma);
gaussin1D = exp(-1/(2*sigma^2) * xArray.^2); %not entirely sure what this is
gaussin1D = gaussin1D / sum(gaussin1D);
gaussin2D = imfilter(gaussin1D,gaussin1D','full');
%gaussin2D = normalize(gaussin2DNotNormal);

%use grayscaling here or use GrayIm
colorSmooth = imfilter(ColorIm,gaussin2D,'same','replicate'); %replicate is boundry handling(?)
graySmoothedImage = (colorSmooth(:,:,1) + colorSmooth(:,:,2) + colorSmooth(:,:,3)) / 3;
% greySmoothedImage = imfilter(GrayIm,gaussin2D,'same','replicate');

%toggle lines 7 and 19-21 to change when grayscaling done

imwrite(uint8(graySmoothedImage),'smoothedGrayImage.jpg','jpeg');
