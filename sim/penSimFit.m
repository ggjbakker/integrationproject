tend = 2; %simulation end time
h = 0.001;
%datatofit
ufit = um1;
z0 = [1.8 0.35 0.001];
x0 = [-0.5*pi,0,0.5*pi,0];
th1f = th1m1+0.5*pi;
th2f = th2m1 + th1f;
%th1f = th1f(1301:4300);
%th2f = th2f(1301:4300);
th1f = th1f(1:2000);
th2f = th2f(1:2000);

%Constants
Constants(1) = 9.81; %Gravity
Constants(2) = 0.1; %length of first link in m
Constants(3) = 0.1; %length of second link in m
Constants(4) = 0.18;
Constants(5) = 0.06; %mass of second link
Constants(6) = 0.06; %center of mass of first link
Constants(7) = 0.045; %center of mass of second link
Constants(8) = 0.037; %inertia of first link
Constants(9) = 0.00011; %inertia of second link

%function
fun = @(par)penSimFun(@(t)-ufit(floor(t/h)+1),x0,tend,h,par,Constants)-[th2f]';

options = optimoptions('lsqnonlin','Display','iter-detailed','StepTolerance',0.001);
par = lsqnonlin(fun,z0,[],[],options);