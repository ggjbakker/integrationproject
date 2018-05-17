function [x1,x01,u1]=processData(fileName,u,h,T)
load(fileName); 
Tf = T/h+1;
% Process the data 
th1 = pi/2-th1m1;
th2 = th1-th2m1; 
x1 = [th1(1:Tf) th2(1:Tf)];
x01 = [th1(1);th2(1);0;0]; 
u1 = u; 