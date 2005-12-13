% SDP relaxations of the two-way partitioning problem
% Exercise 5.33, Boyd & Vandenberghe "Convex Optimization"
% Jo�lle Skaf - 09/07/05
% (a figure is generated)
%
% Compares the optimal values of:
% 1) the Lagrange dual of the two-way partitioning problem 
%               maximize    -sum(nu)
%                   s.t.    W + diag(nu) >= 0 
% 2) the SDP relaxation of the two-way partitioning problem
%               minimize    trace(WX)
%                   s.t.    X >= 0  
%                           X_ii = 1

% Input data
randn('state',0);
n = 10;
W = randn(n); W = 0.5*(W + W');

% Lagrange dual
fprintf(1,'Solving the dual of the two-way partitioning problem...');

cvx_begin
    variable nu(n)
    maximize ( -sum(nu) )
    W + diag(nu) == semidefinite(n) 
cvx_end

fprintf(1,'Done! \n');
opt1 = cvx_optval;

% SDP relaxation
fprintf(1,'Solving the SDP relaxation of the two-way partitioning problem...');

cvx_begin
    variable X(n,n) symmetric
    minimize ( trace(W*X) )
    X == semidefinite(n)
    diag(X) == 1
cvx_end

fprintf(1,'Done! \n');
opt2 = cvx_optval;

% Displaying results
disp('------------------------------------------------------------------------');
disp('The optimal value of the Lagrange dual and the SDP relaxation fo the    ');
disp('two-way partitioning problem are, respectively, ');
disp([opt1 opt2])
disp('They are equal as expected!');
