% low key not working rn


% Hit it with a Laplacian
%laplacian1D = [1 -2 1];
%laplacian2DNotNormal = imfilter(laplacian1D,laplacian1D','full');
%laplacian2D = normalize(laplacian2DNotNormal);
%laplacian2D = imfilter(laplacian1D,laplacian1D','full');
lapalacian2D = [0 -1 0; -1 4 -1; 0 -1 0];
smoothedImageH = imread('smoothedGrayImage.jpg');
smoothedImage = double(smoothedImageH);
laplaceImage = imfilter(smoothedImage,laplacian2D,'full');


%greyscale, surfaceMap and display laplacian
figure(1);
surf(laplaceImage);
figure(2);
colormap(gray);
imagesc(laplaceImage);