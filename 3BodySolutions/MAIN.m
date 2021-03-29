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
p.odeOpts.RelTol = 1e-6;
p.odeOpts.AbsTol = 1e-6;

p.fsolveOpts = optimset('fsolve');
p.fsolveOpts.Algorithm = 'levenberg-marquardt'; % fsolve will default to this anyway after a few seconds and a warning message.
p.fsolveOpts.TolX = 1e-6;
p.fsolveOpts.TolFun = 1e-6;

p.fsolveOpts.MaxFunEvals = 1000000;
p.fsolveOpts.MaxIterations = 1e4;
pf.fsolveOpts.FunctionTolerance = 1e-6;
p.fsolveOpts.StepTolerance = 1e-6;
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
n = 5
p.G = 1;
p.m = ones(n+1, 1);
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
xs = cos(ang) * 0.8 + (rand(n,1) - 0.5) * 0.2;
ys = sin(ang) * 0.8 + (rand(n,1) - 0.5) * 0.2;
xd = -sin(ang).*(rand(n,1)-0.5)*1 + cos(ang) .* (rand(n,1) - 0.5) * 0.4;%(rand(n,1) - 0.5) * 1;%-sin(ang) .* (rand(n,1) - 0.5) * 1 + cos(ang) .* (rand(n,1) - 0.5) * 0.3;
yd = cos(ang) .*(rand(n,1)-0.5)*1+  sin(ang) .* (rand(n,1) - 0.5) * 0.4; %(rand(n,1) - 0.5) * 1;%cos(ang) .* (rand(n,1) - 0.5) * 1 + sin(ang) .* (rand(n,1) - 0.5) * 0.3;
t = 2 +(rand() - 0.5) * 4;
guess = [xs; ys; xd; yd; t];
% guess =    [ 0.950795063968102
%             0.544385642003968
%             -0.633451356772128
%             -0.796908228678538
%             -0.064821120521404
%             rand-0.5
%             -0.418347498938976
%             0.723114686929297
%             0.690136719398253
%             -0.363408902318607
%             -0.631495005069967
%             rand-0.5
%             0.632027154716209
%             -0.950808024410764
%             -1.151918413383543
%             1.218448607565933
%             0.252250675512165
%             rand-0.5
%             1.178651051459998
%             0.847959626169099
%             -0.750617599059847
%             -0.914328799988811
%             -0.361664278580438
%             rand-0.5
%             4.876615128287713 + rand - 0.5];
%         guess = guess + (rand(25,1) - 0.5) * 0.1;
            
% p.x1 = 0.138905211470271;
% p.y1 = 0.532372995229495;
% guess = [
%  -0.208018307891517
%    0.196130973685997
%   -0.260451741351707
%   -0.199884308688983
%    0.053069339930936
%    0.149108515604518
%    0.417275748636172
%   -0.806913892646630
%    2.170800108920224
%   -1.139243913710775
%   -2.409682783481383
%    0.204629313278135
%    0.189754885405225
%   -0.427682129057363
%    2.508837439236679
%    1.964544883552872
%   -4.246276047195298
%   -0.158226979705131
%    0.628464546769875
% ] %+ (rand(19,1) - 0.5) * 0.002;
% guess = solution
% guess = [    1.835250525944939
%    0.953957979481942
%   -0.581544745522953
%   -0.596288109102064
%    1.316027038909812
%   -1.027634387765892
%    0.844924577139499
%   -1.746280212226982
%   -1.319661915052643
%    1.562043138177679
%   -0.275426442021154
%    0.426151232505249
%   -1.379917105658983
%    1.078527279631986
%   -0.867968952220059
%    0.050799523748053
%    1.326507293686833
%    0.513618003702990
%   -0.675600128031694
%   -1.599538345434582
%    2.584792582146034] + (rand(21,1) + 0.5) * 0.5;
% load('5body_legit.mat', 'solution');
% 
% guess = solution + (rand(length(solution), 1) - 0.5) * 0.8;
% solution(3:3:end) = [];
% solution(3:3:end) = [];

guess = solution
%  guess = [ 
%    0.231207525091770
%    0.748076937499224
%    0.513713568169772
%    2.172193384661411
%    2.458450131975315
%    1.810083811060802
%   -0.277383841678222
%    0.238634483924694
%    0.038752096413156
%   -1.605265058889184
%    0.921053093240326
%    0.684212070473373
%    3.282139429420875 ]% + (rand(13,1) - 0.5) * 0.001
% guess(1:3) = guess(1:3) - mean(guess(1:3));
% guess(4:6) = guess(4:6) - mean(guess(4:6));
% 
% guess(7:9) = guess(7:9) - mean15(guess(7:9));
% guess(10:12) = guess(10:12) - mean(guess(10:12));

% guess = [
% 
%    0.920147352166639
%    0.055431727046081
%   -1.248495987565317
%    0.990874678534295
%    0.279864545552215
%   -0.908953130880876
%    0.349336967219493
%    0.730434769382831
%   -1.251558455452534
%    0.301166099498302
%   -0.791192765700813
%   -0.716411475490073
%   -1.894059488909541
%    0.407122760659828
%    1.657607313633092
%    1.688307059879823
%    1.550154820653592
%    0.365141914776893
%   -1.354201084141323
%   -1.588298918179439
%    1.305533630208551] + (rand(21,1) - 0.5) * 0.1
guess = [ 
  -0.404977403847436
  -0.276755998918042
  -0.317542576537033
  -0.445570086346064
   1.095984566504395
   0.266072871356591
  -0.279172901903940
   0.305956783055326
   0.050178771864351
  -1.220146515499158
   2.469474496108509
   0.263528227580372
  -4.078615797231853
   1.712932262449987
  -0.214497829995114
   0.824429388386270
   1.628823889805647
   0.476917517263377
  -4.036049269223803
   0.340044595478532
   2.318058013752618
]+ (rand(21,1) - 0.5) * 0.1;

try    
    defect = toSolve(guess,p,solvePlots);
    def = defect * defect'
%     if def > 100
%         continue;
%     end
    disp('trying this one');
[solution, fval, flag] = fsolve(@(x)(toSolve(x,p,solvePlots)),guess,p.fsolveOpts)

if flag > 0
   disp('WE GOT ONE'); 
   save(['sol',num2str(i)]);
elseif sum(abs(fval)) < 0.2 || flag == 0
      disp('maybe'); 
   save(['maybe',num2str(i)]);  
end
catch MEException
    disp('ere');
%      throw(MEException)
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
