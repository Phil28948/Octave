##clear all; close all;
##
##n = 5;
##g = [5 2 1 3 2]';
##v = [1 0 0 0 0]';
##bc = eye(n);
##u = bc(:,1) - g;
##
##P = bc - (u*v');
##Pinv = bc + u*v'/(1-u'*v);
##
##g1 = Pinv*g;
##
##

clear all; close all;

n = 5;
thrsh = 10^-6;
g = [0 0 1 3 2]';
v = zeros(n,1);

  
    
bc = eye(n);
u = bc(:,ind) - g;

P = bc - (u*v');
Pinv = bc + u*v'/(1-u'*v);

g1 = Pinv*g;

gn = [2 0 .2 0 0]';

function [ind, v] = indx(g,v)
  for i = 1:n
  if g(i) > thrsh
    v(i) = 1;
    ind = i;
    break
  end
end
endfunction
