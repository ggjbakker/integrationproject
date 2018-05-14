function err = odefit(exp_t,exp_x1,exp_x2,exp_x3,exp_x4,k1,k2,k3,k4,x01,x02,x03,x04,u1,u2,u3,u4)
opts = odeset('RelTol',1e-6,'AbsTol',1e-6);
[t,x1] = ode45(@(t,x)pendubotEst(t,x,k1,k2,k3,k4,u1),exp_t,x01,opts);
[t,x2] = ode45(@(t,x)pendubotEst(t,x,k1,k2,k3,k4,u2),exp_t,x02,opts);
[t,x3] = ode45(@(t,x)pendubotEst(t,x,k1,k2,k3,k4,u3),exp_t,x03,opts);
[t,x4] = ode45(@(t,x)pendubotEst(t,x,k1,k2,k3,k4,u4),exp_t,x04,opts);
% use the frob norm a la least squares 
err = norm((x1(:,1:2)-exp_x1(:,1:2)),'fro')^2+norm((x2(:,1:2)-exp_x2(:,1:2)),'fro')^2+...
    norm((x3(:,1:2)-exp_x3(:,1:2)),'fro')^2+norm((x4(:,1:2)-exp_x4(:,1:2)),'fro')^2-...
log(k1)-log(k2)-log(k3)-log(k4); 
end
