%% Visualize reponse 

t=0:h:(length(y_meas(:,1))-1)*h;

% check the desired input vs the saturated input

figu = figure;
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
plot(time,u,'-k');
hold on
plot(time,u_sat,'-y');
hold off
legend('u','usat')

% check observer performance
figO = figure;
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
subplot(2,1,1);
p=plot(time,yh(:,1),'-g');
p.LineWidth=3;
hold on
plot(t,y_meas(:,1),'-k');
hold off
legend('yh','ym')
subplot(2,1,2);
p=plot(time,yh(:,2),'-g');
p.LineWidth=3;
hold on
plot(t,y_meas(:,2),'-k');
hold off
legend('yh','ym')

% show the observer states, especially velocity must be bounded
figxh = figure;
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
plot(time,xh)
