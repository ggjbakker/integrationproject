%% Parameter estimation
% Based on https://nl.mathworks.com/matlabcentral/answers/60726-estimate-differential-equation-parameters
% set up nonlin LS routine, very sensitive to initial condition. 
% Also fminsearch is derivative free, thus relatively fast, but less accurate.  
clear all; close all; clc;
warning off; 

% Load several data-sets. 

load sin032.mat; 
% Process the data 
th1 = pi/2-th1m1;
th2 = th1-th2m1; 
x1 = [th1(1:501) th2(1:501)];
x01 = [th1(1);th2(1);0;0]; 
u1 = 0.3;

load sin052.mat; 
% Process the data 
th1 = pi/2-th1m1;
th2 = th1-th2m1; 
x2 = [th1(1:501) th2(1:501)];
x02 = [th1(1);th2(1);0;0]; 
u2 = 0.5;

load sin05p.mat; 
% Process the data 
th1 = pi/2-th1m1;
th2 = th1-th2m1; 
x3 = [th1(1:501) th2(1:501)];
x03 = [th1(1);th2(1);0;0]; 
u3 = 0.5;

load sin092.mat; 
% Process the data 
th1 = pi/2-th1m1;
th2 = th1-th2m1; 
x4 = [th1(1:501) th2(1:501)];
x04 = [th1(1);th2(1);0;0]; 
u4 = 0.5; 

% Define simulation time 
h = 0.01; 
tsim = 0:h:5;  

options = optimset('Display','iter','TolFun',1e-4,'TolX',1e-4,'MaxIter',250,'MaxFunEvals',250); 
% k0 = [k1p,k1n,k2,ct]
k0=[0.7;0.9;0.000001;5];

% See odefit() for the cost function 
[k_est,fval,exitflag,output] = fminsearch(@(k)odefit(tsim,x1,x2,x3,x4,k(1),k(2),k(3),k(4),...
    x01,x02,x03,x04,u1,u2,u3,u4),k0,options);

%% Compare the initial parameters with the estimated ones 

figk=figure;
plot(k0,'-o');
hold on
plot(k_est,'-x');
hold off

%% Simulate the model with estimate parametes and compare 

[t_est1,x_est1] = ode45(@(t,x) pendubotEst(t,x,k_est(1),k_est(2),k_est(3),k_est(4),...
    u1),tsim,x01);
[t_est2,x_est2] = ode45(@(t,x) pendubotEst(t,x,k_est(1),k_est(2),k_est(3),k_est(4),...
    u2),tsim,x02);
[t_est3,x_est3] = ode45(@(t,x) pendubotEst(t,x,k_est(1),k_est(2),k_est(3),k_est(4),...
    u3),tsim,x03);
[t_est4,x_est4] = ode45(@(t,x) pendubotEst(t,x,k_est(1),k_est(2),k_est(3),k_est(4),...
    u4),tsim,x04);

figEst = figure;
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