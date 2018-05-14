%Linearized state space

%Parameters
K = 1.8; %motor gain
k1 = 0.35; %friction coefficient first link
k2 = 0.0002; %friction coefficient second link
g = 9.81; %Gravity
l1 = 0.1; %length of first link in m
l2 = 0.1; %length of second link in m
m1 = 0.18; %mass of first link
m2 = 0.06; %mass of second link
c1 = 0.06; %center of mass of first link
c2 = 0.045; %center of mass of second link
I1 = 0.037; %inertia of first link
I2 = 0.00011; %inertia of second link

%UpUp
alpha = ((m2*c2^2 + I2)*(m1*c1^2+m2*l1^2+I1)-c2^2*l1^2*m2^2);
beta = (c1*m1+l1*m2);
gamma = (m1*c1^2+m2*l1^2+I1);
v = (m2*c2^2+I2);
A = [0 0 1 0;
     0 0 0 1;
     g*v*beta/alpha -c2^2*g*l1*m2^2/alpha -k1*v/alpha c2*k2*l1*m2/alpha; 
     -c2*g*l1*m2*beta/alpha c2*g*m2*gamma/alpha c2*k1*l1*m2/alpha -k2*gamma/alpha];
B = [0;0;K*v/alpha;-c2*l1*m2/alpha];
C = [1 0 0 0;0 1 0 0];
D = [];
linearizedSSuu = ss(A,B,C,D);

%DownDown
alpha = ((m2*c2^2 + I2)*(m1*c1^2+m2*l1^2+I1)-c2^2*l1^2*m2^2);
beta = (c1*m1+l1*m2);
gamma = (m1*c1^2+m2*l1^2+I1);
v = (m2*c2^2+I2);
A = [0 0 1 0;
     0 0 0 1;
     -g*v*beta/alpha c2^2*g*l1*m2^2/alpha -k1*v/alpha c2*k2*l1*m2/alpha; 
     c2*g*l1*m2*beta/alpha -c2*g*m2*gamma/alpha c2*k1*l1*m2/alpha -k2*gamma/alpha];
B = [0;0;K*v/alpha;-c2*l1*m2/alpha];
C = [1 0 0 0;0 1 0 0];
D = [];
linearizedSSdd = ss(A,B,C,D);
