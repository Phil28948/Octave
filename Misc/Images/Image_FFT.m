close all, clear all;
warning('off');

##inputs, preprocessing
face = imread('photo.jpg');
dog = imread('better_face.jpg');

g_face = sum(face,3)/3;
g_dog = sum(dog,3)/3;

##basic setup
input_image = g_face;
res = zeros(size(input_image,1), size(input_image,2), size(input_image,3));
fh = fft2(input_image);

#parameters, intensity 0 = identity kernel (gain always = 1)
[XX YY] = meshgrid(linspace(-5,5,10));
k1_intensity = 12; 
k2_intensity = .3; 
hp_cutoff = .95; #% passed

##k1 (gaussian)
k1 = exp(-(XX .^ 2 + YY .^ 2)/k1_intensity);
k1 = k1/(sum(sum(k1))/numel(k1))/100;

for i = 1:size(input_image,3)
  res(:,:,i) = conv2(input_image(:,:,i),k1, 'same');
end

#plot original
subplot(2,2,1)
imagesc(input_image), colormap(gray), title('Original'), axis off;

#plot gaussian
subplot(2,2,2)
imagesc(res), colormap(gray), axis off, title(['Gaussian, effect intensity: ' num2str(k1_intensity)]); 

#k2 (sharpen)
k2 = [0 -1 0; -1 5 -1; 0 -1 0];
k2 = k2 * k2_intensity;
k2(2,2) = k2(2,2) + (1 - sum(sum(k2))); #adjust gain to unity

for i = 1:size(input_image,3)
  res(:,:,i) = conv2(input_image(:,:,i),k2, 'same');
end

#plot sharpen
subplot(2,2,3)
imagesc(res), colormap(gray), axis off, title(['Sharpen, effect intensity: ' num2str(k2_intensity)]); 

###hp_mask
##ind = 0;
##hp_mask = zeros(size(input_image,1), size(input_image,2));
##
##hp1 = round(size(input_image,1) * hp_cutoff) * .5;
##hp2 = round(size(input_image,2) * hp_cutoff) * .5;
##
##for d2 = 1:size(input_image,2)
##  for d1 = 1:size(input_image,1)
##    ind = ind + 1;
##    if (abs(d1 - (size(input_image,1)/2)) < hp1) & (abs(d2 - (size(input_image,2)/2)) < hp2)
##      hp_mask(ind) = 1;
##    endif
##  endfor
##endfor
##
###plot high pass
##res = hp_mask .* fh;
##res = ifft2(res);
##subplot(2,2,4)
##imagesc(abs(res)), colormap(gray), axis off, title(['High Pass, cutoff: ' num2str(1 - hp_cutoff)]); 

##k31 = [-1 0 1; -1 0 1; -1 0 1];
##k32 = [1 1 1; 0 0 0; -1 -1 -1];
k31 = [-1 -1 -1 0 1 1 1; -1 -1 -1 0 1 1 1; -1 -1 -1 0 1 1 1; -1 -1 -1 0 1 1 1; -1 -1 -1 0 1 1 1; -1 -1 -1 0 1 1 1; -1 -1 -1 0 1 1 1];
k32 = [1 1 1 1 1 1 1; 1 1 1 1 1 1 1; 1 1 1 1 1 1 1; 0 0 0 0 0 0 0; -1 -1 -1 -1 -1 -1 -1; -1 -1 -1 -1 -1 -1 -1; -1 -1 -1 -1 -1 -1 -1];

k31 * 5; k32 * 5;

vert = conv2(input_image, k31, 'same');
horz = conv2(input_image, k32, 'same');
res = vert + horz;

subplot(2,2,4)
imagesc(abs(res)), colormap(gray), axis off, title('Edges'); 

##unsharp
k4 = [1 4 6 4 1; 4 16 24 16 4; 6 24 -476 24 6; 4 16 24 16 4; 1 4 6 4 1] * -(1/256);
res = conv2(input_image, k4, 'same');

figure;
subplot(2,1,1)
imagesc(input_image), colormap(gray), axis off, title('Original'); 

subplot(2,1,2)
imagesc(res), colormap(gray), axis off, title('Unsharp masking'); 



