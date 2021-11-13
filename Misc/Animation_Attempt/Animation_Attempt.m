clear all; close all;

t = linspace(0,1,100);

x_freq = 8;
y_freq = 2;
#fuck you z

x = sin(2*pi*x_freq*t);
y = cos(2*pi*y_freq*t);
z = sin(pi*t);

counter = 1;
for i = 1:length(t)
  clf
  hold on
  plot3(x(i),y(i),z(i),'ro')
  plot3(x(1:i),y(1:i),z(1:i),'--')
  axis([-1 1 -1 1 0 1])
  view([(20+(3.6*i)) 30])
  
  filename = sprintf('sines%03d.png',counter);
  saveas(gca, filename);
  pause(0.05);
  counter = counter + 1;
endfor
