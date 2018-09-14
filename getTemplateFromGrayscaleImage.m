%get a template function

im = imread('smoothedGrayImage.jpg');
im = double(im);
fprintf(1, 'Choose templte');

figure(7);
imagesc(im);
colormap(gray);
axis equal;

[x,y] = ginput(1);
x = round(x); y=round(y);
halfwid = 30;  
plot([x-halfwid x-halfwid x+halfwid x+halfwid x-halfwid],...
     [y-halfwid y+halfwid y+halfwid y-halfwid y-halfwid],'r');
hold on
drawnow
deltavec = -halfwid:halfwid;
patch = double(im(y+deltavec, x+deltavec));
patch = patch - mean(patch);
figure(2);
imagesc(patch);

imwrite(uint8(patch),'template.jpg','jpeg');

vec = reshape(patch,1,prod(size(patch)));

%display patch as 3D surface
%note: flipud in following line reflects image patch.  This is needed so
%that surface drawn by surf looks like the image patch (due to a left vs right
%hand coordinate system inconsistency in some matlab functions).
figure(3);  colormap(gray); surf(flipud(patch)); drawnow;