function dxdt = pendubotTorque(t,x,A11,A12,A21,A22,B1,B2,C1,C2,cu)
% A pendubot model, including a linear second order model for the mapping
% from voltage to torque. 
% Thus now we have six states. 


% Set params
l1 = 0.1;
g = 9.806; 

m1 = 0.18;
m2 = 0.06;

c1 = 0.06;
% instead of 0.045; 
c2 = 0.0628;
J1 = 0.037;
J2 = 0.00011; 

k1p = 0.79;
k1n = 0.93; 
k2 = 0.0007; 

if(x(3)>0)
    k1 = k1p;
else
    k1 = k1n;
end
u = cu*sin(t*2*pi); 

% Set up a basis state space model 
x5 = [A11 A12]*[x(5);x(6)]+B1*u;
x6 = [A21 A22]*[x(5);x(6)]+B2*u;
tau = [C1 C2]*[x(5);x(6)]; 

% Set equ's
g11 = m1*c1^2+m2*l1^2+J1;
g21 = m2*l1*c2*cos(x(1)-x(2));
g12 = m2*l1*c2*cos(x(1)-x(2));
g22 = m2*c2^2+J2;
detG = g11*g22-g21*g12; 

V1 = g*cos(x(1))*(m1*c1+m2*l1);
V2 = g*c2*m2*cos(x(2));
gradV1 = (1/detG)*(g22*V1-g12*V2);
gradV2 = (1/detG)*(g11*V2-g21*V1);

Fth11 = -(1/detG)*g22*(k1*x(3));
Fth12 = (1/detG)*g21*(k1*x(3)); 
Fth21 = (1/detG)*g21*k2*x(4);
Fth22 = -(1/detG)*g11*k2*x(4); 
Gam111 = (1/detG)*(0.5*m2^2*l1^2*c2^2*sin(2*(x(1)-x(2))));
Gam122 = -(1/detG)*g22*(m2*l1*c2*sin(x(1)-x(2))); 
Gam211 = (1/detG)*g11*(m2*l1*c2*sin(x(1)-x(2)));
Gam222 = -(1/detG)*(0.5*m2^2*l1^2*c2^2*sin(2*(x(1)-x(2))));

Fu1 = (1/detG)*g22*tau;
Fu2 = -(1/detG)*g21*tau; 

x1 = x(3);
x2 = x(4);
x3 = Fth11+Fth21-Gam111*x(3)^2-Gam122*x(4)^2+Fu1-gradV1;
x4 = Fth12+Fth22-Gam211*x(3)^2-Gam222*x(4)^2+Fu2-gradV2;

dxdt = [x1; x2; x3; x4; x5; x6];