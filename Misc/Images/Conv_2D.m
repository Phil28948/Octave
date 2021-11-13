clear all; close all;

n = 50;
iter = 6;
partials = zeros(n,n,iter);

[XX YY] = meshgrid(linspace(-5,5,n/6));
k = exp(-(XX .^ 2 + YY .^ 2)/(n/4));

figure;
imagesc(k);
colorbar;

noise = rand(n);

figure;
imagesc(noise);
colorbar;

smoothed = conv2(noise, k, 'same');

figure;
imagesc(smoothed);
colorbar;

[U, S, V] = svd(smoothed);

figure;
for i = 1:iter

  partials(:,:,i) = U(:,i) * S(i,i) * V(:,i)';
  
  subplot(2,3,i)
  imagesc(squeeze(partials(:,:,i)))
  axis off, axis square, title(['Component no.' num2str(i)])
 
end

figure;
imagesc(squeeze(sum(partials,3)))
axis off, axis square, title('Sum of Components 1-6')