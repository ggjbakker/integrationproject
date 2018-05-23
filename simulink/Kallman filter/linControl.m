%% Linear system, around the upup eq.pt. 

% System around the upup position 

% Set params
l1 = 0.1;
g = 9.806; 

m1 = 0.18;
m2 = 0.06;

c1 = 0.06;
c2 = 0.0628;
J1 = 0.037;
J2 = 0.00011; 

% Actually k1 direction depedent 
k1 = 0.9;
k2 = 0.0004;
A= [                                                                                           0                                                                                             0                                                                              1                                                                                         0;
                                                                                           0                                                                                             0                                                                               0                                                                                        1;
 (g*(m2*c2^2 + J2)*(c1*m1 + l1*m2))/((m2*c2^2 + J2)*(m1*c1^2 + m2*l1^2 + J1) - c2^2*l1^2*m2^2)                  -(c2^2*g*l1*m2^2)/((m2*c2^2 + J2)*(m1*c1^2 + m2*l1^2 + J1) - c2^2*l1^2*m2^2) -(k1*(m2*c2^2 + J2))/((m2*c2^2 + J2)*(m1*c1^2 + m2*l1^2 + J1) - c2^2*l1^2*m2^2)                  (c2*k2*l1*m2)/((m2*c2^2 + J2)*(m1*c1^2 + m2*l1^2 + J1) - c2^2*l1^2*m2^2);
      -(c2*g*l1*m2*(c1*m1 + l1*m2))/((m2*c2^2 + J2)*(m1*c1^2 + m2*l1^2 + J1) - c2^2*l1^2*m2^2) (c2*g*m2*(m1*c1^2 + m2*l1^2 + J1))/((m2*c2^2 + J2)*(m1*c1^2 + m2*l1^2 + J1) - c2^2*l1^2*m2^2)        (c2*k1*l1*m2)/((m2*c2^2 + J2)*(m1*c1^2 + m2*l1^2 + J1) - c2^2*l1^2*m2^2) -(k2*(m1*c1^2 + m2*l1^2 + J1))/((m2*c2^2 + J2)*(m1*c1^2 + m2*l1^2 + J1) - c2^2*l1^2*m2^2)];
 
B =  [                                                                       0;
                                                                         0;
 (m2*c2^2 + J2)/((m2*c2^2 + J2)*(m1*c1^2 + m2*l1^2 + J1) - c2^2*l1^2*m2^2);
    -(c2*l1*m2)/((m2*c2^2 + J2)*(m1*c1^2 + m2*l1^2 + J1) - c2^2*l1^2*m2^2)];

% extend the system with the map from u to tau 
load tSys3.mat 
At = [tSys(1) tSys(2); tSys(3) tSys(4)];
Bt = [tSys(5);tSys(6)];
Ct = [tSys(7) tSys(8)]; 

Ae = [A B*Ct; zeros(2,4) At];
Be = [zeros(4,1);Bt];
Ce =[1 0 0 0 0 0;
    0 1 0 0 0  0]; 

Q = [ 1 0 0 0 0 0;
      0 1 0 0 0 0;
      0 0 0 0 0 0;
      0 0 0 0 0 0;
      0 0 0 0 0 0
      0 0 0 0 0 0];
R = 1;

[K,S,e] = lqr(Ae,Be,Q,R,[]);  
% If correct, looks stable to me. 
eig(Ae-Be*K)
%%
% Design an observer, might be (too) high gain 
obsp = [-100.1;-100.2;-100.3;-100.4;-100.5;-100.6];
L = place(Ae',Ce',obsp);
eig(Ae-L'*Ce)