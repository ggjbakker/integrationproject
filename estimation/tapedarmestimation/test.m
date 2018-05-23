h = 0.01;
%datatofit
z0 = [0.38 0.06 1.8];
x0 = [-0.5*pi,0];

%Constants
Constants(1) = 9.81; %Gravity
Constants(2) = 0.1; %length of first link in m
Constants(3) = 0.1; %length of second link in m
Constants(4) = 0.0628; %center of mass of second link
Constants(5) = 0.037; %inertia of first link
Constants(6) = 0.00011; %inertia of second link
Constants(7) = 0.18; %mass of first link
Constants(8) = 0.06; %mass of second link
Constants(9) = 0.0002;


[th1Sim] = penSimFun(-0.7,x0,0.5,h,par,Constants);
th2Sim = th1Sim+pi;