function [c,ceq] = optimConstraint(X,p)
% Our constraint is that the final x must == our target range. We run the
% simulation inside here to check.
theta = X(1);
v0 = X(2);

xdot = cos(theta)*v0;
ydot = sin(theta)*v0;

init = [0,0,xdot,ydot];

[tarray,zarray] = ode45(@RHS,[0,10],init,p.odeopt,p);

c = 0; % Inequality constraint. A thing which must be <=0. We don't care about this, so we make it always true.
ceq = p.range - zarray(end,1); % Equality constraint. Must == 0. ie final point must be target.
end