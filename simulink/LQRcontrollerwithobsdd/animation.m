close all;
step = 50;
for ii = 1:step:length(th1Sim)
    visPend(th1Sim(ii),th2Sim(ii),th1refSim(ii),ii*h);
    pause(h*step/10)
end

function visPend(th1,th2,ref,t)
l1=0.1;
l2=0.1;
r1 = [l1*cos(th1);l1*sin(th1)];
r2 = [l1*cos(th1)+l2*cos(th2);l1*sin(th1)+l2*sin(th2)];

o0 = [0;0]; 
o1 = r1;
o2 = r2;
v= [o0 o1 o2];

plot(v(1,:),v(2,:),'-o', 'LineWidth',2, 'MarkerSize',10)
title(t);
hold on
plot([0 sin(-ref)],[0 cos(-ref)],'r--')
grid on
axis vis3d equal;
axis([-0.25 0.25 -0.25 0.25 -0.25 0.25])
xlabel('x');
ylabel('y');
zlabel('z');
view([0,90]);
hold off
drawnow
end