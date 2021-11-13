close all; clear all;

r_range = 67;
n = 6;
outputs = zeros(n,1);

thresholds = thresholds_equal(r_range,n);

smpls = randi(r_range,10^3,1);


c = randeval(35,thresholds)