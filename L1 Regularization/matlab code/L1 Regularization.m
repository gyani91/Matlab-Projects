close all;
clear all;

load('data_3.mat');


d = size(X,2);
X = [ones(size(X, 1), 1) X];
theta = inv(X'*X) * X' * Y;

A = [eye(d), -eye(d);...
    -eye(d), -eye(d);...
    zeros(d), -eye(d);...
    zeros(1,d), ones(1,d)];

A = [zeros(3*d+1,1) A];

x0 = zeros(2*d+1,1);
fun = @(x)(Y - (X*x(1:d+1)))'*(Y-(X*x(1:d+1)));

for i = 1:20
    b = [zeros(1,(3*d)), C(i)]';
    theta_reg(:,i) = fmincon(fun,x0,A,b);
    error(i) = fun(theta_reg(:,i));
end

figure;
plot(C,error);

figure;
loglog(C,error);