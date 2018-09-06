%Initially read in file
%and convert to a greyscale image
%by averageing the RGB pixle values
im = imread('dma.jpg');
im = double(im);
grayIm = (im(:,:,1) + im(:,:,2) + im(:,:,3)) / 3;


%right now just display
%figure(1);
colormap(gray);
%imagesc(grayIm);

%save intermediat file
imwrite(uint8(grayIm),'grayScaleIntermediate.jpg','jpeg');

%generate 2d gaussin filter
%   play with sigma values
%   the xArray goes from -(3*sigma):(3*sigma)
%   so need to change too when testing
sigma = 8;
xArray = -24:24;

%first make gaussin 1D
gaussin1D = exp(-1/(2*sigma^2) * xArray.^2); %not entirely sure what this is
gaussin1D = gaussin1D / sum(gaussin1D);

%then filter against itself to make 2D
gaussin2D = imfilter(gaussin1D,gaussin1D','full');
%figure(2);
%imagesc(gaussin2D);

%oneSmooth = imfilter(imfilter(im,gaussin1D','same'),gaussin1D,'same');

%filter the image with this new 2D filter
twoSmooth = imfilter(im,gaussin2D,'same','replicate');
graySmooth = (twoSmooth(:,:,1) + twoSmooth(:,:,2) + twoSmooth(:,:,3)) / 3;

%figure(3);
colormap(gray);
%imagesc(graySmooth);

%print out smooth image
imwrite(uint8(graySmooth),'smoothedImage.jpg','jpeg');

fprintf(1,'Select template');
figure(1);
colormap(gray);
[x,y] = ginput(1);
x = round(x); y = round(y);
hold on;
plot(x,y,'r*');
halfwid = 30;
plot([x-halfwid x-halfwid x+halfwid x+halfwid],...
     [y-halfwid y+halfwid y+halfwid y-halfwid],'r');
hold off; drawnow;

deltavac = -halfwid:halfwid;
patch = double(graySmooth(y+deltavac, x+deltavac));

imwrite(uint8(patch),'template.jpg','jpeg');
figure(2);
imagesc(patch);