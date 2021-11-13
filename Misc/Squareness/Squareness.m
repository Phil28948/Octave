l_bound = 0;
u_bound = 10^7;
iter = 5000;
data = zeros(iter,4);

for ii = 1:iter
  do
      tmp = round((u_bound - l_bound) .* rand(1) + l_bound);  #rounded to suppress warning
  until (~isprime(tmp))
 inputs(ii) = tmp;
end 
    
  
###verify distribution
##plot(sort(inputs))

for i = 1:length(inputs)

  tic
  [n,m] = nbym(inputs(i));

  data(i,3) = toc; #out of sequence for accuracy
  data(i,1) = i;  
  data(i,2) = inputs(i);
  data(i,4) = n - m;
  
end

close all;
subplot(3,1,1)
plot(data(:,2),data(:,4) ./ data(:,2),'o')  
title('Eccentricity')
xlabel('Input')
ylabel('(n-m)/n*m')
#line([0 max(inputs)], [mean(data(:,4) ./ data(:,2)) mean(data(:,4) ./ data(:,2))])
#regression via svd
a = [ones(iter,1) data(:,2)];
[u,s,v] = svd(a,'econ');
x1 = v * inv(s) * u' * (data(:,4) ./ data(:,2));
hold on
plot(data(:,2),x1'*a', 'k')

subplot(3,1,2)
plot(data(:,2),data(:,3),'ro')
title('Computation Time')
xlabel('Input')
ylabel('Seconds')
x2 = v * inv(s) * u' * data(:,3);
hold on
plot(data(:,2),x2'*a', 'k')

subplot(3,1,3)
plot(data(:,4) ./ data(:,2),data(:,3),'o')
title('Computation Time VS Eccentricity')
xlabel('Eccentricity')
ylabel('Seconds')

figure;
plot3(data(:,4) ./ data(:,2),data(:,2),data(:,3),'o')
rotate3d
xlabel('Eccentricity')
ylabel('Input')
zlabel('Seconds')

##
##close all;
##subplot(3,1,1)
##plot(data(1:3856,2),data(1:3856,4) ./ data(1:3856,2),'o')  
##title('Eccentricity')
##xlabel('Input')
##ylabel('(n-m)/n*m')
###line([0 max(inputs)], [mean(data(:,4) ./ data(:,2)) mean(data(:,4) ./ data(:,2))])
###regression via svd
##a = [ones(3856,1) data(1:3856,2)];
##[u,s,v] = svd(a,'econ');
##x1 = v * inv(s) * u' * (data(1:3856,4) ./ data(1:3856,2));
##hold on
##plot(data(1:3856,2),x1'*a', 'k')
##
##subplot(3,1,2)
##plot(data(1:3856,2),data(1:3856,3),'ro')
##title('Computation Time')
##xlabel('Input')
##ylabel('Seconds')
##x2 = v * inv(s) * u' * data(1:3856,3);
##hold on
##plot(data(1:3856,2),x2'*a', 'k')
##
##subplot(3,1,3)
##plot(data(1:3856,4) ./ data(1:3856,2),data(1:3856,3),'o')
##title('Computation Time VS Eccentricity')
##xlabel('Eccentricity')
##ylabel('Seconds')
##
##figure;
##plot3(data(1:3856,4) ./ data(1:3856,2),data(1:3856,2),data(1:3856,3),'o')
##rotate3d
##xlabel('Eccentricity')
##ylabel('Input')
##zlabel('Seconds')
