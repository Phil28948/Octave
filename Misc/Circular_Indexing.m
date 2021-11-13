clear all; close all;

r = 10;
[X Y] = meshgrid(linspace(-r,r,r*2));

ed = sqrt(X .^ 2 + Y .^ 2);

#dist = [max(1,i-width):min(sizelim,i)];
dist = [3:7]

mask = ismember(round(ed), dist);
mask


