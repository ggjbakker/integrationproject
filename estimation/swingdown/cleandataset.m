%simulation parameters
h = 0.01;
d = 80;

%
th1reg = th1m+0.5*pi;
th2reg = th1reg-th2m;
th1reg = th1reg(7/h:end);
th2reg = th2reg(7/h:end);

%calculate offset
th2offset = mean(th2reg(end-1/h:end)+0.5*pi);
th2reg = th2reg-th2offset;
th2reg = (th2reg+0.5*pi)*(0.5*pi)/(0.5*pi+mean(th2reg(1:d-5)))-0.5*pi;

th2reg = th2reg(d:end);
th1reg = ones(length(th2reg),1)*-0.5*pi;