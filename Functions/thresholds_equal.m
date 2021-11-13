#given a random number generator with range r and n notes/note sets,
#thresholds returns sections of r such that all n elements are ~equally likely
function thresholds = thresholds_equal(r_range,n)
   
##  #testing vars 
##  n = 7;      #n = number of elements (notes or random not vars) in note set
##  range = 67; #range = range of random pseudorandom number generator or that 
##              #allocated to this note set

  p_init = r_range/n;
  p = ones(n,1);
  temp = zeros(1,1);
  r_temp = r_range;

  for i = 1:n   #voodoo o.0
    p(i) = floor(p(i)*p_init*i); 
    temp = [temp p(i)];
    p_actual = temp(i+1) - temp(i);  #size of each set on [1 a]
    r_temp = r_temp - p_actual;
    thresholds(n+1-i) = r_temp;
  end

thresholds = [thresholds(2:end) r_range];
end


#sequence of if rand < p_actual(1), < p_actual(1)+p_actual(2)...  
#if one value is manually adjusted the above can be called again. A becomes the 
#increase in the variables size, n becomes n-1 and p_actual becomes the vector
#of offsets which need to be applied to the other n-1 note probabilities 
#(opposite sign to the initial change)

