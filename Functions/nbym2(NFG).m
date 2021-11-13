#dont think this works, fails on 186 (and a lot of others)

function [n, m, cycle_cnt] = nbym2(a)
  
  #debug
  cycle_cnt = 0;
    
    #save time on primes
    if isprime(a)
      n = a;
      m = 1;
      return
    end
  
  init = sqrt(a);
  
  if mod(init,1) == 0 #trivial case if a is square
    n = init;
    m = n;
    
  else
    n1 = ceil(init);
    m1 = floor(init);
    
    n2 = n1;
    m2 = m1;
    
    while (m1 > 0)
      #debug
      cycle_cnt = cycle_cnt + 1;
      
      #branch one, decrement first
      m1 = m1 - 1;
      if n1 * m1 == a
        n = n1;
        m = m1;
        return
      else
        n1 = n1 + 1;
        if n1 * m1 == a
          n = n1;
          m = m1;
          return
        end
      end
        
      #branch two, increment first
      n2 = n2 + 1;
      if n2 * m2 == a
        n = n2;
        m = m2;
        return
      else
        m2 = m2 - 1;
        if n2 * m2 == a;
          n = n2;
          m = m2;
          return
        end
      end
    end
    
  end

end