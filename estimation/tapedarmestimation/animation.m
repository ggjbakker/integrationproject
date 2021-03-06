close all;
step = 5;
for ii = 1:step:0.5/h
    %visPend(set3th1reg(ii),set3th2reg(ii));
    visPend(th1Sim(ii),th2Sim(ii));
    pause(h*step/10)
end

function visPend(th1,th2)
l1=0.1;
l2=0.1;
r1 = [l1*cos(th1);l1*sin(th1)];
r2 = [l1*cos(th1)+l2*cos(th2);l1*sin(th1)+l2*sin(th2)];

o0 = [0;0]; 
o1 = r1;
o2 = r2;
v= [o0 o1 o2];

plot(v(1,:),v(2,:),'-o', 'LineWidth',2, 'MarkerSize',10)
grid on
axis vis3d equal;
axis([-0.25 0.25 -0.25 0.25 -0.25 0.25])
xlabel('x');
ylabel('y');
zlabel('z');
view([0,90]);
drawnow
end