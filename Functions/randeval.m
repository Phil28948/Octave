#given a sample from a random number generator and a set of thresholds, 
#randeval.m returns the number of the note/noteset corresponding to
#the sample provided
function counter = randeval(sample,thresholds)
  
  
  counter = 0;

  for i = 1:length(thresholds)
    
    counter = counter + 1;
    if sample <= thresholds(counter+1)
      return
    end
  end
   
end
 
  
    
  