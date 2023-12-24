% 3-body problem periodic solver.
% You can look for new solutions or re-run the ones I've found.
% My previous solutions can be found in getSolutionNum.m.
%
% Matt Sheen

close all;clear all
addpath visualization;

%%% CHANGE SOLUTIONS HERE %%%
solutionNumber = 11; % Which solution would you like to view?
solveON = false; % false -- just run initial conditions. true -- try to find periodic solution using initial conditions as the guess.
                % Note, that if you start with something that's already
                % periodic, solving won't really do anything. Alter a
                % periodic one by a little.
periodsToRun = 5; % How many periods of the solution to run if we're just viewing.

%%% Set up initial conditions %%%
% State vector structure:
% [x1,y1,x2,y2,...,vx1,vy1,vx2,...]
% 
% initPos = 0.4*[1,0, -0.5,sqrt(3)/2, -0.5,-sqrt(3)/2] + rand(1,6)-0.5;
% initVel = 0.75*[0,1, -sqrt(3)/2,-0.5,  sqrt(3)/2,-0.5]+ rand(1,6)-0.5;
% tend = 8;
% inits = [initPos,initVel];

[tend,inits] = getSolutionNum(solutionNumber); % This gets one of my previously-found solutions. You can try other things as well.
inits = [1, 0, -1, 0, 0, 0, ...
    0, sqrt(8/9), 0, -sqrt(8/9), 0, 0]
guess = [tend,inits];

%%%% Set up system parameters %%%%
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

p.fsolveOpts = optimset('fsolve');
p.fsolveOpts.Algorithm = 'levenberg-marquardt'; % fsolve will default to this anyway after a few seconds and a warning message.
p.fsolveOpts.TolX = 1e-8;
p.fsolveOpts.Display = 'iter';

if p.showSolverGuesses
    solvePlots = initSolvePlots(); % We can show the progress of the solutions as fsolve is going.
end

% Run the initial guess.
[tarrayguess,zarrayguess] = ode45(@RHS,[0,periodsToRun*tend],inits,p.odeOpts,p);

if solveON % Use fsolve to try to find a periodic solution based on the given guess.
    solution = fsolve(@(x)(toSolve(x,p,solvePlots)),guess,p.fsolveOpts)
    
    [tarray,zarray] = ode45(@RHS,[0,solution(1)*10],solution(2:end),p.odeOpts,p);
    plot3body(zarrayguess,zarray);
    animate(tarray,zarray,p);
else % Otherwise, just view it instead.
    plot3body(zarrayguess);
    animate(tarrayguess,zarrayguess,p);
end
