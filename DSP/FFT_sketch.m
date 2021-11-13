close all;

##Basic FFT
sr = 1000;
t = 0:1/sr:1-(1/sr);
T = t(end);
noise = rand(1,length(t));
noise = noise - sum(noise)/length(noise);
n = length(t);
freq = linspace(0,sr/2,fix(length(t)/2)+1);
range = 1/20;

#scale freq of functions by total time period = T+t(2)
signal = cos(2*pi*(3*(T+t(2)))*t/T) + 1.5*cos(2*pi*(10*(T+t(2)))*t/T) + 2;

figure;
plot(t,signal)

Fsignal = fft(signal,n)/n;
Fsignal2 = [abs(Fsignal(1)) abs(Fsignal(2:end)*2)]; #Displaying only positive freqs, so doubling magnitude of all non-DC frequencies
PSD = [Fsignal(1) Fsignal(2:end) .* conj(Fsignal(2:end))];

figure;
subplot(2,1,1)
stem(freq(1:floor(length(freq)*range)),Fsignal2(1:floor(length(freq)*range)))

subplot(2,1,2)
stem(freq(1:floor(length(freq)*range)),PSD(1:floor(length(freq)*range)))


figure;
Isignal = ifft(Fsignal,n)*n;
plot(t,Isignal)


%%Fourier matrix
v = randi(10,64,1);

N = 64;
T = 1:N;
for m = 1:N
  for n = 1:N
  
    f_mat(m,n) = exp(-2*pi*i*(n-1)/N*(m-1));
  
  end
end

p = cat(2, [28:64], [1:27]);
perm = eye(64);
perm = perm(:,p);

close all; 
figure;
hold
plot(T,v)
plot(T,perm*v)


















