close all;
%ODE demo with spring-mass. Build on Euler1. Same idea, but better memory
%allocation.

% System parameters
m = 1;
k = 1;

% Time
h = 0.01; % Time step
tf = 2*pi*sqrt(m/k); % Final time
tspan = 0:h:tf; % Vector of all times.

% Pre-allocate memory.
v = zeros(length(tspan),1);
x = zeros(length(tspan),1);

% Initial Conditions
v(1) = 0; 
x(1) = 1; 

for i = 1:length(tspan) - 1
    
  a = -(k/m)*x(i); % F = ma
  x(i+1) = x(i) + h * v(i);
  v(i+1) = v(i) + h * a;
  
end

%%%%%%%%%%%%%%%%%%%%%%


% Plotting stuff
subplot(2,1,1);
plot(tspan,x);
xlim([0,tf]);
ylabel('$x$','Interpreter','latex','FontSize',24);

subplot(2,1,2);
plot(tspan,v);
xlim([0,tf]);
ylabel('$\dot{x}$','Interpreter','latex','FontSize',24);
xlabel('$time$','Interpreter','latex','FontSize',24);