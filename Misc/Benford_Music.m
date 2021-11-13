close all; clear all;

range = [36 36 36 36 48 48 48 48];
log = [];

for iter = 1:length(range)
  steps = randi([-range(iter) range(iter)], 10000, 1);
  a = 440;

  rnotes = a * 2 .^ (steps/12);

  digs(1:9) = 0;

  for i = 1:length(rnotes)
    
    string = sprintf('%0.2e', abs(rnotes(i)));
    firstDigit = str2double(string(1));
    
    switch (firstDigit)
      
      case {1}
        digs(1) = digs(1) + 1;
      case {2}
        digs(2) = digs(2) + 1;
      case {3}
        digs(3) = digs(3) + 1;
      case {4}
        digs(4) = digs(4) + 1;
      case {5}
        digs(5) = digs(5) + 1;
      case {6}
        digs(6) = digs(6) + 1;
      case {7}
        digs(7) = digs(7) + 1;
      case {8}
        digs(8) = digs(8) + 1;
      case {9}
        digs(9) = digs(9) + 1;

    end

  end

  subplot(4,2,iter)
  bar(digs/length(rnotes))
  
  log = [log; digs];
 
 end