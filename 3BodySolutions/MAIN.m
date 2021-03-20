% 3-body problem periodic solver.
% You can look for new solutions or re-run the ones I've found.
% My previous solutions can be found in getSolutionNum.m.
%
% Matt Sheen

close all;
addpath visualization;

%%% CHANGE SOLUTIONS HERE %%%
solutionNumber = 3; % Which solution would you like to view?
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
p.odeOpts.RelTol = 1e-5;
p.odeOpts.AbsTol = 1e-5;

p.fsolveOpts = optimset('fsolve');
p.fsolveOpts.Algorithm = 'levenberg-marquardt'; % fsolve will default to this anyway after a few seconds and a warning message.
p.fsolveOpts.TolX = 1e-4;
p.fsolveOpts.TolX = 1e-4;

p.fsolveOpts.MaxFunEvals = 2500;
pf.fsolveOpts.FunctionTolerance = 1e-6;
p.fsolveOpts.StepTolerance = 1e-10;
p.fsolveOpts.OptimalityTolerance = 1e-6;
p.fsolveOpts.Display = 'iter';



%  n = 3;
x = (rand(1, 1) - 0.5) * 1;
y = (rand(1, 1) - 0.5) * 1;
xd = (rand(1, 1) - 0.5) * 1;
yd = (rand(1, 1) - 0.5) * 1;
p.tend = tend;
inits = inits';
inits = [inits(1:2:length(inits)/2); x; inits( 2:2:length(inits)/2); y;
    inits(length(inits)/2 + 1:2:end); xd; inits(length(inits)/2 + 2:2:end);yd];
    guess = [inits];
    
%     guess = [  -1.1000
%     1.5979
%     0.3106
%    -0.4328
%     1.2884
%    -1.1839
%     0.9633
%    -0.9944
%    -0.8291
%    -0.2879
%     0.3331
%     0.7838
%    -0.0551
%    -0.4717
%     0.4178
%     0.1092];
% p.tend = p.tend * 2;
% Run the initial guess.
% [tarrayguess,zarr] = ode45(@nbody_rhs,[0,periodsToRun*tend],inits,p.odeOpts,p);

% tend = 3

%  guess = [
%  -0.4386
%     1.1650
%    -0.3351
%    -0.2468
%    -0.5998
%    -0.4266
%     0.8938
%     0.1353
%     0.3185
%     0.6135
%     0.2477
%    -1.1801
%    -1.1390
%    -0.1153
%     0.1085% n = length(soln) - 1; % minus period.
% x = z(1:n/4);
% y = z(n/4 + 1:n/2);
% xd = z(n/2 + 1:3*n/4);
% yd = z(3*n/4 + 1:n);
% 
% init = [x;-sum(x);y;-sum(y);xd;-sum(xd);yd;-sum(yd)];

%     1.1452];
%+ (rand(17, 1) - 0.5) * 0.00
% guess = [    3.8208
n = 4
if p.showSolverGuesses
    solvePlots = initSolvePlots(n + 1); % We can show the progress of the solutions as fsolve is going.
end
p.odeOpts.Events = @evn;
for i = 1:1000000
%     x = (rand(n, 1) - 0.5) * 1;
% % x(end) = -sum(x(1:end-1));
% y = (rand(n, 1) - 0.5) * 1;
% % y(end) = -sum(y(1:end-1));
% xd = (rand(n, 1) - 0.5) * 3;
% % xd(end) = -sum(xd(1:end-1));
% yd = (rand(n, 1) - 0.5) * 3;
% % yd(end) = -sum(yd(1:end-1));
% guess = [x; y; xd; yd];
% tend = 4;
% 
% guess = [guess;tend];

% guess = [  
%     0.4617
%    -0.9269
%     0.3175
%     0.7564
%     0.2235
%     0.5309
%     (rand() - 0.5) * 0.5
%     (rand() - 0.5) * 0.5
%     0.2910
%     0.0098
%    -0.8069
%    -2.0647
%     0.5567
%     1.6264
%     (rand() - 0.5) * 1
%     (rand() - 0.5) * 1
%     3.7033
% ] + (rand(17,1) - 0.5) * 0.5;
% guess(end) = guess(end) + (rand() - 0.5) * 1;


ang = linspace(0, 2 * pi, n+2)';
ang = ang(1:end-2);
xs = cos(ang) + (rand(n,1) - 0.5) * 1.0;
ys = sin(ang) + (rand(n,1) - 0.5) * 1.0;
xd = -sin(ang) .* (rand(n,1) - 0.5) * 1.5 + cos(ang) .* (rand(n,1) - 0.5) * 0.3;
yd = cos(ang) .* (rand(n,1) - 0.5) * 1.5 + sin(ang) .* (rand(n,1) - 0.5) * 0.3;
t = 3 + (rand() - 0.5) * 2;
guess = [xs; ys; xd; yd; t];
load('5body_legit.mat', 'solution');

guess = solution + (rand(length(solution), 1) - 0.5) * 0.8;
% guess = solution
% guess = [    0.9634
%     0.0084
%    -0.9582
%    -0.6006
%     0.3042
%     1.0103
%     0.3202
%    -0.8124
%     0.2774
%     0.5922
%     0.0886
%    -0.5375
%    -0.5326
%     0.0992
%     0.5939
%     0.2678
%     2.3791]

try
[solution, fval, flag] = fsolve(@(x)(toSolve(x,p,solvePlots)),guess,p.fsolveOpts)

if flag > 0
   disp('WE GOT ONE'); 
   save(['sol',num2str(i)]);
elseif fval < 0.05 || flag == 0
      disp('maybe'); 
   save(['maybe',num2str(i)]);  
end
catch MEException
    disp('ere');
%     throw(MEException)
end
end

% p.odeOpts.RelTol = 1e-10;
% p.odeOpts.AbsTol = 1e-10;
%     [tarray,zarray] = ode15s(@nbody_rhs,[0,solution(1)*3],solution(2:end),p.odeOpts,p);
% 
%     figure;
%     for i = 1:n
%        plot(zarray(:,i), zarray(:, i + n)); 
%        hold on;
%     end
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
