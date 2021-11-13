##t = [0:3];
##
##for j = 0:3 
##e1(j+1,:) = exp(i*2*pi*t*j/4);
##end
##
##A = [1 2 -1 3; 3 1 2 -1; -1 3 1 2; 2 -1 3 1];
##b = [1 2 -1 3]';
##y_ord = [0 3 2 1];
##
##f_R1 = abs(1/4 * fft(b) .* fft(b));
##finv_R1 = ifft(f_R1);
##c_R1 = 1/4 * corr(b,b);
##fc_R1 = fft(c_R1);
##
##
##R = 1/4 * A*b;
##f_R = fft(R);


%%INIT needed
pkg load communications;

clear all; close all;


%%Setup
N = 32;
n = log2(N);
n1 = [0:N-1];
n_b = flip(de2bi(n1),2);

n_r = zeros(size(n_b));
n_r(:,end) = n_b(:,1);
for i = 1:n-1
  
  n_r(:,end-i) = xor(n_b(:,i),n_b(:,i+1));
  
end


%%Walsh ordering
w_w = [];

for p = 1:N
  for q = 1:N
    
    coef = n_b(q,:) * n_r(p,:)';
    w_w(p,q) = (-1)^coef;
    
  endfor
endfor

%for plotting reasons extend matrix so plot ends with vertical not horizontal line
w_w(:,end+1) = w_w(:,end);

figure;
hold on
title ('Walsh Ordering')
for g = 1:N
  offset = ones(1,N+1)*(g-1)*3;
  temp = w_w(N+1-g,:) + offset;
  stairs([1:N+1],temp);
  
end

figure;
imagesc(w_w(:,[1:end-1]));
axis square;
colormap gray;
colorbar;
title ('Walsh Ordering')


%% Dyadic Ordering
for p1 = 1:N
  for q1 = 1:N
    
    coef = n_b(q1,:) * flip(n_b(p1,:))';
    w_d(p1,q1) = (-1)^coef;
    
  endfor
endfor  
  
w_d(:,end+1) = w_d(:,end);

figure;
hold on
title ('Dyadic Ordering')
for g1 = 1:N
  offset = ones(1,N+1)*(g1-1)*3;
  temp = w_d(N+1-g1,:) + offset;
  stairs([1:N+1],temp);
  
end

figure;
imagesc(w_d(:,[1:end-1]));
axis square;
colormap gray;
colorbar;
title ('Dyadic Ordering')


%%Natural Ordering
for p2 = 1:N
  for q2 = 1:N
    
    coef = n_b(q2,:) * n_b(p2,:)';
    w_n(p2,q2) = (-1)^coef;
    
  endfor
endfor  
  
w_n(:,end+1) = w_d(:,end);

figure;
hold on
title ('Natural Ordering')
for g2 = 1:N
  offset = ones(1,N+1)*(g2-1)*3;
  temp = w_n(N+1-g2,:) + offset;
  stairs([1:N+1],temp);
  
end

figure;
imagesc(w_n(:,[1:end-1]));
axis square;
colormap gray;
colorbar;
title ('Natural Ordering')


%%Aesthetics
figure;

qrt1 = w_w;
qrt2 = flip(w_d,2);
qrt3 = flip(w_n);
qrt4 = flip(qrt3,2);
tot = flip([qrt1,qrt2;qrt3,qrt4]);

imagesc(tot)
axis square;
axis off;
colormap gray;

tot2 = fft(tot);
figure;
im = imagesc(log(abs(tot2)));
colormap copper;
imrotate(im,90);





















  