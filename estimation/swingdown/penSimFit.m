h = 0.01;
%datatofit
z0 = [0.0001 0.045];
x0 = [0,0,-0.5*pi,0];

%Constants
Constants(1) = 9.81; %Gravity
Constants(2) = 0.1; %length of first link in m
Constants(3) = 0.1; %length of second link in m
Constants(7) = 0.18;  %mass of first link
Constants(8) = 0.06; %mass of second link
Constants(4) = 0.06; %center of mass of first link
Constants(5) = 0.037; %inertia of first link
Constants(6) = 0.00011; %inertia of second link

%function
fun = @(par)penSimFun(x0,length(th2reg)*h,h,par,Constants)'-th2reg;

options = optimoptions('lsqnonlin','Display','iter-detailed','StepTolerance',0.001);
par = lsqnonlin(fun,z0,[],[],options);
%par = [0.0002 0.0628]