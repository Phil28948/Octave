clear all; close all;

n = 20;
[X,Y] = meshgrid([-n:.1:n-.1]);

e_d = sqrt(X .^ 2 + Y .^ 2);

radius = size(X,1)/2-1;
width = 2; 
counter = 0;

do
  clf  
  
  dist = [max(0,counter-width):min(n-1,counter)];  
  mask = ismember(round(e_d), dist);
  
  r = sqrt((X .* mask) .^ 2 + (Y .* mask) .^ 2);
  Z = sin(pi*r) ./ (pi*r);
  
  surf(X,Y,Z)
    
  axis([-n n -n n -.4 1])
  axis off;
  view([-37.5+(.7*counter) 30+20*sin(pi*(counter/((radius+width))))])
  colormap hsv; #colorcube is good, jet too
  
  filename = sprintf('2D_sync_wave_circle_hsv%03d.png',counter);
  
  saveas(gca, filename);
  pause(0.05);
  counter = counter + 1;
until (sum(any(mask)) == 0)


################################################################################
#####################################BACKUP#####################################
##
#################################SQUARE VERSION#################################
##
##clear all; close all;
##
##close all;
##[X,Y] = meshgrid([-10:.1:10-.1]);
##r = sqrt(X .^ 2 + Y .^ 2);
##Z = sin(pi*r) ./ (pi*r);
##
##width = 30; #10 thus far
##counter = 1;
##for i = 0:(size(X,1)/2)-1+width #adjust i scaling below if image isn't square
##  clf                           #divide width here if some of the wave should
##                                #remain when next animation section begins
##  if i < width
##    surf(X(100-i:100+i,100-i:100+i),Y(100-i:100+i,100-i:100+i),Z(100-i:100+i,100-i:100+i))
##  
##  elseif i < size(X,1)/2-1
##    tmp = Z(100-i:100+i,100-i:100+i);
##    tmp(width+1:end-width,width+1:end-width) = 0;
##    tmp(tmp == 0) = NaN;
##    
##    surf(X(100-i:100+i,100-i:100+i),Y(100-i:100+i,100-i:100+i),tmp)
##    
##  else
##    tmp = Z(:,:);
##    tmp(width+1:end-width,width+1:end-width) = 0;
##    tmp(tmp == 0) = NaN;
##    
##    width = width - 1;
##    
##    surf(X,Y,tmp)
##  endif
##    
##  axis([-10 10 -10 10 -.4 1])
##  axis off;
##  view([-37.5+(.7*i) 30+20*sin(pi*(i/((size(X,1)/2)-1+width)))])
##  colormap jet; #colorcube is good
##  
##  filename = sprintf('2D_sync_wave%03d.png',counter);
##  saveas(gca, filename);
##  pause(0.05);
##  counter = counter + 1;
##endfor




