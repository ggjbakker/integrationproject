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
x0 = [-0.6*pi 0 -0.4*pi 0]; 

dampingratio = 0.85;
naturalf = 5;

copoles = [-15 -15.1 -15.2 -15.3];

ptheta = acos(-dampingratio);
cpoles = [naturalf*exp(ptheta*1j) naturalf*exp(-ptheta*1j) -7 -7.1];% continous time poles

sys = linearizedSS;
[A,B,C,D] = ssdata(sys);

s = tf('s');
Wp = [makeweight(0.316,0.2,100) 0;0 makeweight(0.8,10000,100)];
Wu = 0.4;
Wr = [];

P = augw(sys,Wp,Wu,Wr);
P = minreal(P);
[K,CL,GAM,INFO] = hinfsyn(P);
[Ak,Bk,Ck,Dk] = ssdata(K);

close all;
sigma(CL);
hold on;
sigma(Wp);

