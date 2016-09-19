close all;
%ODE demo with spring-mass -- simplests

% System parameterss
m = 1;
k = 1;

% Time
tf = 2*pi*sqrt(m/k);
n = 20000;
h = tf/n; %time step

% initial conditions, z is empty.
v=0; 
x = 1; 
z=[ ];

for i=1:n; % Step the ODE forward in time.
  a = -(k/m)*x; % F = ma
  x = x + h * v; % Update position.
  v = v + h * a; % Update velocity.
  z = [z x]; % Concatenate the results.
  
end

plot(h:h:tf,z);