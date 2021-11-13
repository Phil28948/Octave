close all; clear all;

N = 500;
t = [1:N];
v = 0;
%v = randi(1000,1,N);
for j = [1 25 50 175 200];
  v = v + cos(2*pi*j*(t-1)/N);
end

  
figure;
subplot(2,1,1)
plot(t,v)

v_f = fft(v)/sqrt(N);
subplot(2,1,2)
plot(t,v_f)

for i = 1:N/2
  v2(i) = v(i*2);
end

figure;
subplot(2,1,1)
plot(1:N/2,v2) 

subplot(2,1,2)
plot(1:N/2,fft(v2)/sqrt(N/2));


v3 = conv(v,sin(pi/2*t)/(pi/2*t));
for i = 1:N/2
  v4(i) = v3(i*2);
end

figure;
subplot(2,1,1)
plot(1:N/2,v4) 

subplot(2,1,2)
plot(1:N/2,fft(v4)/sqrt(N/2));