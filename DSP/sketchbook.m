close all;

##Basic FFT
sr = 1000;
t = 0:1/sr:1-(1/sr);
T = t(end);
noise = rand(1,length(t));
noise = noise - sum(noise)/length(noise);
n = length(t);
freq = linspace(0,sr/2,sr/2+1);
range = 1/20;

signal = noise*10 + cos(2*pi*3*t/T) + 1.5*cos(2*pi*10*t/T) + 5;

figure;
plot(t,signal)

Fsignal = fft(signal,n)/n; #careful if zero padding
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

##Complex exponential image
for k = 1:length(t)
  cx = exp(-2*pi*-1i*k*t/T);
  F(:,k) = cx;
end

figure;
imagesc(real(F)); colormap(hsv);


##
close all;
[X,Y] = meshgrid([-10:.5:10],[-10:.5:10]);
##Z = exp(-(X .^ 2 + Y .^ 2));
Z = sin(2*pi*X .* Y)/(X .* Y);
surf(X,Y,Z)
rotate3d


##
close all;
[X,Y] = meshgrid([-10:.1:10]);
##Z = exp(-(X .^ 2 + Y .^ 2));
##Z = (sin(2*pi*X)/(pi*X))(sin(2*pi*Y)/(pi*Y));
r = sqrt(X .^ 2 + Y .^ 2);
Z = sin(pi*r) ./ (pi*r);
surf(X,Y,Z)
rotate3d



##
A = ones(7,10);
rank(A)

B = rand(3,10);
rank(B)

C = [A;B];
rank(C)

D = rand(10,4);
rank(D)

Dsym = D*D';
rank(Dsym)

R = rand(10,10);
R(:,2) = 0;
##R(:,2) = R(:,3);
##R = R + eye(10);
s = svd(R);

U = [[1 2 3]' [4 5 6]'];
rank(U)
U = [U [5 6 9]']
rank(U)

## Plot a plane defined by 2 vectors
close all; hold on;
v = [1 2 3];
w = [5 5 5];
plot3([0 v(1)], [0 v(2)], [0 v(3)], 'r')
n = cross(v,w);
d = -dot(n/norm(n),v); #if plane does not contain origin
[XX, YY] = meshgrid(-10:.5:10);
ZZ = (n(1)*XX + n(2)*YY + d) / -n(3);
surf(XX,YY,ZZ)
rotate3d
xlim([-10 10]); ylim([-10 10]); zlim([-10 10]);
plot3([0 n(1)], [0 n(2)], [0 n(3)], 'g')
hold off;

##
figure;
plot3(real(F), imag(F))

figure;
plot3(real(F), F)


plot3([11+1i 11+1i 11+1i], [10 11 12], 's')
rotate3d

clear all
close all

U = [[1 2 3]' [4 5 5]' [7 8 9]'];
Ui = inv(U)
[Q R] = qr(U)
Ui2 = inv(R) * Q'

x = [6 5 4]';
b = U*x;
#better to use R\Q'
#takes R * m = Q', adds R^-1 to left of both sides
#R^-1 * R * m = R^-1 * Q'
#R^-1 * Q' = m, m is (QR)^-1

##
A = [1 2 3; 6 5 4];
[V, L] = eig(A' * A);
[Us, Ss, Vs] = svd(A' * A);

A1 = [1 2 3; 6 5 4; 7 7 9];
