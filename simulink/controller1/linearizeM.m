mdl = 'linearizeMdl';
x0 = [-0.51*pi,0,-0.5*pi,0]; %initial state
open_system(mdl);
io(1) = linio('linearizeMdl/Constant',1,'input');
io(2) = linio('linearizeMdl/Plant',1,'openoutput');
linsys1 = linearize(mdl,io);
linearizedSS = ss(linsys1.A,linsys1.B,[1 0 0 0;0 0 1 0],[0;0]);
