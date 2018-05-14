%function dxdt = pendubot(t,x,k0p,k0n,k1p,k1n,k2,ct,cu)
function dxdt = pendubot(t,x,k1,k2)

% Set params
l1 = 0.1;
g = 9.806; 

m1 = 0.18;
m2 = 0.06;

c1 = 0.06;
c2 = 0.045;
J1 = 0.037;
J2 = 0.00011; 

% Set input using the scaling factor ct. 
% Use a sin as base signal 
% u = 5*sin(t*2*pi); 
% u = 0.4*sin(t*2*pi); 
% chirp

% if(x(3)>0)
%     k1 = k1p;
%     k0 = k0p;
%     sgnw = 1;
% else
%     k1 = k1n;
%     k0 = k0n;
%     sgnw = -1; 
% end
%u = cu*sin(t*2*pi); 
%u = cu;
%u = 0.5;
%u = 0.5*square(t*2*pi); 

% if(u>a)
%     tau = ct*(u-a);
% elseif(u<=a && u>=-a)
%         tau= 0;
% else
%     tau = ct*(u+a);
% end

%tau = ct*u; 

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


% Lyapunov controller
% h = 2*l1; 
% th1tilde = x(1)-pi/2;
% V = m1*g*(h+c1*sin(x(1)))+m2*g*(h+l1*sin(x(1))+c2*sin(x(2)));
% Eupup = m1*g*(h+c1)+m2*g*(h+l1+c2);
% Etilde = 0.5*[x(3) x(4)]*[g11 g12; g21 g22]*[x(3);x(4)]+V-Eupup;
% Up = Fth11+Fth21-Gam111*x(3)^2-Gam122*x(4)^2-gradV1;
% 
% kE = 1.5;
% kP = 1;
% kD = 1;
% kV = 1; 
% 
% tau = (-kV*x(3)-kD*Up-kP*th1tilde+kE*Etilde*k1*x(3))/(kE*Etilde+(kD/detG)*(m2*c2^2+J2));

% zero dyn
% eps = 0.001;
% LfLgh2 = 1/detG*(m2*l1*c2*cos(x(1)-x(2)));
% Lf2h2 = Fth12+Fth22-Gam211*x(3)^2-Gam222*x(4)^2-gradV2;
% kp = 5;
% kd = 6;
% v = -kp*(x(2)-pi/2)-kd*x(4);
% tau = LfLgh2\(v-Lf2h2);

% zero dyn 2
LfLgh2 = 1/detG*g22;
Lf2h2 = Fth11+Fth21-Gam111*x(3)^2-Gam122*x(4)^2-gradV1;
kp1 = 5;
kp2 = 6;
p = 0.4;
epst = 0.1;
% perhaps stabilize towards homoclinic orbit instead of blow up 
x3d = p*(2*(t+epst))*cos(p*((t+epst)^2)); 

v = -kp1*(x(1)-pi/2)-kp2*(x(3)-x3d);
tau = LfLgh2\(v-Lf2h2);

eps1 = 0.5;
eps2 = 0.5; 

if((x(1)-pi/2)^2<eps1 && (x(2)-pi/2)^2<eps2)
K = [-0.8487  -37.1914   -2.6443   -3.6081];
tau = -K*[x(1)-pi/2;x(2)-pi/2;x(3);x(4)];
end


Fu1 = (1/detG)*g22*tau;
Fu2 = -(1/detG)*g21*tau; 

x1 = x(3);
x2 = x(4);
x3 = Fth11+Fth21-Gam111*x(3)^2-Gam122*x(4)^2+Fu1-gradV1;
x4 = Fth12+Fth22-Gam211*x(3)^2-Gam222*x(4)^2+Fu2-gradV2;

dxdt = [x1; x2; x3; x4];