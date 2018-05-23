%Variables
h = 0.01;
x0 = [0.55*pi 0.45*pi 0 0]; %initial condition
sys = linearizedSSuu;

%Controllerparameters
Q = [100 0 0 0 0;
     0 1000 0 0 0;
     0 0 0 0 0;
     0 0 0 0 0;
     0 0 0 0 0]; 
R = 100;

%Controller
[A,B,C,D] = ssdata(sys);
A = [0 1 0 0 0;[0;0;0;0] A];
B = [0;B];
[K,S,e] = lqr(A,B,Q,R);

%unstable controller K2 = [-1 -48 -2.3 -4.3];
