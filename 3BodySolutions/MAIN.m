function MAIN

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

close all;clear all
addpath visualization;

%%% CHANGE SOLUTIONS HERE %%%
solutionNumber = 4; % Which solution would you like to view?
solveON = false; % false -- just run initial conditions. true -- try to find periodic solution using initial conditions as the guess.
                % Note, that if you start with something that's already
                % periodic, solving won't really do anything. Alter a
                % periodic one by a little.
periodsToRun = 1.1; % How many periods of the solution to run if we're just viewing.

%%% Set up initial conditions %%%
% State vector structure:
% [x1,y1,x2,y2,...,vx1,vy1,vx2,...]
% 
% initPos = 0.4*[1,0, -0.5,sqrt(3)/2, -0.5,-sqrt(3)/2] + rand(1,6)-0.5;
% initVel = 0.75*[0,1, -sqrt(3)/2,-0.5,  sqrt(3)/2,-0.5]+ rand(1,6)-0.5;
% tend = 8;
% inits = [initPos,initVel];

[tend,inits] = getSolutionNum(solutionNumber); % This gets one of my previously-found solutions. You can try other things as well.

guess = [tend,inits];

%%%% Set up system parameters %%%%
p.G = 1;
p.m1 = 1;
p.m2 = 1;
p.m3 = 1;

% Vis options
p.tfactor = 1; % Animation speedup factor
p.showSolverGuesses = false; % Plot the tested solutions as the solver is going.

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
else
    solvePlots = [];
end
foundPlane = false;
for i = 1:5000
    p.odeOpts.Events =[];
    guess(2:end) = inits;
    solution = fsolve(@(x)(toSolve(x,p,solvePlots)),guess,p.fsolveOpts)
    inits = solution(2:end);
    tend = solution(1);
    [tarray,zarray] = ode45(@RHS,[0,solution(1)],solution(2:end),p.odeOpts,p);
% [tarrayguess,zarray] = ode45(@RHS,[0,periodsToRun*tend],inits,p.odeOpts,p);

p1 = zarray(:, 1:2);
p2 = zarray(:, 3:4);
p3 = zarray(:, 5:6);

% Either max in a direction or just use the initial point we already have.
% [maxY, idxMaxY] = max(p1(:, 2));
% maxX = p1(idxMaxY, 1);

if true %~foundPlane
        foundPlane = true;
    idxMaxY = 1;
    maxX = zarray(1,1);
    maxY = zarray(1,2);

    vxAtMax = zarray(idxMaxY, 7);
    vyAtMax = zarray(idxMaxY, 8);
    sectionVec = [vyAtMax, -vxAtMax];
    plot([maxX, maxX + sectionVec(1)], [maxY, maxY + sectionVec(2)]);
    hold on;
end
plot(p1(end, 1), p1(end, 2), '.', 'MarkerSize', 5);
plot(p2(end, 1), p2(end, 2), '.', 'MarkerSize', 5);
plot(p3(end, 1), p3(end, 2), '.', 'MarkerSize', 5);

 plot3body(zarray);
animate(tarray,zarray,p)
drawnow();

% Cross product to decide which side of the section the particle is on.
% Happens when this crosses 0. May happen many times in a cycle though, so
% only good very locally.
% sectionCrossings = (p1(:, 1) - maxX) * sectionVec(2) - (p1(:, 2) - maxY) * sectionVec(1)

p.odeOpts.Events = @evnt;
diffSize = 1e-11;
J = zeros(length(inits));
for varIn = 1:length(inits)     
    fun = @(d)deviationFun(d, varIn);
    DinDouts = estimateDeriv(fun, diffSize)';
    J(:, varIn) = DinDouts;    
end

[vec, val] = eig(J);
vals = diag(val);

% Pick the eigenvector associated with an eigenvalue equal to one with no
% imaginary stuff in the eigenvector.
possibleIdx = abs(abs(real(vals)) - 1) < 0.02;
okVecs = sum(abs(imag(vec(:, possibleIdx))),1) < 0.01;
possibleVecs = vec(:, possibleIdx);

okVecIdx = find(okVecs, 1, 'first'); % Just pick the first potentially ok one.

okVecChosen = possibleVecs(:, okVecIdx);

deviateMultiplier = 0.03;
inits = inits + okVecChosen' * deviateMultiplier;

end

% figure;
% for i = -0.0001:0.00001:0.0001
%     inits(4) = inits(4) + i;
% [tarrayguess,zarrayguess] = ode45(@RHS,[0,periodsToRun*tend],inits,p.odeOpts,p);
%     plot3body(zarrayguess);
% end

% Picked a central difference using 4 points. Pretty arbitrary choice.
function deriv = estimateDeriv(f, h)
        deriv = (f(-2 * h) - 8 * f(-h) + 8 * f(h) - f(2 * h))/(12 * h);
end

function res = deviationFun(h, idx)
    ICs = inits;
    ICs(idx) = ICs(idx) + h; % Alter the initial conditions at the specified place.
    [tout,zout] = ode45(@RHS,[0,periodsToRun*tend],ICs,p.odeOpts,p);
    res = zout(end, :); % Return the final state after the deviated initial conditions have been applied.
end

function [val, isterminal, dir] = evnt(t, z, p)
if t > (tend - 0.1)
    val = ((z(1) - maxX) * sectionVec(2) - (z(2) - maxY) * sectionVec(1));
else
    val = 1;
end
isterminal = 1;
dir = 0;
end

% rho = 1/sqrt(2) * (p1 - p2);
% lambda = 1/sqrt(6) * (p1 + p2 - 2*p3);
% rho_magsq = sum(rho.^2, 2);
% lambda_magsq = sum(lambda.^2, 2);
% 
% Rsq = rho_magsq + lambda_magsq;
% 
% n = [-2 * dot(rho, lambda, 2)./Rsq, (lambda_magsq - rho_magsq)./Rsq, sum(2 * cross([rho, zeros(size(rho,1), 1)], [lambda, zeros(size(rho,1), 1)]), 2)./Rsq];
% 
% fig = figure;
% fig.Color = [1,1,1];
% ax = axes;
% shapeSphPl = plot3(n(:, 1), n(:,2), n(:, 3), 'r');
% shapeSphPl.LineWidth = 4;
% hold on;
% [Xsph, Ysph, Zsph] = sphere(25);
% sph = surf(0.99*Xsph, 0.99*Ysph, 0.99*Zsph);
% sph.EdgeAlpha = 0.3;
% sph.FaceAlpha = 0.5;
% axis equal
% ax.Visible = false;   

shg
disp('done');

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