% 3-body problem periodic solver.
% You can look for new solutions or re-run the ones I've found.
% My previous solutions can be found in getSolutionNum.m.
%
% Matt Sheen
function main
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

% [tend,inits] = getSolutionNum(solutionNumber); % This gets one of my previously-found solutions. You can try other things as well.
for i = 1:10000000

x1 = 1;
y1 = 0;

x2 = -rand * 0.5 - 0.5;
y2 = sqrt(1 - x2^2);

x3 = -0.5 - (x2 + 0.5);
y3 = -y2;

xd1 = 0;
yd1 = rand * sqrt(8/9);

velrange = 1; % half the range
xd2 = velrange * (rand - 0.5);
yd2 = velrange * (rand - 0.5) - yd1/2;

xd3 = -xd1 - xd2;
yd3 = -yd1 - yd2;

dist12 = sqrt((x1 - x2)^2 + (y1 - y2)^2);
dist13 = sqrt((x1 - x3)^2 + (y1 - y3)^2);
dist23 = sqrt((x3 - x2)^2 + (y3 - y2)^2);

pot = -(1/dist12 + 1/dist13 + 1/dist23);

v1 = sqrt(xd1^2 + yd1^2);
v2 = sqrt(xd2^2 + yd2^2);
v3 = sqrt(xd3^2 + yd3^2);

ke = 1/2 * (v1^2 + v2^2 + v3^2);

kemax = 1/2 * (8/9 * 3);
pemax = -1/sqrt(3) * 3;
emax = kemax + pemax;

inits = [x1, y1, x2, y2, x3, y3, xd1, yd1, xd2, yd2, xd3, yd3];

% inits = [1.0000         0   -0.5863    0.8101    0.4137   -0.8101         0    0.0784    0.1551   -0.1043   -0.1551    0.0259]
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
p.odeOpts.Events = @ev;
tend = 15;
[tarray,zarray, te, ye, ie] = ode45(@RHS,[0,tend],inits,p.odeOpts,p);
% [tarray,zarray] = ode45(@RHS,[0,tend],inits,p.odeOpts,p);

%     animate(tarray,zarray,p);
   plot3body(zarray);

fprintf('time: %0.4f, e: %0.4f, ei: %0.4f\n', te, pot + ke, emax)

if (te > 14.9)
   plot3body(zarray);
   disp("HI");
end
end
    function [v, i, d] = ev(~, y, ~) 
       v = [1  - y(1)^2 - y(2)^2; 1 - y(3)^2 - y(4)^2; 1 - y(5)^2 - y(6)^2]' + eps;
       i = [1;1;1]';
       d = -[1;1;1]';
      
    end

% 
% p.fsolveOpts = optimset('fsolve');
% p.fsolveOpts.Algorithm = 'levenberg-marquardt'; % fsolve will default to this anyway after a few seconds and a warning message.
% p.fsolveOpts.TolX = 1e-8;
% p.fsolveOpts.Display = 'iter';
% 
% if p.showSolverGuesses
%     solvePlots = initSolvePlots(); % We can show the progress of the solutions as fsolve is going.
% end
% 
% % Run the initial guess.
% [tarrayguess,zarrayguess] = ode45(@RHS,[0,periodsToRun*tend],inits,p.odeOpts,p);
% 
% if solveON % Use fsolve to try to find a periodic solution based on the given guess.
%     solution = fsolve(@(x)(toSolve(x,p,solvePlots)),guess,p.fsolveOpts)
%     
%     [tarray,zarray] = ode45(@RHS,[0,solution(1)*10],solution(2:end),p.odeOpts,p);
%     plot3body(zarrayguess,zarray);
%     animate(tarray,zarray,p);
% else % Otherwise, just view it instead.
%     plot3body(zarrayguess);
%     animate(tarrayguess,zarrayguess,p);
% end

end
