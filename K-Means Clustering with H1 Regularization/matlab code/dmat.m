function [D] = dmat(t)
D = eye(t);
D = D + diag(-1*ones(t-1,1), 1);
D = D(1:end-1,:);
end