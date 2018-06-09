function [A] = laplace(n)
A = 2 * eye(n);
A = A + diag(-1*ones(n-1,1), 1) + diag(-1*ones(n-1,1), -1);
A(1,1) = 1;
A(end,end) = 1;
end