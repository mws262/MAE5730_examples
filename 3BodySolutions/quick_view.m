close all;
% load('sol4074.mat');
n = length(solution) - 1;
x = solution(1:n/4);
y = solution(n/4 + 1:n/2);
xd = solution(n/2 + 1:3*n/4);
yd = solution(3*n/4 + 1:n);

init = [x;-sum(x);y;-sum(y);xd;-sum(xd);yd;-sum(yd)];
[tarray,zarray] = ode15s(@nbody_rhs,[0,solution(end)],init,p.odeOpts,p);
    figure;
    hold on;
    sumx = 0;
    sumy = 0;
    for i = 1:n -  1
%         sumx = sumx + zarray(:, i);
%         sumy = sumy + zarray(:, i + n);
       plot(zarray(:,i), zarray(:, i + n)); 
              hold on;

       plot(zarray(end,i), zarray(end, i + n), '.r', 'MarkerSize', 20); 
    end
%     plot(-sumx, -sumy)
%            plot(-sumx(end), -sumy(end), '.r', 'MarkerSize', 20); 

    axis equal