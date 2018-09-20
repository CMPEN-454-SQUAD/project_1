%TopToBottom method
ColorIm = imread('vcv.jpg');
ColorIm = double(ColorIm);

GrayIm = (ColorIm(:,:,1) + ColorIm(:,:,2) + ColorIm(:,:,3)) / 3;

sigma = 4; 
xArray = -(3*sigma):(3*sigma);
gaussin1D = exp(-1/(2*sigma^2) * xArray.^2); %normalization
gaussin1D = gaussin1D / sum(gaussin1D);
gaussin2D = imfilter(gaussin1D,gaussin1D','full');

graySmoothedImage = imfilter(GrayIm,gaussin2D,'same','replicate'); %replicate is boundry handling(I think)

fprintf(1, 'Choose sideways template\n');

figure(7);
imagesc(graySmoothedImage);
colormap(gray);
axis equal;

[x,y] = ginput(1);
x = round(x); y=round(y);
halfwid = 30;                   %adjust this
plot([x-halfwid x-halfwid x+halfwid x+halfwid x-halfwid],...
     [y-halfwid y+halfwid y+halfwid y-halfwid y-halfwid],'r');
hold on
drawnow
deltavec = -halfwid:halfwid;
patch1 = double(graySmoothedImage(y+deltavec, x+deltavec));
patch1 = patch1 - mean(patch1);
close all;
figure(2);
imagesc(patch1);

% fprintf(2,'Choose vertical template\n');
% 
% figure(90);
% imagesc(graySmoothedImage);
% colormap(gray);
% axis equal;
% 
% [x,y] = ginput(2);
% x = round(x); y=round(y);
% halfwid = 30;                   %adjust this
% plot([x-halfwid x-halfwid x+halfwid x+halfwid x-halfwid],...
%      [y-halfwid y+halfwid y+halfwid y-halfwid y-halfwid],'r');
% hold on
% drawnow
% deltavec = -halfwid:halfwid;
% patch2 = double(graySmoothedImage(y+deltavec, x+deltavec));
% patch2 = patch2 - mean(patch2);
% close all;
% figure(3);
% imagesc(patch2);
% 
% patchBoth = imfilter(patch1,patch2,'same','replicate');

heatMap = imfilter(graySmoothedImage,patch1,'same','replicate');

figure(10);
imagesc(heatMap);
% 
% mask = ones(3); mask(5) = 0;
% mixOut = ordfilt2(heatMap,8,mask);
% oneOut = heatMap > mixOut;
% [row,col] = find(oneOut == 1);
% heatList = heatMap([row, col]);

derivFilter = [1 0 -1];
deriv2D = imfilter(derivFilter,derivFilter','full');
heatDeriv = imfilter(heatMap,deriv2D,'conv','same','replicate');

figure(4);
imagesc(heatDeriv);
colormap(gray);
abHD = abs(heatDeriv);
[row, col] = find(abHD < 10000);
l1 = [col,row];
thresh = (max(max(heatMap)) * .5);

[hRow,hCol] = find(heatMap > thresh);
l2 = [hCol,hRow];

outA = intersect(l1,l2,'rows');

fullIm = imread('vcv.jpg');

mtrx = ones(size(outA,1),1,'double');
mtrx = mtrx .* 3;
drawList = [outA,mtrx];

drawing = insertShape(fullIm,'circle',drawList,'LineWidth',5,'Color','red');
figure(1);
imagesc(drawing);
