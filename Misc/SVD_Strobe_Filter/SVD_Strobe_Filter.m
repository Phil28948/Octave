clear all; close all;
pkg load image;

#demean input? 

#load in image
input_image = imread('C:\Users\Ryan Smith\Documents\Octave\Misc\SVD_Strobe_Filter\StrobeScanCropped.jpg');
input_image = imrotate(mean(input_image,3),-90);

###skip here I think. Need to do some reading though
###center mean about 0?
##mean_input = mean(input_image,2);
##input_image = input_image - mean_input;

#compute SVD
[U, S, V] = svd(input_image);

#setup
r = size(nonzeros(S),1); #rank of S
sub_r = 30;              #no. of partials to display
h_en_cuttoff = 2;        #no. of high energy partials to remove for de-strobing

#compute partials (weighted outer product of U and V^T)
for i = 1:r
  partials(:,:,i) = U(:,i) * S(i,i) * V(:,i)';
  
  #display first few highest energy partials
  if i <= sub_r
    subplot(6, 5, i)
    imagesc(partials(:,:,i))
    colormap bone;
    title(num2str(i)); axis off;
   endif
endfor

#display input and output
figure;
subplot(1, 2, 1)
imagesc(input_image)
colormap bone;
title('Input image'); axis off;

subplot(1, 2, 2)
h_en_filtered = sum(partials(:,:,h_en_cuttoff+1:r),3);
imagesc(h_en_filtered)
colormap bone;
title('Filtered sum of partials'); axis off;

##
###Testing h_en_cuttoff values
##
##figure;
##h_en_cuttoff = 2;
##imagesc(U(:,h_en_cuttoff:end) * S(h_en_cuttoff:end,h_en_cuttoff:end) * V(:,h_en_cuttoff:end)')
##colormap bone; axis off;

#plot singular values
figure;
plot(1:r,log10(diag(S)))
title('Singular Values')
xlabel('S_{\sli,\sli}')
ylabel('Log_{10} \sigma')

#comparison of filtered image with and without some low energy partials (potential de-noising)
#use above graph or Gavish & Donoho (2014) to estimate cutoff
l_en_cutoff = 350;

figure;
subplot(1, 2, 1)
imagesc(h_en_filtered)
colormap bone;
title('All low energy partials'); axis off;

subplot(1, 2, 2)
imagesc(sum(partials(:,:,h_en_cuttoff+1:l_en_cutoff),3))
colormap bone;
title('Low energy partials removed from \sigma_{350}'); axis off;



#fft fuckery
input_h = fftshift(fft2(input_image));
partials_h = fftshift(fft2(partials(:,:,:)));

figure;
imagesc(log(abs(input_h)))
colormap bone; axis off;

figure;
for ii = 1:4
  subplot(2, 2, ii)
  imagesc(log(abs(partials_h(:,:,ii))))
  colormap bone; axis off;
endfor

h_frq_peak = mean(partials_h(:,:,1));
v_frq_peak = mean(partials_h(:,:,1),2);
#order by magnitude, keep track of indeces. Knock out peak index
#fucked if stripes are slanted though. Kill both and hope for best?
[~, h_frq_inds] = sort(h_frq_peak);
[~, v_frq_inds] = sort(v_frq_peak);

frq_kill = [1:2];
naive_filter = input_h;
naive_filter(:,h_frq_inds(frq_kill)) = 0;
naive_filter(v_frq_inds(frq_kill),:) = 0;
figure;
imagesc(abs(ifft2(naive_filter)))
colormap bone; axis off; #turns out this is pretty shit. Not too shocking



###working out coefficient ordering for fft2, is same as fft
##
##subsig = sin(2*pi*8*[0:.01:1]);
##testsig = repmat(subsig,1)+5;
##figure;
##imagesc(testsig)
##figure;
##imagesc(abs(fftshift((fft2(testsig)))));





