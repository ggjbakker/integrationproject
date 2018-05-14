%Variables
h = 0.001;
x0 = [-0.6*pi 0 -0.4*pi 0]; %initial condition
sys = linearizedSSuu;

%Controllerparameters
Q = [10 0 0 0;0 1 0 0;0 0 0 0;
%Controller
copoles = [-15 -15.1 -15.2 -15.3];

[A,B,C,D] = ssdata(sys);
[K,S,e] = lqr(sys,


