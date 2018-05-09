%Digital control assignment 02-17
%Matlab file 6
%vak: SC42095
%
%question 6 observer state feedback
%
%Gemaakt door Geert Bakker
%studentnumber: 429334
%30-Nov-17

%Variables
h = 0.001;

dampingratio = 0.85;
naturalf = 6;

copoles = [-30 -31 -32 -33];

ptheta = acos(-dampingratio);
cpoles = [naturalf*exp(ptheta*1j) naturalf*exp(-ptheta*1j) -20 -21 -22];% continous time poles
dpoles = exp(cpoles*h);

dopoles = exp(copoles*h);
sys = linearizedSS;
[A,B,C,D] = ssdata(sys);
sysd = c2d(sys,h,'zoh');
[Phi,Gam,Cd,Dd] = ssdata(sysd);

Phiaug = [Phi [0;0;0;0];Cd 1];
Gamaug = [Gam;0];
Laug = place(Phiaug,Gamaug,dpoles);
L = Laug(1:4);
Li = Laug(5);
K = place(Phi',Cd',dopoles).';

