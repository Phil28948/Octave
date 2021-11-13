close all;

#rand parameters
u_lim = 5;
l_lim = -5;

#setup data
t = 1:10;
y = (u_lim - l_lim) .* rand(size(t)) + l_lim; 

subplot(2,1,1)
stem(t,y)

timesteps = [];
for i = 1:length(t)-1
  timesteps(i) = (t(i+1) - t(i));
end

diffs = [];
for i = 1:length(y)-1
  diffs(i) = (y(i+1) - y(i)) / timesteps(i);
end

subplot(2,1,2)
stem(t(2:end),diffs)
xlim([min(t) max(t)])

