%(a) Set seed to 0 using command rng

rng(0);
seed = rng;

%(b) Create a Gaussian random sample X of 1000 observations with mean μ = 2 and standard deviation σ = 1.5 using command randn.

sigma = 1.5;
mu = 2;
X = sigma.*randn(1000,1) + mu;
stats = [mean(X) std(X) var(X)];

%(c) Visualize X using command plot

figure; plot(X);
figure; plot(X, 'b+');

%(d) Show the normalized histogram of X using command hist and bar

figure; bar(hist(X) ./ sum(hist(X)));

%(e) Fit the normal distribution to X and obtain estimated μˆ and σˆ using command normfit.

[muhat,sigmahat] = normfit(X);

%(f) Compute corresponding pdf values evaluated at X using μˆ and σˆ with command normpdf.

Y = normpdf(X,muhat,sigmahat);

%(g) Plot obtained pdf values over normalized histogram graph using command scatter.

figure; scatter(X, Y);