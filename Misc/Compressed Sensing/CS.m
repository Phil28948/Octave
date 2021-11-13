%Sam Rothstein
%June 2020

%Read Input
Orig_Image = im2double(imread('cameraman100.jpg'));
imshow(Orig_Image)
F_Transform_M = dctmtx(size(Orig_Image,1));
Sparse_Image = F_Transform_M*Orig_Image*F_Transform_M';
imshow(Sparse_Image)

%Get Sparse Vector
S = size(Orig_Image);
N = 1000;
%reshape from matrix into vector, stacking columns under one another from
%left to right
k_w=1;  
Sparse_Vector = zeros(S(1,1)*S(1,2),1);
for j = 1:S(1,2)
    for i = 1:S(1,1)
        Sparse_Vector(k_w,1)=Sparse_Image(i,j);
        k_w = k_w+1;
    end
end

%now we create a random gaussian sampling matrix
num_samples = 3500;
Random_G_Sam_m = rand(num_samples,10*N);
for x = 1:num_samples
    for y =1:10*N
        if (Random_G_Sam_m(x,y)+ 0.001 >= 1)
            Random_G_Sam_m(x,y) = 1;
        else
            Random_G_Sam_m(x,y) = 0;
        end
    end
end


Random_Sample_Y = Random_G_Sam_m * Sparse_Vector; 

%There are infinite solutions to (random matrix * transform) * solution =
%sample
%we must pick the best one

theta = Random_G_Sam_m * dctmtx(size(10*N,1));

%To pick the correct solution, we will use the OMP algorithm

solution = (cs_omp(Random_Sample_Y,theta,10*N)');

%convert image vector back to pixel matrix
%S = size(solution);                     
Solution_Pixel_Matrix = zeros(100,100); %pixel matrix
k=1;
j=1;
for i = 1 : 10000
    if(k > 100)
        k=1;
        j=j+1;
    end
    Solution_Pixel_Matrix(k,j) = solution(i);
    k=k+1;
end

%Invert 2d discrete cosine transform
Solution_Pixel_Matrix = idct2(Solution_Pixel_Matrix); %use line 34 -> faster

imshow(Solution_Pixel_Matrix)

static_reconstruct_error = norm(Solution_Pixel_Matrix - Orig_Image) / norm(Orig_Image)








%Victor Barranca, Yolanda Hu, Alex Xuan
%************************************************************************%
function hat_x=cs_omp(y,T_Mat,m)
% y=T_Mat*x, T_Mat is n-by-m
% y - measurements
% T_Mat - combination of random matrix and sparse representation basis
% m - size of the original signal
% the sparsity is length(y)/4

n=length(y);
s=floor(n/4);     %/4 typ    : controls sparsity and number of iterations   
%s = 750
hat_x=zeros(1,m);                                 %  empty soln                    
Aug_t=[];                                         %  set of highly correlated columns: initialize to be empty
r_n=y;                                            %  residual: initialize with rhs 

for times=1:s;                                  %  number of iterations (more, more dense)
    product=abs(T_Mat'*r_n);                 %look at correlations bn residual and cols of samp mtx
    
    [val,pos]=max(product);                       %  find maximal correlation and its corresponding column
    Aug_t=[Aug_t,T_Mat(:,pos)];                   %  augment the set of highly correlated columns
    T_Mat(:,pos)=zeros(n,1);                      %  don't consider this highly corr column in future correlation computations
    aug_x=(Aug_t'*Aug_t)^(-1)*Aug_t'*y;           %  solve min augt x-y
    r_n=y-Aug_t*aug_x;                            %  compute new residual
    pos_array(times)=pos;                         %  
    
end
hat_x(pos_array)=aug_x;                           %  the value for the solution estimate in component posarray_i is aug_x_i, rest entries 0, not each subsequent residual is orthog to all prev considered highly corr columns