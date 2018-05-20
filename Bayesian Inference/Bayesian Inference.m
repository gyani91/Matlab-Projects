close all;
clear all;

Beta(0.5,0.5);
Beta(1,1);
Beta(10,10);
Beta(100,100);

function Beta(a,b)
X = [0 1 0 1 0 0 0 0 0 0];
H = length(X(X==1));
T= length(X)-H;
p = 0.01 : 0.01 : 0.99;
y1 = betapdf(p, a, b);
y2 = betapdf(p, a+H, b+T);
y3 = binopdf(H,length(X),p);
y1 = y1/sum(y1);
y2 = y2/sum(y2);
y3 = y3/sum(y3);
figure;
plot(p,y1/sum(y1),'LineStyle','-.','Color','r','LineWidth',2);
hold on
plot(p,y2/sum(y2),'LineStyle',':','Color','b','LineWidth',2);
plot(p,y3/sum(y3),'LineStyle','--','Color','g','LineWidth',2);
legend({'Prior', 'Posterior','Likelihood'},'Location','NorthEast');
hold off
end