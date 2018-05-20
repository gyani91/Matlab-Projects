clear all;
close all;

x0=[-2,-1];
A=[];
b=[];
Aeq=[];
beq=[];
lb=[];
ub=[];
options = optimoptions('fmincon','Algorithm','interior-point','Display','iter');
fun1=@(x)x(1)+x(2);
x1 = fmincon(fun1,x0,A,b,Aeq,beq,lb,ub,@nonlcon1,options);

disp(['Optimal Solution for first constrained optimization problem: ', num2str(x1)])

x0=[-2,-1];
A=[];
b=[];
Aeq=[];
beq=[];
lb=[];
ub=[];
options = optimoptions('fmincon','Algorithm','interior-point','Display','iter');
fun2=@(x)2*(x(1)-5)^2+3*x(2)^2;
x2 = fmincon(fun2,x0,A,b,Aeq,beq,lb,ub,@nonlcon2,options);

disp(['Optimal Solution for second constrained optimization problem: ', num2str(x2)])

[X,Y] = meshgrid(-10:0.5:10,-10:20);
z1 = 2*((X)-5).^2 + 3*(Y).^2;
z2 = X+Y-10;
figure;
surf(X,Y,z1);
hold on
surf(X,Y,z2);
legend('Objective Function','Constraint');
plot(x1(1),x1(2),'DisplayName','Optimal Solution');
hold off

[X,Y] = meshgrid(-10:0.5:10,-10:20);
z1 = X+Y;
z2 = 4*X.^2+Y.^2-20;
figure;
surf(X,Y,z1);
hold on
surf(X,Y,z2);
legend('Objective Function','Constraint')
plot(x2(1),x2(2),'DisplayName','Optimal Solution')
hold off

function [const, ceq] = nonlcon1(x)
const = 4*x(1).^2+x(2).^2-20;
ceq= [];
end

function [const, ceq] = nonlcon2(x)
const = x(1)+x(2)-10;
ceq= [];
end