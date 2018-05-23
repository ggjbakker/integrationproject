l%Variables
h = 0.001;
x0 = [0.47*pi 0.47*pi 0 0]; %initial condition
sys = linearizedSSuu;

%Controllerparameters
Q = [10 0 0 0 0;
     0 200 0 0 0;
     0 0 0 0 0;
     0 0 0 0 0;
     0 0 0 0 0]; 
R = 0.005;
opoles = [-40 -40.1 -15.2 -15.3];

%Controller
[A,B,C,D] = ssdata(sys);
Ac = [0 1 0 0 0;[0;0;0;0] A];
Bc = [0;B];
[K,S,e] = lqr(Ac,Bc,Q,R);
Ki = -5;
L = place(A',C',opoles).';


