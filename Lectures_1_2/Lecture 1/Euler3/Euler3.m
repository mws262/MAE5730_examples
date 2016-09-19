close all; clear all;
%ODE demo with spring-mass. This time we separate the ODE into a different
%function.

% System parameters
p.m = 1;
p.k = 1;

% Set up time
h = 0.1; % Time step
tf = 2*pi*sqrt(p.m/p.k); % Final time
tarray = 0:h:tf; % Vector of all times.
n = length(tarray); % Number of timesteps

% Pre-allocate memory.
v = zeros(n,1);
x = zeros(n,1);

% Initial Conditions
v_0 = 0;
x_0 = 1;
zarray = zeros(n,2);
zarray(1,:) = [v_0, x_0];

for i = 1:n-1
    z = zarray(i,:)';
    t = tarray(i);
    znew = z + h*RHS(t,z,p); %THE KEY LINE!!
    zarray(i+1,:) = znew';
end

x = zarray(:,1);
v = zarray(:,2);


%%%%%%%%%%%%%%%%%%%%%%

% Plotting stuff
subplot(2,1,1);
plot(tarray,x);
xlim([0,tf]);
ylabel('$x$','Interpreter','latex','FontSize',24);

subplot(2,1,2);
plot(tarray,v);
xlim([0,tf]);
ylabel('$\dot{x}$','Interpreter','latex','FontSize',24);
xlabel('$time$','Interpreter','latex','FontSize',24);