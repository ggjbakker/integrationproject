h = 0.01;
%datatofit
z0 = [0.38 1.8];
x0 = [-0.5*pi,0];

%Constants
Constants(1) = 9.81; %Gravity
Constants(2) = 0.1; %length of first link in m
Constants(3) = 0.1; %length of second link in m
Constants(7) = 0.18; %mass of first link
Constants(8) = 0.06; %mass of second link
Constants(4) = 0.0628; %center of mass of second link
Constants(5) = 0.037; %inertia of first link
Constants(6) = 0.00011; %inertia of second link
Constants(9) = 0.0002;
Constants(10) = 0.06;

%function
fun = @(par)penSimFun(-0.7,x0,0.5,h,par,Constants)'-set3th1reg(1:0.5/h);

options = optimoptions('lsqnonlin','Display','iter-detailed','StepTolerance',0.001);
par = lsqnonlin(fun,z0,[],[],options);
%par = [0.3114 0.4654 2.7624]