close all; clear all;
#sets all elements to have ~equal probability

a = 67; #range of random pseudorandom number generator
n = 7;  #number of elements (notes or random not vars) in note set

p_init = a/n;
p = ones(n,1);
temp = zeros(1,1);

for i = 1:n   #voodoo o.0
  p(i) = floor(p(i)*p_init*i); 
  temp = [temp p(i)];
  p_actual(i) = temp(i+1) - temp(i);  #size of each set on [1 a]
end

sum(p_actual) - a

#sequence of if rand < p_actual(1), < p_actual(1)+p_actual(2)...  
#if one value is manually adjusted the above can be called again. A becomes the 
#increase in the variables size, n becomes n-1 and p_actual becomes the vector
#of offsets which need to be applied to the other n-1 note probabilities 
#(opposite sign to the initial change)

