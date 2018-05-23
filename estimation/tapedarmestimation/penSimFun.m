function [th1] = penSimFun(u,y0,tend,h,Parameters,Constants)
%penSimFun Simulates the pendulum and returns theta

syms th1(t)

%Parameters
k1 = Parameters(1); %friction coefficient second link
K = Parameters(2);

%Constants
g = Constants(1); %Gravity
l1 = Constants(2); %length of first link in m
l2 = Constants(3); %length of second link in m
c2 = Constants(4); %center of mass of second link
I1 = Constants(5); %inertia of first link
I2 = Constants(6); %inertia of second link
m1 = Constants(7); %mass of first link
m2 = Constants(8); %mass of second link
k2 = Constants(9); %friction coefficient second link
c1 = Constants(10); %center of mass of second link

%Equations of motion
w1 = diff(th1);
th2 = th1+pi;
w2 = diff(th2);
detg = (m2*c2^2+I2)*(m1*c1^2+m2*l1^2+I1)-(m2*l1*c2*cos(th1-th2))^2;
gradV1 = 1/detg*((m2*c2^2+I2)*(g*cos(th1)*(m1*c1+m2*l1))-m2*l1*c2*cos(th1-th2)*(g*c2*m2*cos(th2)));
gradV2 = 1/detg*((m1*c1^2+m2*l1^2+I1)*(g*c2*m2*cos(th2))-m2*l1*c2*cos(th1-th2)*(g*cos(th1)*(m1*c1+m2*l1)));
Fu1 = 1/detg*(m2*c2^2+I2)*K*u;
Fu2 = -1/detg*(m2*l1*c2*cos(th1-th2))*K*u;
Fw11 = -1/detg*(m2*c2^2+I2)*k1*w1;
Fw12 = 1/detg*(m2*l1*c2*cos(th1-th2))*k1*w1;
Fw21 = 1/detg*(m2*l1*c2*cos(th1-th2))*k2*w2;
Fw22 = -1/detg*(m1*c1^2+m2*l1^2+I1)*k2*w2;
G11 = 1/detg*(0.5*m2^2*l1^2*c2^2*sin(2*(th1-th2)));
G12 = 1/detg*((m2*c2^2+I2)*(m2*l1*c2*sin(th1-th2)));
G21 = -1/detg*((m1*c1^2+m2*l1^2+I1)*(m2*l1*c2*sin(th1-th2)));
G22 = -1/detg*(0.5*m2^2*l1^2*c2^2*sin(2*(th1-th2)));
ode1 = diff(th1, 2) == Fw11-G11*w1^2+Fw21-G12*w2^2+Fu1-gradV1;
odes = [ode1];

%Solve equations using solver
V = odeToVectorField(odes);
M = matlabFunction(V,'Vars',{'t','Y','u'});
tspan = [0 tend];
sol = ode45(M,tspan,y0);

%evaluate the solution
tVal = linspace(0,tend,tend*1/h);
yVal = deval(sol,tVal);
th1 = yVal(1,:);
end