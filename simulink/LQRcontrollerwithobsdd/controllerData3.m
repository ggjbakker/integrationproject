%Variables
h = 0.01;
x0 = [-0.2*pi -0.3*pi 0 0]; %initial condition
sys = linearizedSSdd;

%Controllerparameters
Q = [0 0 0 0 0;
     0 10 0 0 0;
     0 0 0.1 0 0;
     0 0 0 0.1 0;
     0 0 0 0 10]; 
R = 0.005;
opoles = [-40 -40.1 -15.2 -15.3];

%Controller
[A,B,C,D] = ssdata(sys);
Ac = [0 1 0 0 0;[0;0;0;0] A];
Bc = [0;B];
[K,S,e] = lqr(Ac,Bc,Q,R);
Ki = -5;
L = place(A',C',opoles).';


