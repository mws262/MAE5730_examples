close all;
p.G = 1;
p.m1 = 1;
p.m2 = 1;
p.m3 = 1;

% Vis options
p.tfactor = 1; % Animation speedup factor
p.showSolverGuesses = true; % Plot the tested solutions as the solver is going.

% Solver/integration options
p.odeOpts = odeset;
p.odeOpts.RelTol = 1e-10;
p.odeOpts.AbsTol = 1e-10;

init = rand(12, 1) - 0.5;
init(1:6) = init(1:6) * 2;
[t,z] = ode45(@RHS,[0: 0.001:30],init,p.odeOpts,p);

fig = gcf;
ax = axes;
ax.Visible = 'off';
fig.Color = [1, 1, 1];
fig.Position = [100,100,1000,1000];

hold on
g1 = plot(z(end,1),z(end,2),'.','MarkerSize',50); % Could use comet instead
g1tail = plot(z(:,1),z(:,2),'-','LineWidth',2,'Color',[0.8*g1.Color,0.8]);
g2 = plot(z(end,3),z(end,4),'.','MarkerSize',50);
g2tail = plot(z(1:10:end,3),z(1:10:end,4),':','LineWidth',2,'Color',[0.8*g2.Color,0.8]);
g3 = plot(z(end,5),z(end,6),'.','MarkerSize',50);
g3tail = plot(z(:,5),z(:,6),'--','LineWidth',2,'Color',[0.8*g3.Color,0.8]);
axis equal