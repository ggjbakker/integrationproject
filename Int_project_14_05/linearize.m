%% Linearize the model 
% Symbolically linearize the plant 

clear all; close all; clc; 

syms t l1 g m1 m2 k1 k2 c1 c2 J1 J2 tau th1 th2 dth1 dth2 
% Set equ's
g11 = m1*c1^2+m2*l1^2+J1;
g21 = m2*l1*c2*cos(th1-th2);
g12 = m2*l1*c2*cos(th1-th2);
g22 = m2*c2^2+J2;
detG = g11*g22-g21*g12; 

V1 = g*cos(th1)*(m1*c1+m2*l1);
V2 = g*c2*m2*cos(th2);
gradV1 = (1/detG)*(g22*V1-g12*V2);
gradV2 = (1/detG)*(g11*V2-g21*V1);
Fu1 = (1/detG)*g22*tau;
Fu2 = -(1/detG)*g21*tau; 
Fth11 = -(1/detG)*g22*k1*dth1;
Fth12 = (1/detG)*g21*k1*dth1; 
Fth21 = (1/detG)*g21*k2*dth2;
Fth22 = -(1/detG)*g11*k2*dth2; 
Gam111 = (1/detG)*(0.5*m2^2*l1^2*c2^2*sin(2*(th1-th2)));
Gam122 = -(1/detG)*g22*(m2*l1*c2*sin(th1-th2)); 
Gam211 = (1/detG)*g11*(m2*l1*c2*sin(th1-th2));
Gam222 = -(1/detG)*(0.5*m2^2*l1^2*c2^2*sin(2*(th1-th2)));


x1 = dth1;
x2 = dth2;
x3 = Fth11+Fth21-Gam111*dth1^2-Gam122*dth2^2+Fu1-gradV1;
x4 = Fth12+Fth22-Gam211*dth1^2-Gam222*dth2^2+Fu2-gradV2;  

A = [diff(x1,th1) diff(x1,th2) diff(x1,dth1) diff(x1,dth2);
    diff(x2,th1) diff(x2,th2) diff(x2,dth1) diff(x2,dth2);
    diff(x3,th1) diff(x3,th2) diff(x3,dth1) diff(x3,dth2);
    diff(x4,th1) diff(x4,th2) diff(x4,dth1) diff(x4,dth2)];

B = [diff(x1,tau);diff(x2,tau);diff(x3,tau);diff(x4,tau)];

%%
x = [th1;th2;dth1;dth2];
% upup position 
xs = [pi/2;pi/2;0;0];
A = simplify(subs(A,x,xs));
B = simplify(subs(B,x,xs));



