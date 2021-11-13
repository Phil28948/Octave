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


##N = 8;
##n = log2(N);
##n1 = [0:N-1];
##n_b = flip(de2bi(n1),2);
##
##n_r = zeros(size(n_b));
##n_r(:,end) = n_b(:,1);
##for i = 1:n-1
##  
##  n_r(:,end-i) = xor(n_b(:,i),n_b(:,i+1));
##  
##end
##
##
##for p = 1:N
##  for q = 1:N
##    
##    coef = n_b(q,:) * n_r(p,:)';
##    h_w(p,q) = (-1)^coef;
##    
##  endfor
##endfor
##
##figure;
##hold on
##for g = 1:N
##  offset = ones(1,8)*(g-1)*2;
##  temp = h_w(g,:) + offset;
##  stairs([1:N],temp);
##  
##end
##
##  
##  
  
  

A = eye(5);
A = A(:,[5 1 2 3 4])  
  
  
  
  
  
  
  
  
  
  
  