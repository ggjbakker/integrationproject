%Parameters
Parameters(1) = 1.8; %motor gain
Parameters(2) = 0.35; %friction coefficient first link
Parameters(3) = 0.00002; %friction coefficient second link

tend = 3; %simulation end time

x0 = [-0.51*pi,0,0.5*pi,0];
fine = 5;
tstart = 0;
%Constants
Constants(1) = 9.81; %Gravity
Constants(2) = 0.1; %length of first link in m
Constants(3) = 0.1; %length of second link in m
Constants(4) = 0.18; %mass of first link
Constants(5) = 0.06; %mass of second link
Constants(6) = 0.06; %center of mass of first link
Constants(7) = 0.045; %center of mass of second link
Constants(8) = 0.037; %inertia of first link
Constants(9) = 0.00011; %inertia of second link

%Constants
g = 9.81; %Gravity
l1 = 0.1; %length of first link in m
l2 = 0.1; %length of second link in m
m1 = 0.18; %mass of first link
m2 = 0.06; %mass of second link
c1 = 0.06; %center of mass of first link
c2 = 0.045; %center of mass of second link
I1 = 0.037; %inertia of first link
I2 = 0.00011; %inertia of second link

%simulate
%res = penSimFun(@(t)-um(floor(t/h)+1),x0,20,h,Parameters,Constants);
[th1,th2] = penSimFun(@(t)-um1(floor(t/h)+1),x0,tend,h,Parameters,Constants);
%%
%animation
th1f = th1m1+0.5*pi;
th2f = th2m1 + th1f;
figure(2)
hold on
for ii = tstart/(h*fine)+1:tend/(h*fine)
    clf(2)
    axis([-0.2 0.2 -0.2 0.2])
    line([0 l1*cos(th1(ii*fine)) l1*cos(th1(ii*fine))+l2*cos(th2(ii*fine))],[0 l1*sin(th1(ii*fine)) l1*sin(th1(ii*fine))+l2*sin(th2(ii*fine))],'Color','blue');
    %line([0 l1*cos(th1f(ii*fine)) l1*cos(th1f(ii*fine))+l2*cos(th2f(ii*fine))],[0 l1*sin(th1f(ii*fine)) l1*sin(th1f(ii*fine))+l2*sin(th2f(ii*fine))],'Color','red');
    pause(h*fine);
end