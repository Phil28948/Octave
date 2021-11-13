  a = 568;
  

  #preliminary checks
  if a < 0 || mod(a,1) != 0 #deal with negatives
    a = abs(round(a));
   warning('Input must be a real nonnegative integer. Results computed for %d',a) 
  end
    
  ind = 0;
  factors = [];

  #main body, compute factors of a
  for i = 2:a-1 
    if mod(a,i) == 0;
      ind = ind + 1;
      factors(ind) = i;
        
        if length(factors) > 1                  #optimal result always (?) middle two factors
            n = factors(ind);                   #(factors at least adjacent if not at center)
            m = factors(ind-1);
            
          
        end
      
    end
  end