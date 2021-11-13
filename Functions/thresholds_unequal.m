#set likelihood of one element to p E (0 1] and make the others equal
function thresholds = thresholds_unequal(thresholds_old,element,p)
  temp_range = sum(thresholds_old);
  new_block = floor(temp_range*p);
  
  
endfunction
