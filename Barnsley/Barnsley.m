figure;

##AI = [0  0 ; 0 0.16];
##AII = [ 0.85  0.04 ; -0.04 0.85 ] ;
##AIII = [ 0.2  -0.26 ; 0.23 0.22 ] ;
##AIV = [-0.15  0.28 ; 0.26 0.24 ];
##
##
##BI = [ 0 ; 0];
##BII = [ 0 ; 1.6];
##BIII = [ 0 ; 1.6];
##BIV = [0 ; 0.44];

#intermediate save
##AI = [0  0 ; 0 0.16];
##AII = [ 0.88  0.05 ; -0.04 0.85 ] ;
##AIII = [ 0.2  -0.26 ; 0.2 0.22 ] ;
##AIV = [-0.15  0.25 ; 0.2 0.24 ];

#intermediate save II
##AI = [0  0 ; 0 0.16];
##AII = [ 0.8  0.05 ; -0.19 0.85 ] ;
##AIII = [ 0.1  -0.16 ; 0.2 0.12 ] ;
##AIV = [-0.09  0.27 ; 0.22 0.24 ];

AI = [0  0 ; 0 0.16];
AII = [ 0.85  0.05 ; -0.25 0.87 ] ;
AIII = [ 0.1  -0.16 ; 0.2 0.12 ] ;
AIV = [-0.09  0.3 ; 0.22 0.24 ];

BI = [ 0 ; 0];
BII = [ 0 ; 1.6];
BIII = [ 0 ; 1.6];
BIV = [0 ; 0.44];

a = 5.5;
N = 100000;

H = zeros(N,2);

x = 0;
y = 0;
T = [x;y];


for i=2 : N

    p = rand;

    if p < 0.01
        %disp('Scheme 1')
        S1 = AI*T + BI;
        x = S1(1);
        y = S1(2);
    elseif p < 0.85
        %disp('Scheme 2')
        S2 = AII*T + BII;
        x = S2(1);
        y = S2(2);
    elseif p < 0.93
        %disp('Scheme 3')
        S3 = AIII*T + BII;
        x = S3(1);
        y = S3(2);
    else
        %disp('Scheme 4')
        S4 = AIV*T + BIV;
        x = S4(1);
        y = S4(2);
    end
    %%Update T
    T = [x;y];
    H(i,1) = x;
    H(i,2) = y;
end

X = H(:,1);
Y = H(:,2);

X1 = -X + a;
Y1 = Y;

X = [X; X1];
Y = [Y; Y];

plot(X,Y,'.', 'Color', [79, 121, 66]/256, 'markersize', 0.1)