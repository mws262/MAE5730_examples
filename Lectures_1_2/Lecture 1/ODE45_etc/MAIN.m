close all; clear all;
%ODE demo with spring-mass. Same as before, but using one of MATLAB's
%built-in integrators.

% System parameters
p.m = 1;
p.k = 1;

tspan = [0, 2*pi*sqrt(p.m/p.k)]; % initial and final times

% Initial Conditions
v_0 = 0; 
x_0 = 1; 
inits = [x_0, v_0];

opts.RelTol = 1e-6;
opts.AbsTol = 1e-6;

% Or see opt = odeset for4 all options.

% Integrate!
[tarray,zarray] = ode45(@RHS,[0,5],inits,opts,p); % Can use many other integrators too (
x = zarray(:,1);
v = zarray(:,2);



%%%%%%%%%%%%%%%%%%%%%%

% Plotting stuff
subplot(2,1,1);
plot(tarray,x);
xlim([0,tspan(2)]);
ylabel('$x$','Interpreter','latex','FontSize',24);

subplot(2,1,2);
plot(tarray,v);
xlim([0,tspan(2)]);
ylabel('$\dot{x}$','Interpreter','latex','FontSize',24);
xlabel('$time$','Interpreter','latex','FontSize',24);
