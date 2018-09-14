%run a cross corrilation with the image and the temaplte
% returning a 'heat map' of possible planes that hit with
% the given template likelyhood

im = imread('smoothedGrayImage.jpg');
im = double(im);
template = imread('template.jpg');
template = double(template);
heatMap = imfilter(im,template,'same','replicate');

figure(8);
imagesc(heatMap);
imwrite(uint8(heatMap),'heatMap.jpg','jpeg');
max = max(heatMap);
threshold = max * .8;
%[peak, index] = findpeaks(heatMap);
