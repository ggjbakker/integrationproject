function showfit(k_est,tSys,x1,x2,x3,x4,u1,u2,u3,u4,x01,x02,x03,x04,tsim,opt)

if opt==1
[t_est1,x_est1] = ode45(@(t,x) pendubotTorque(t,x,k_est(1),k_est(2),k_est(3),k_est(4),...
    k_est(5),k_est(6),k_est(7),k_est(8),u1),tsim,[x01;0;0]);
[t_est2,x_est2] = ode45(@(t,x) pendubotTorque(t,x,k_est(1),k_est(2),k_est(3),k_est(4),...
    k_est(5),k_est(6),k_est(7),k_est(8),u2),tsim,[x02;0;0]);
[t_est3,x_est3] = ode45(@(t,x) pendubotTorque(t,x,k_est(1),k_est(2),k_est(3),k_est(4),...
    k_est(5),k_est(6),k_est(7),k_est(8),u3),tsim,[x03;0;0]);
[t_est4,x_est4] = ode45(@(t,x) pendubotTorque(t,x,k_est(1),k_est(2),k_est(3),k_est(4),...
    k_est(5),k_est(6),k_est(7),k_est(8),u4),tsim,[x04;0;0]);

figEst1 = figure;
subplot(4,2,1)
plot(tsim,x1(:,1));
hold on
plot(t_est1,x_est1(:,1),'--');
hold off
subplot(4,2,2)
plot(tsim,x1(:,2));
hold on
plot(t_est1,x_est1(:,2),'--');
hold off

subplot(4,2,3)
plot(tsim,x2(:,1));
hold on
plot(t_est2,x_est2(:,1),'--');
hold off
subplot(4,2,4)
plot(tsim,x2(:,2));
hold on
plot(t_est2,x_est2(:,2),'--');
hold off

subplot(4,2,5)
plot(tsim,x3(:,1));
hold on
plot(t_est3,x_est3(:,1),'--');
hold off
subplot(4,2,6)
plot(tsim,x3(:,2));
hold on
plot(t_est3,x_est3(:,2),'--');
hold off

subplot(4,2,7)
plot(tsim,x4(:,1));
hold on
plot(t_est4,x_est4(:,1),'--');
hold off
subplot(4,2,8)
plot(tsim,x4(:,2));
hold on
plot(t_est4,x_est4(:,2),'--');
hold off
else 
  [t_est1,x_est1] = ode45(@(t,x) pendubotEst(t,x,k_est(1),k_est(2),k_est(3),tSys,u1),tsim,[x01;0;0]);
[t_est2,x_est2] = ode45(@(t,x) pendubotEst(t,x,k_est(1),k_est(2),k_est(3),tSys,u2),tsim,[x02;0;0]);
[t_est3,x_est3] = ode45(@(t,x) pendubotEst(t,x,k_est(1),k_est(2),k_est(3),tSys,u3),tsim,[x03;0;0]);
[t_est4,x_est4] = ode45(@(t,x) pendubotEst(t,x,k_est(1),k_est(2),k_est(3),tSys,u4),tsim,[x04;0;0]);

figEst2 = figure;
subplot(4,2,1)
plot(tsim,x1(:,1));
hold on
plot(t_est1,x_est1(:,1),'--');
hold off
subplot(4,2,2)
plot(tsim,x1(:,2));
hold on
plot(t_est1,x_est1(:,2),'--');
hold off

subplot(4,2,3)
plot(tsim,x2(:,1));
hold on
plot(t_est2,x_est2(:,1),'--');
hold off
subplot(4,2,4)
plot(tsim,x2(:,2));
hold on
plot(t_est2,x_est2(:,2),'--');
hold off

subplot(4,2,5)
plot(tsim,x3(:,1));
hold on
plot(t_est3,x_est3(:,1),'--');
hold off
subplot(4,2,6)
plot(tsim,x3(:,2));
hold on
plot(t_est3,x_est3(:,2),'--');
hold off

subplot(4,2,7)
plot(tsim,x4(:,1));
hold on
plot(t_est4,x_est4(:,1),'--');
hold off
subplot(4,2,8)
plot(tsim,x4(:,2));
hold on
plot(t_est4,x_est4(:,2),'--');
hold off  
end