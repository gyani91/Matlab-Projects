close all;
clear all;

%load data
data=load('Dax_data.mat');
q = data.Quotes';

q_mean = mean(q,2);

[n,m] = size(q);

X = q - repmat(q_mean,1,m);

figure;
plot(X);

%Reduce the data to 3-dim space
covar = 1 / (m-1) * X * X';

[V,D] = eig(covar);
eigenvals = diag(D);
reduced_V = V(:,1:3);
reduced_X = X'*reduced_V;

figure;
plot(reduced_X);

%Reconstruct the data to original size
reconstructed_X = reduced_V*reduced_X';

figure;
plot(reconstructed_X);

%Compute reconstruction error using the eigenvalues of the covariance matrix
re = (sum(eigenvals(4:n))/sum(eigenvals)) * 100;

disp(['Reconstruction Error: ', num2str(re)])
