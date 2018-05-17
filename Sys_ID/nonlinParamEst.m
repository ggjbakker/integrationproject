%% Nonlinear parameter estimation
% Iteratively, fit tau, then friction.
% The other parameters are ideally identified differently. 
clear all; close all; clc; warning off; 

T = 5; 
h = 0.01; 
tsim = 0:h:T;  

[x1,x01,u1]=processData('sin032.mat',0.3,h,T); 
[x2,x02,u2]=processData('sin03.mat',0.3,h,T); 
[x3,x03,u3]=processData('sin052.mat',0.5,h,T); 
[x4,x04,u4]=processData('sin05.mat',0.5,h,T); 

%%
options = optimset('Display','iter','TolFun',1e-4,'TolX',1e-4,'MaxIter',100,'MaxFunEvals',100); 
% first estimate the torque, 
% A11,A12,A21,A22,B1,B2,C1,C2

%k0=[0;0;0;0;0;0;0;0];
%load tSys2.mat
k0 = tSys; 
[k_est,fval,exitflag,output] = fminsearch(@(k)odefitTorque(tsim,x1,x2,x3,x4,k(1),k(2),k(3),k(4),k(5),...
    k(6),k(7),k(8),x01,x02,x03,x04,u1,u2,u3,u4),k0,options);
%%
tSys = k_est;
A = [tSys(1) tSys(2); tSys(3) tSys(4)];
B = [tSys(5);tSys(6)];
C = [tSys(7) tSys(8)]; 
%% show responses and fit 
showfit(k_est,tSys,x1,x2,x3,x4,u1,u2,u3,u4,x01,x02,x03,x04,tsim,1)

%% Using the torque estimate/improve friction 
% pendubotEst(t,x,k1p,k1n,k2,tSys,cu)
options = optimset('Display','iter','TolFun',1e-4,'TolX',1e-4,'MaxIter',100,'MaxFunEvals',100); 
k0=[0.8;0.94;0.0004];
[k_est,fval,exitflag,output] = fminsearch(@(k)odefit(tsim,x1,x2,x3,x4,k(1),k(2),k(3),...
    x01,x02,x03,x04,u1,u2,u3,u4,tSys),k0,options);

%% show responses and fit 
showfit(k_est,tSys,x1,x2,x3,x4,u1,u2,u3,u4,x01,x02,x03,x04,tsim,0)

%% Evaluate the linear system relating u and tau
% Amplification of u is about 5. 
% In some sense we found a linear relation anyway, but with some lag. 
sys = ss(A,B,C,[]);
t=0:0.01:5;
x0 = [0;0];
u = sin(t*2*pi);
lsim(sys,u,t,x0)
