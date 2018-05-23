%simulation parameters
h = 0.01;

%
th1reg = th1m+0.5*pi;
th2reg = th1reg-th2m;

%calculate offset
th2offset = mean(th2reg(end-1/h:end)-0.5*pi);
th2reg = th2reg-th2offset;

th2reg = th1reg+pi;
%th2reg = th2reg(d:end);
%th1reg = ones(length(th2reg),1)*-0.5*pi;

%set1
load tapedarm03.mat
set1th1reg = th1m+0.5*pi;
set1th2reg = set1th1reg+pi;

%set2
load tapedarm05.mat
set2th1reg = th1m+0.5*pi;
set2th2reg = set2th1reg+pi;

%set3
load tapedarm07.mat
set3th1reg = th1m+0.5*pi;
set3th2reg = set3th1reg+pi;

%set4
load tapedarm1.mat
set4th1reg = th1m+0.5*pi;
set4th2reg = set4th1reg+pi;