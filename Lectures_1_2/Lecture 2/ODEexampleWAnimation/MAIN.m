% Define parameters
close all; clear all
p.g = 9.8;
p.l = 1;

% Simulation time span
tspan = [0,10];

% Initial conditions
init = [pi/2,0];

options = odeset;

[tarray,zarray] = ode45(@RHS,tspan,init,options,p);

plot(tarray,zarray(:,1));


% Version 1 -- CRAPPY:
fig = figure;
pend = plot(0,0);
axis([-2 2 -2 2]);

for i = 1:length(tarray)
   th = zarray(i,1);

    pend.XData = [0,p.l*sin(th)];
    pend.YData = [0,-p.l*cos(th)];
    pause(0.02)
    drawnow;


end


% Version 2: Less crappy
fig = figure;
pend = plot(0,0);
axis([-2.2 2.2 -2 2]);


timeFactor = 1;
currTime = 0;

tic

while currTime < tspan(2)*timeFactor
   th = interp1(tarray,zarray(:,1),currTime*timeFactor);

    pend.XData = [0,p.l*sin(th)];
    pend.YData = [0,-p.l*cos(th)];
    drawnow;

    currTime = toc;
end



% Even prettier:
fig = figure;
pend = patch([-0.05,0.05,0.05,-0.05],[0,0,-p.l -p.l],'r');

originalVertices = pend.Vertices;

axis([-2.2 2.2 -2 2]);

timeFactor = 1;
currTime = 0;

tic

while currTime < tspan(2)*timeFactor
    th = interp1(tarray,zarray(:,1),currTime*timeFactor);
    rotation = [cos(th),-sin(th); sin(th),cos(th)];
    
    pend.Vertices = (rotation*originalVertices')';
    drawnow;
    
    currTime = toc;
end
