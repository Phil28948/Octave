close all; clear all;
#y = [1 6 8 2 10 5 9]';
#a = [1 1 1 1 1 1 1]';
y = rand(7,1);
a = [[1 1 1 1 1 1 1]' [1 2 3 4 5 6 7]'];
x = [];

x = (a'*a)\(a'*y);

hold on
plot([1:length(y)],y)
plot([1:length(y)],x'*a', 's')

##
close all; clear all;
N = 20; L = [1:N]';
y = L .^ 2;
a = [ones(N,1) L];
a1 = [ones(N,1) L .^ 2];
x = [];

x = (a'*a)\(a'*y);
x1 = (a1'*a1)\(a1'*y);

hold on
plot(L,y, 'b')
plot(L,a*x, 'g')
plot(L,x1'*a1', 'Color', 'r', 's')
legend('Location','northwest');

eta = sum((y - a*x) .^ 2);
eta1 = sum((y - a1*x1) .^ 2);

##
##close all; clear all;
##plot(eig(A)) #pattern hidden by spurious connections between elements
##plot(eig(A), 's') #pattern clear 