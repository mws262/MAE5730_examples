%% Problem 19 - deriver
% Derive simple pendulum EOM with y being horizontal right, x is vertical
% down, final ODE must be in terms of y's only.

%% Define variables
syms x xdot xdotdot y ydot ydotdot m l g real

%% LMB in X
% m*xdotdot = -mg - x/l*T, rearrange and solve for T. Get rid of x by
% subbing x = sqrt(l^2-y^2)
eqn1forT = (m*xdotdot-m*g)/(-sqrt(l^2-y^2)/l);

%% LMB in Y
% m*ydotdot = - y/l*T, rearrange and solve for T.
eqn2forT = (m*ydotdot)/(-y/l);

%% Constraint equation - Pendulum remains constant length
% x = sqrt(l^2 - y^2), just Pythagorean thm for constant length pendulum
constraint = sqrt(l^2-y^2); % = x

% Take first time derivative. Chain rule means partial derivative wrt y
% times ydot.
dconstraint = jacobian(constraint,y)*ydot; % = xdot

% Take second time derivative. Chain rules means partial derivatives wrt
% both y and ydot times ydot and ydotdot, respectively.
ddconstraint = jacobian(dconstraint,[y,ydot])*[ydot,ydotdot]'; % = xdotdot

%% Substitute and solve
% Take our LMB which was in terms of xdotdot. Plug in the expression for
% xdotdot that we got from the constraint
eqn1forTinY = subs(eqn1forT,xdotdot,ddconstraint);

% Now we have two expressions for our constraint torque. We eliminated
% xdotdot in one. We can subtract the two to eliminate the constraint
% force. Then, solve the equation for y acceleration.
answer = solve(eqn1forTinY - eqn2forT,ydotdot);

% Write y acceleration as a MATLAB function.
matlabFunction(answer,'file','ydotdot');

fprintf('ydotdot = \n\n');
pretty(simplify(answer));




