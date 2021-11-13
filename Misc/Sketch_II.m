clear all; close all;

input_image = imread('C:\Users\Ryan Smith\Documents\Octave\Misc\StrobeScanCropped.jpg');
input_image = imrotate(mean(input_image,3),-90);

[U, S, V] = svd(input_image);

r = 100;
sub_r = 30;

for i = 1:r
  partials(:,:,i) = U(:,i) * S(i,i) * V(:,i)';
  
  if i <= sub_r
    subplot(6, 5, i)
    imagesc(partials(:,:,i))
    colormap bone;
    title(num2str(i))
   endif
endfor

figure;
imagesc(sum(partials(:,:,2:r),3))
colormap bone;
title('Sum of partials')


##
for ind = 1:20
  progbar(ind,20)
endfor

a = randi(100,1);