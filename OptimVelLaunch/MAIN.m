close all; clear all

% System params (consistent units, say mks)
p.m = 1;        % mass
p.range = 4;   % range we are shooting to
p.c = 0.5;      % quadratic drag constant
p.g = 10;
p.odeopt = odeset; % Set ODE45 options options. We pass these in p so ode45
                   % inside of the optimization can see it too.
p.odeopt.Events = @myEvent;  % Event function (y==0 when cannonball lands)

% Set options
opt = optimset('fmincon'); % Set optimization options

% Lower/upper bounds, constraints on search and output
LB = [0.01,0];     %theta>=.01,    v0 >=  0
UB = [pi/2,1e10]; %theta <=pi/2,  v0 <= 1e10

% Initial guess for [theta V]
guess = [pi/3,10];

%FMINCON, X is the best X = [theta V0]'
X = fmincon(@optimThis,guess,[],[],[],[],LB,UB,@optimConstraint,opt,p);
% optimThis says to minimize v0
% initial guess to start optimization is guess
% [],[],[],[] are a bunch of optimization options for which we use default.
% LB and UB are simple bounds on the variables
% optimConstraint is that the ode solution has to get to the range
% opt are the optimization options,  [] would work
% p are parameters that get passed through to all the functions (ode45,
% optimization tools, into the events function, etc)
% X is  the best theta and v (minimizes v for the given range and
%    parameters)


% Simulate and plot it
theta = X(1);
v0    = X(2);

rzero   = [0 0]';   % launch from origin
velzero = v0 * [cos(theta) sin(theta)]'; % initial velocity vector

init = [rzero; velzero]; % initial conditions

[tarray,zarray] = ode45(@RHS,[0,15],init,p.odeopt,p); % Run the simulation with the parameters we found using fmincon
x = zarray(:,1); y = zarray(:,2);

plot(x,y, 'linewidth', 5); title('Trajectory of minimum velocity to reach target')
ylim([0, max(y)*2]); daspect([1,1,1]); grid on; % daspect is similar to axis equal, but lets us set other dimensions without overwriting them.

fprintf('Min launch speed is %0.2f.\nBest launch angle is %0.2f from horizontal.\nMax height is %0.2f.\n',v0,theta*180/pi,max(y));

