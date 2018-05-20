clear all;
close all;

%load data
load("svm_data.mat");

xd = data(:,1);
yd = data(:,2);
zd = data(:,3);
class = data(:,4);

%1a 3D case
%visual data
pointsize = 30;
figure;
scatter3(xd,yd,zd,pointsize,class,'filled');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
hold on;

%Quadratic Programming
d = size(data,1);
n = size(data,2)-1; %not counting the class column

X = data(:,1:n);
Y = data(:,n+1);

H = eye(n+1);
H(n+1,n+1)=0; %To make sure we do not minimize constant b
f = zeros(n+1,1);

Z = [X ones(d,1)];
A = -diag(Y) * Z;
c = -1*ones(d,1);

[w, fval] = quadprog(H,f,A,c);

%Plotting Hyperplane
[X1, Y1] = meshgrid(-8:0.5:6,-10:10);
w1=w(1,1);
w2=w(2,1);
w3=w(3,1);
b=w(4,1);
C1 = zeros(21,29);
size(C1);
Z1=-(w1*X1+w2*Y1-b)/w3; %Optimal hyperplane
surf(X1,Y1,Z1,C1);
view(40,10);
hold off;

%1b 2D case
%visual data
figure;
scatter(xd, yd, pointsize, class, 'filled');
hold on;

%Quadratic Programming
d = size(data,1);
n = size(data,2)-2; %also not counting the 3rd dimension

X = data(:,1:n);
Y = data(:,n+2);

H = [eye(n), zeros(n,d+1); zeros(d+1,n), zeros(d+1,d+1)];
f = [zeros(n+1,1);100*ones(d,1)];
leq = [-inf;-inf;-inf;zeros(d,1)];

c = -ones(d,1);
Z = [X -c -eye(d,d)];
A = -diag(Y) * Z;


options = optimoptions('quadprog','Algorithm','interior-point-convex','Display','off');
w = quadprog(H,f,A,c,[],[],leq,[],[],options);

%Plotting
X2 = [-8:0.5:6];
Y2 = (-X2*w(1) - w(3))/w(2);
xlim([-8 6])
ylim([-10 10])
plot(X2,Y2,'k-');
Ylow = (1-X2*w(1) - w(3))/w(2);
plot(X2,Ylow,'m:');
Yup = (-1-X2*w(1) - w(3))/w(2);
plot(X2,Yup,'m:');
hold off;