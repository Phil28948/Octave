close all; clear all;

a = 6896585; #range of random pseudorandom number generator
n = 7;  #number of notes/sets

p_init = a/n;
p = ones(n,1);
temp = zeros(1,1);

for i = 1:n
  p(i) = floor(p(i)*p_init*i); 
  temp = [temp p(i)];
  p_actual(i) = temp(i+1) - temp(i);
end

sum(p_actual) - a
