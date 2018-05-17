function err = odefitTorque(exp_t,exp_x1,exp_x2,exp_x3,exp_x4,k1,k2,k3,k4,k5,k6,k7,k8,x01,x02,x03,x04,u1,u2,u3,u4)
opts = odeset('RelTol',1e-6,'AbsTol',1e-6);

% Extend the usual model with the two states from the torque, both
% initially zero. 
[t,x1] = ode45(@(t,x)pendubotTorque(t,x,k1,k2,k3,k4,k5,k6,k7,k8,u1),exp_t,[x01;0;0],opts);
[t,x2] = ode45(@(t,x)pendubotTorque(t,x,k1,k2,k3,k4,k5,k6,k7,k8,u2),exp_t,[x02;0;0],opts);
[t,x3] = ode45(@(t,x)pendubotTorque(t,x,k1,k2,k3,k4,k5,k6,k7,k8,u3),exp_t,[x03;0;0],opts);
[t,x4] = ode45(@(t,x)pendubotTorque(t,x,k1,k2,k3,k4,k5,k6,k7,k8,u4),exp_t,[x04;0;0],opts);
% use the frob norm a la least squares 
err = norm((x1(:,1:2)-exp_x1(:,1:2)),'fro')^2+norm((x2(:,1:2)-exp_x2(:,1:2)),'fro')^2+...
    norm((x3(:,1:2)-exp_x3(:,1:2)),'fro')^2+norm((x4(:,1:2)-exp_x4(:,1:2)),'fro')^2; 
end
