%Parameters
Parameters(1) = 1.8; %motor gain
Parameters(2) = 0.25; %friction coefficient first link
Parameters(3) = 0.00001; %friction coefficient second link

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

%simulate
[th1,th2] = penSimFun(@(t)-um(floor(t/h)+1),[-0.5*pi,0,-0.5*pi,0],20,h,Parameters,Constants);

%%
%animation
figure(2)
hold on
for ii = 1:tend/(h*20)
    clf(2)
    axis([-0.2 0.2 -0.2 0.2])
    line([0 l1*cos(th1(ii*20)) l1*cos(th1(ii*20))+l2*cos(th2(ii*20))],[0 l1*sin(th1(ii*20)) l1*sin(th1(ii*20))+l2*sin(th2(ii*20))],'Color','blue');
    line([0 l1*cos(th1m(ii*20)+0.5*pi) l1*cos(th1m(ii*20)+0.5*pi)+l2*cos(th2m(ii*20)-0.5*pi)],[0 l1*sin(th1m(ii*20)+0.5*pi) l1*sin(th1m(ii*20)+0.5*pi)+l2*sin(th2m(ii*20)-0.5*pi)],'Color','red');
    pause(h*20);
end