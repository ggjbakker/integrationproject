%% (Local) Linear System Identification 
clear all; close all; clc; 
warning off; 

%% IMPORTANT, this is nice, but does only identify some model around the lowest point

%% Load and process the data 
load square05_f5.mat
u = um;
% Get the correct angles  
th1 = pi/2-th1m;
th2 = th1-th2m; 
yd = [th1';th2'];
T = length(u); 
% justified detrend? 
% y = yd-mean(yd')'*ones(1,T); 
y = yd+[pi/2;pi/2]*ones(1,T); 
plot(yd','-k');
hold on;
plot(y','-b');
legend('original','detrend');
h = 0.01; 
dataPend = iddata(y',u,h);

%% Singular values? 
% fourth order is very easy. 
N = 10;
bestfit = 0; 
for n=4:6
% opt = n4sidOptions('Display','on'); 
[sys,x0] = n4sid(dataPend,n);
% A la observer, take the innovator form into account 
prediction_horizon = 1;
[y,fit,x0] = compare(dataPend,sys,prediction_horizon);
    if(mean(fit)>bestfit)
        bestfit=mean(fit);
        nx = n;
    end
end

[sys,x0] = n4sid(dataPend,nx);
compare(dataPend,sys,prediction_horizon);

%% get lqr 

A = sys.A;
B = sys.B;
C = sys.C;
K = sys.K; 
D = sys.D;

R = 10;
Q = eye(nx);
% Barely stable 
[Klqr,S,e] = dlqr(A,B,Q,R,[]); 
clEig = eig(A-B*Klqr);
abs_clEig = abs(clEig)

%% Simulate with the observer

% load different data and check the observer 
load square03_f3.mat
u = um;
% Get the correct angles  
th1 = pi/2-th1m;
th2 = th1-th2m; 
yd = [th1';th2'];
T = length(u); 
% change of coordinates  
y = yd+[pi/2;pi/2]*ones(1,T); 

x0 = zeros(nx,1); 
yh = zeros(2,T); 
xh = zeros(nx,T);
xh(:,1) = x0;
for i=1:length(u) 
   yh(:,i) = C*xh(:,i)+D*u(i);
   xk1 = A*xh(:,i)+B*u(i)+K*(y(:,i)-yh(:,i));
   xh(:,i+1) = xk1; 
end

figObs = figure;
plot(y','-g');
hold on
plot(yh','--b'); 
grid on 
hold off
legend('y','yhat');

% Which state is what? 
figStates = figure;
plot(xh'); 

%% Numerical differentiation  
% Plain numerical differentiation is rather noisy,
% but for the nonlinear model maybe ok. 
for i=2:T-1
   dyk(:,i-1) = (yh(:,i+1)-yh(:,i-1))./(2*h); 
end
plot(dyk')
