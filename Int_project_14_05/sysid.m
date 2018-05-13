%% lin syst id 
clear all; close all; clc; 
load sin025_f10.mat
u = um1;
y = [th1m1 th2m1];
h = 0.001; 
data1 = iddata(y,u,h);
nx = 10; 

sys = n4sid(data1,nx);

%% get lqr 

A = sys.A;
B = sys.B;
C = sys.C;
K = sys.K; 
D = sys.D;

R = 1;
Q = eye(4);
[Klqr,S,e] = dlqr(A,B,Q,R,[]); 
