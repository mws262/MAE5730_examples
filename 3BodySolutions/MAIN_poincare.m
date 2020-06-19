% 3-body problem periodic solver.
% You can look for new solutions or re-run the ones I've found.
% My previous solutions can be found in getSolutionNum.m.
%
%
% 13 param to 5 param
%
% direction of poincare section, use xdot = 0 for poincare section.
% Eigenvalue of 1 in return map. otto
%
% Matt Sheen

clear all
addpath visualization;

%%% CHANGE SOLUTIONS HERE %%%
for i = 5:5
solutionNumber = 18; % Which solution would you like to view?
solveON = true; % false -- just run initial conditions. true -- try to find periodic solution using initial conditions as the guess.
                % Note, that if you start with something that's already
                % periodic, solving won't really do anything. Alter a
                % periodic one by a little.
periodsToRun = 1.0; % How many periods of the solution to run if we're just viewing.

%%% Set up initial conditions %%%
% State vector structure:
% [x1,y1,x2,y2,...,vx1,vy1,vx2,...]
% 
% initPos = 0.4*[1,0, -0.5,sqrt(3)/2, -0.5,-sqrt(3)/2] + rand(1,6)-0.5;
% initVel = 0.75*[0,1, -sqrt(3)/2,-0.5,  sqrt(3)/2,-0.5]+ rand(1,6)-0.5;
% tend = 8;
% inits = [initPos,initVel];

[tend,inits] = getSolutionNum(solutionNumber); % This gets one of my previously-found solutions. You can try other things as well.
%  inits = [    0.1135    0.6214    0.1339   -1.4660   -0.2419    0.4314   -0.4286   -1.2691   -0.2390   -0.0835    0.6680    1.3527
% ]
guess = [tend,inits];

%%%% Set up system parameters %%%%
p.G = 1;
p.m1 = 1;
p.m2 = 1;
p.m3 = 1;
p.tfactor = 1; % Animation speedup factor
p.showSolverGuesses = true; % Plot the tested solutions as the solver is going.

% Solver/integration options
p.odeOpts = odeset;
p.odeOpts.RelTol = 1e-10;
p.odeOpts.AbsTol = 1e-10;

p.fsolveOpts = optimset('fsolve');
p.fsolveOpts.Algorithm = 'levenberg-marquardt'; % fsolve will default to this anyway after a few seconds and a warning message.
p.fsolveOpts.TolX = 1e-8;
p.fsolveOpts.Display = 'iter';

if p.showSolverGuesses
    solvePlots = initSolvePlots(); % We can show the progress of the solutions as fsolve is going.
end

% Run the initial guess.
[tarrayguess,zarrayguess] = ode45(@RHS,[0,periodsToRun*tend],inits,p.odeOpts,p);
% zarrayguess = gls(@RHS,@(t, z, varg)(dynJ(z',1,1,1,1)), linspace(0, periodsToRun * tend, 1000),inits',10, linspace(0, periodsToRun * tend, 1000), 1e-5, 1000,p);

p1 = zarrayguess(:, 1:2);
p2 = zarrayguess(:, 3:4);
p3 = zarrayguess(:, 5:6);

rho = 1/sqrt(2) * (p1 - p2);
lambda = 1/sqrt(6) * (p1 + p2 - 2*p3);
rho_magsq = sum(rho.^2, 2);
lambda_magsq = sum(lambda.^2, 2);

Rsq = rho_magsq + lambda_magsq;

n = [-2 * dot(rho, lambda, 2)./Rsq, (lambda_magsq - rho_magsq)./Rsq, sum(2 * cross([rho, zeros(size(rho,1), 1)], [lambda, zeros(size(rho,1), 1)]), 2)./Rsq];

fig = figure;
fig.Color = [1,1,1];
ax = axes;
shapeSphPl = plot3(n(:, 1), n(:,2), n(:, 3), 'r');
shapeSphPl.LineWidth = 4;
hold on;
[Xsph, Ysph, Zsph] = sphere(25);
sph = surf(0.99*Xsph, 0.99*Ysph, 0.99*Zsph);
sph.EdgeAlpha = 0.3;
sph.FaceAlpha = 0.5;
axis equal
ax.Visible = false;

shg

if solveON % Use fsolve to try to find a periodic solution based on the given guess.
    solution = fsolve(@(x)(toSolve(x,p,solvePlots)),guess,p.fsolveOpts)
    
    [tarray,zarray] = ode45(@RHS,[0,solution(1)*10],solution(2:end),p.odeOpts,p);
    plot3body(zarrayguess,zarray);
    animate(tarray,zarray,p);
else % Otherwise, just view it instead.
    figure;
    fig = plot3body(zarrayguess);
    fig.Children.Visible = 'off';
    fig.Children.Clipping = 'off';
    axis([min(min(zarrayguess(:,[1,3,5]))) - 0.1, max(max(zarrayguess(:,[1,3,5]))) + 0.1, min(min(zarrayguess(:,[2,4,6]))) - 0.1, max(max(zarrayguess(:,[2,4,6]))) + 0.1]);
    axis equal
    save2pdf(['solsm', num2str(solutionNumber), '.pdf'], gcf, 600);
%     animate(tarrayguess,zarrayguess,p);
end
end