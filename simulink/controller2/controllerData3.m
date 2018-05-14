%Variables
h = 0.01;
x0 = [0.55*pi 0.45*pi 0 0]; %initial condition
sys = linearizedSSuu;

%Controllerparameters
Q = [10 0 0 0;
     0 0.01 0 0;
     0 0 0.001 0;
     0 0 0 1];
R = 10^12;
%Controller

[A,B,C,D] = ssdata(sys);
[K,S,e] = lqr(sys,Q,R);
Ki = [-2 -0.1 0 0];
K = K+Ki;