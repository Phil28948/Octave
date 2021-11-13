function [n, m] = nbym(a)
  % -- [n, m] = nbym(x)    
  %     Return the dimensions of a rectangle containing x points which is as close to 
  %     square as possible. 
  
  #preliminary checks
  if a < 0 || mod(a,1) != 0 #deal with negatives
    a = abs(round(a));
    warning('Input must be a real nonnegative integer. Results computed for %d',a)
  
  elseif isprime(a) #save time on primes
    n = a;
    m = 1;
    return
  
  elseif mod(sqrt(a),1) == 0  #other trivial case: number is a square
    n = sqrt(a);
    m = n;
    return
  
  else
  
    #setup main
    ind = 0;
    factors = [];

    #main body, compute factors of a
    for i = 2:a-1 
      if mod(a,i) == 0;
        ind = ind + 1;
        factors(ind) = i;
          
          if length(factors) > 1                  #optimal result always (?) middle two factors
            if factors(ind) * factors(ind-1) == a #can stop as soon as they are found
              n = factors(ind);                   #(factors at least adjacent if not at center)
              m = factors(ind-1);
              return
            end
          end
        
      end
    end
  end
end
################################################################################
######################################BACKUP####################################
##function [n, m] = nbym(a)
##  
##  ind = 0;
##  factors = [];
##
##  if mod(sqrt(a),1) == 0
##    n = sqrt(a); m = n;
##
##  else
##    for i = 2:a-1
##      if mod(a,i) == 0;
##        ind = ind + 1;
##        factors(ind) = i;
##        if factors(ind) * factors(ind-1) == a && length(factors) > 1
##          n = factors(ind);
##          m = factors(ind-1);
##          return
##      end
##    end
##
##    if isempty(factors)
##      n = a;
##      m = 1;
##
##    elseif numel(factors) == 2
##      n = factors(2);
##      m = factors(1);
##    
##    else
##      n = factors(numel(factors)/2+1);
##      m = factors(numel(factors)/2);
##      
##    end
##  end
##
##end