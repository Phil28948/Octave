close all, clear all;

#parameters, intensity 0 = identity kernel (gain always = 1)
[XX YY] = meshgrid(linspace(-5,5,100));
k1_intensity = 1; 

##k1 (gaussian)
k1 = exp(-(XX .^ 2 + YY .^ 2)/k1_intensity);
#k1 = k1/(sum(sum(k1))/numel(k1))/100;

surf(XX, YY, k1)
rotate3d