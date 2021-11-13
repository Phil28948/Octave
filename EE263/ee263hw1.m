close all;

G = [1 .2 .1; .1 2 .1; .3 .1 3];
Gintf = G - (G .* eye(size(G)));
g = 3;    #g and a set optimal SNIR at 6.3
a = 1.2;
s = .01;

init_iterations = 4;
t_iterations = 25;
t = 0:t_iterations;

for run = 1:init_iterations
  
  inits = cat(1, [1 1 1], 10*rand(init_iterations,3));
  
  p = inits(run,:);
  p_prev = [];
  S_log = [];

  for i = 0:t_iterations-1
    
    p_prev = p'(end-2:end);
    p_prev = reshape(p_prev, length(p_prev), 1);  
    
    sig = sum(G .* eye(3),2) .* p_prev;
    intf = sum(s + Gintf * p_prev,2);
    S = sig ./ intf;
    
    temp = p_prev*a*g ./ S;

    p = cat(1, p, temp');
    
    S_log = cat(1, S_log, S');
    
  endfor

  subplot (init_iterations,2,run*2-1)
    #figure;
    
    final_power = (fix((10000*p'(end-2:end))))/10000;
    main_title = ["Transmit power"; "Initialized at: " num2str(p'(1:3)); "Final value: " num2str(final_power)];
    #sub_title = ["Final power: " num2str(final_power)];
    
    title(main_title)
    #annotation('textbox', [.2 .3 .01 .01], 'string', sub_title)
    hold
    for j = 1:size(p,2)
     plot(t,p(:,j))
    endfor
    hold off

  subplot(init_iterations,2,run*2)
    #figure;
    
    main_title = ["Signal to Noise & Interference Ratio (ideal = 3.6)"; "Total square error < .001"];
    sub_title = ["Final SNIR: " num2str(S_log'(end-2:end))];
    
    title(main_title)
    #Aannotation('textbox', [.2 .3 .01 .01], 'string', sub_title)

    #subtitle(sub_title)
    
    hold
    for j = 1:size(S_log,2)
      plot(t(1:end-1),S_log(:,j))
      ##yticks = [0:.2:10];
      ##yticklabels = {[0:.2:10]};
    endfor
    line([0 t_iterations], [3.6 3.6], 'LineStyle', '--')
    
    SNIR_error = 321;
    SNIR_index = 1;
    while(SNIR_error > .001 && SNIR_index < size(S_log,1))
      SNIR_error = sum((S_log(SNIR_index,:)-3.6) .^ 2);
      SNIR_index = SNIR_index+1;
    endwhile
    line([SNIR_index SNIR_index], [0 max(max(S_log))], 'LineStyle', '--', 'Color', [1 0 0]) 
    
    hold off
  
  endfor