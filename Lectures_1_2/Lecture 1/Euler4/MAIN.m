close all; clear all;
%ODE demo with spring-mass. We have 3 important parts now:
% 1) This script manages the process, sets up the problem.
% 2) RHS expresses our ODEs in 1st order form.
% 3) eulermethod does the actual integration (later subbed for ode45)

% System parameters
p.m = 1;
p.k = 1;

tspan = [0, 2*pi*sqrt(p.m/p.k)]; % initial and final times

% Initial Conditions
v_0 = 0; 
x_0 = 1; 
inits = [v_0, x_0];

% Integrate!
[tarray,zarray] = eulermethod(@RHS,tspan,inits,10000,p);
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