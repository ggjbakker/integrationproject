%Variables
h = 0.01;
x0 = [0.51*pi 0.49*pi 0 0]; %initial condition
sys = linearizedSSuu;

%Controllerparameters
Q = [200 0 0 0 0;
     0 100 0 0 0;
     0 0 0 0 0;
     0 0 0 0 0;
     0 0 0 0 0]; 
R = 50;
opoles = [-50 -50.1 -50.2 -50.3];

%Controller
[A,B,C,D] = ssdata(sys);
Ac = [0 1 0 0 0;[0;0;0;0] A];
Bc = [0;B];
[K,S,e] = lqr(Ac,Bc,Q,R);
L = place(A',C',opoles).';


