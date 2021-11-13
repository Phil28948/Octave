close all;

##Basic FFT
sr = 1000;
t = 0:1/sr:10-(1/sr);
T = t(end);
noise = rand(1,length(t));
noise = noise - sum(noise)/length(noise);
n = length(t);
freq = linspace(0,sr/2,fix(length(t)/2+1));
range = 1;

signal = 0*cos(2*pi*(3*(T+t(2)))*t/T) + 1*cos(2*pi*(6*(T+t(2)))*t/T);

##subplot(2,1,1)
##title('Time Series')
##plot(t,signal)
##
##Fsignal = fft(signal,n)/n; #careful if zero padding
##Fsignal2 = [abs(Fsignal(1)) abs(Fsignal(2:end)*2)]; #Displaying only positive freqs, so doubling magnitude of all non-DC frequencies
##
##subplot(2,1,2)
##title('Frequency Domain')
##stem(freq(1:floor(length(freq) * range)),Fsignal2(1:floor(length(freq) * range)))

signal = (abs(signal) >= .75) - .5;

for ind = 1:1
##  modulator = abs(cos(2*pi*ind*(T+t(2))*t/T)) >= .5;
  modulator = cos(2*pi*ind*(T+t(2))*t/T);
  AMsignal = signal .* modulator;

  figure;
  subplot(4,1,1)
  plot(t(1:length(t)/5),signal(1:length(t)/5))
  
  subplot(4,1,2)
  plot(t(1:length(t)/5),modulator(1:length(t)/5))

  subplot(4,1,3)
  plot(t,AMsignal)

  FAMsignal = fft(AMsignal,n)/n;
  FAMsignal = [abs(FAMsignal(1)) abs(FAMsignal(2:end)*2)];

  subplot(4,1,4)
  stem(freq(1:floor(length(freq)*range)),FAMsignal(1:floor(length(freq)*range)))
end

