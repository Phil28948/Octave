function varargout = progbar(i,n,varargin)
  % -- meter = progbar(i,n)
  % -- meter = progbar(i,n,clk)
  % -- meter = progbar(i,n,clk,name)
  %Prints a progress bar for the current loop in 5% increments. If the third 
  %argument is true it will also display the wall clock time since the last update.
  %i is the current iteration of the loop, n the maximum value of the loop.
  %clk requests the time since the last progress bar increment.
  %If name is used multiple instances of progbar can run at the same time. The
  %string in name will be used to index a particular instance as well as its
  %associated variables
  i = 20;
  n = 20;
  
  bars = [];
  bars = char(bars)
      
  for grid = 1:20
    tmp = [char(repmat('# ',1,grid)) char(repmat('. ',1,20-grid))];
    bars = [bars; tmp(1:20)];
  end
   
  if !exist ('progmeter');
    progmeter = struct;
    varargout{1} = progmeter;
  end    
  
  if mod(i,1/n*20) == 0               
 
    b_ind = ceil(n*i/n^2);
    str_ind = ceil(20*b_ind);
    str = bars(str_ind,1:20);
    sprintf(str)
  end
  
    
    
    
endfunction
str