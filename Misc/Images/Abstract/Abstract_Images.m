close all; clear all;

m = 500; n = 800;
im = rand(m,n);

[k_x k_y] = meshgrid(linspace(-5,5,100));
k = exp(-(k_x .^ 2 + k_y .^ 2)/(8));

im = conv2(im,k,'valid');

figure;
imagesc(im)
colormap jet; axis off;


k_v = ones(5);
k_v(:,round(size(k_v)/2)) = 0;
k_v(:,1:round(size(k_v)/2)-1) = -1;

k_h = k_v';

edge_v = conv2(im,k_v,'valid');
edge_h = conv2(im,k_h,'valid');
edge_tot = edge_v + edge_h;
edge_prod = edge_v .* edge_h;

figure;
imagesc(edge_tot)
colormap bone; axis off;


edge_tot_h = fftshift(fft2(edge_tot));

[k_gauss_x k_gauss_y] = meshgrid(linspace(-5,5,35));

sd = [2 4 8]; #play with this
triptych = [];
figure;
for i = 1:3
  tmp = sd(i);
  k_gauss = exp(-(k_gauss_x .^ 2 + k_gauss_y .^ 2)/tmp);
  k_gauss = k_gauss/(sum(sum(k_gauss))/numel(k_gauss))/100;

  smoothed_frq_edge = conv2(edge_tot_h, k_gauss,'valid');
  triptych(:,:,i) = smoothed_frq_edge;

  subplot(1,3,i)
  imagesc(log(abs(fftshift(ifft2(smoothed_frq_edge)))));
  colormap hot; axis off;
end

%%
figure;
imagesc(log(abs(fftshift(ifft2(smoothed_edge)))));
colormap hot; axis off;


k_gauss_II = [1 1 1; 1 9 1; 1 1 1];
k_gauss_II = k_gauss_II/(sum(sum(k_gauss_II)));

smoothed_frq_edge_II = conv2(edge_tot_h, k_gauss_II,'valid');

figure;
imagesc(log(abs((ifft2(smoothed_frq_edge_II)))));
colormap bone; axis off;


smoothed_frq_edge_image = log(abs(fftshift(ifft2(smoothed_frq_edge))));
smoothed_frq_edge_II_image = log(abs((ifft2(smoothed_frq_edge_II))));
image_product = smoothed_frq_edge_image .* smoothed_frq_edge_II_image(1:size(smoothed_frq_edge_image,1),1:size(smoothed_frq_edge_image,2));

figure;
imagesc(image_product);
colormap jet; axis off;


##figure;
##imagesc(edge_prod)
##colormap bone; axis off;

##[U_tot S_tot V_tot] = svd(edge_tot,'econ');
##
##figure;
##for i = 1:9
##  subplot(3,3,i)
##  partial_tot = U_tot(:,i) * S_tot(i,i) * V_tot(:,i)';
##  imagesc(partial_tot)
##  colormap jet; axis off;
##endfor
