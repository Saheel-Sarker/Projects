%Q4
disp("Example 2.13");
A = [1,2,2;4,4,2;4,6,4];
b = [3;6;10];
[L,U] = myLU(A); %gets Upper and lower matrix's
y = fwdSubst(L,b); %does Ly=b with foward Substitution
x = backSubst(U,y); %does Ux=y with backward Substitution
disp(x);

disp("Mine");
A = [2,1,1;2,-1,2;1,-2,1];
b = [7;6;0];
[L,U] = myLU(A); %gets Upper and lower matrix's
y = fwdSubst(L,b); %does Ly=b with foward Substitution
x = backSubst(U,y); %does Ux=y with backward Substitution
disp(x);

%Q3
function x = backSubst(U,y,k)
    [~,n] = size(U);
    if ~exist('k')  % If first call no k param given, but k=1
        k=n;
    end
    x = y(k)/U(k,k); %solves for x_k = whatever value it is
    if k > 1 % Recursion step
       l = U(:,k);
       x = [backSubst(U,y-x*l,k-1);x]; % [x1,x3,...,xn] y_column vector - x_k * U(whole column at column k)
    end
end

%Q3 Supplied Algorithm
function y = fwdSubst(L,b,k)
%Foward substitution
    [m,n]=size(L);
    if ~exist('k')  % If first call no k param given, but k=1
      k=1;
    end
    y=b(k)/L(k,k); 
    if k < n % Recursion step
      l = [zeros(k,1);L(k+1:m,k)]; 
      y = [y;fwdSubst(L,b-y*l,k+1)]; 
    end
end

%Q2
function [L,U] = myLU(A)
    n = size(A);
    L = eye(n); % Lower matrix starts off as an identity matrix
    for K = 1:n-1
        [m,l] = elimMat(A,K);
        A = m*A; % keep multiplying the upper by lower_i from the left
        L = L*l; % keep multiplying the lower by lower_i from the right
    end  
    U = A; 
end

%Q1
function [M,L] = elimMat(A,K)
    n = length(A);
    M = eye(n); % Elimination matrix starts off as an identity matrix
    all_mi = A(K+1:n,K)/A(K,K); % creates a vector by dividing the vector right below A[k,k] by A[k,k] 
    M(K+1:n,K) = -all_mi; % Subtract the vector right below M[k,k] by all_mi 
    L = 2*eye(n) - M; 
end