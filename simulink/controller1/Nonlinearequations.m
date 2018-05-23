close all;
%simparameters
syms th1(t) th2(t) u
x0 = [0.51*pi,0,0.5*pi,0]; %initial state

%Parameters
K = 1.8; %motor gain
k1 = 0.35; %friction coefficient first link
k2 = 0.0002; %friction coefficient second link

%Constants
g = 9.81; %Gravity
l1 = 0.1; %length of first link in m
l2 = 0.1; %length of second link in m
m1 = 0.18; %mass of first link
m2 = 0.06; %mass of second link
c1 = 0.06; %center of mass of first link
c2 = 0.045; %center of mass of second link
I1 = 0.037; %inertia of first link
I2 = 0.00011; %inertia of second link

%Equations of motion
w1 = diff(th1);
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
ode2 = diff(th2, 2) == Fw12-G21*w1^2+Fw22-G22*w2^2+Fu2-gradV2;
odes = [ode1; ode2];

%Solve equations using solver
V = odeToVectorField(odes);
M = matlabFunction(V,'Vars',{'Y','u'},'File','M');