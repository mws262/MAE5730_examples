solutionNumber = 4; % Which solution would you like to view?

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


[tarrayguess,zarray] = ode45(@RHS,[0, 2 * tend],inits,p.odeOpts,p);

p1 = zarray(:, 1:2);
p2 = zarray(:, 3:4);
p3 = zarray(:, 5:6);

rho = 1/sqrt(2) * (p1 - p2);
lambda = 1/sqrt(6) * (p1 + p2 - 2*p3);
rho_magsq = sum(rho.^2, 2);
lambda_magsq = sum(lambda.^2, 2);

Rsq = rho_magsq + lambda_magsq;

n = [-2 * dot(rho, lambda, 2)./Rsq, (lambda_magsq - rho_magsq)./Rsq, sum(2 * cross([rho, zeros(size(rho,1), 1)], [lambda, zeros(size(rho,1), 1)]), 2)./Rsq];

close all;

fig = figure;
fig.Color = [1,1,1];
ax = axes;
shapeSphPl = plot3(n(:, 1), n(:,2), n(:, 3), 'r');
shapeSphPl.LineWidth = 2;
hold on;
[Xsph, Ysph, Zsph] = sphere(25);
sph = surf(0.99*Xsph, 0.99*Ysph, 0.99*Zsph);
sph.EdgeAlpha = 0.3;
sph.FaceAlpha = 0.5;
axis equal
ax.Visible = false;  

ptDiff = diff(n);
pt_spacing = sqrt(sum(ptDiff.*ptDiff, 2));
arrowSpacing = 1;
distCounter = 0;
arrowScaling = 0.04;
arrowCoordsX = arrowScaling * [0, -3, -2.5, -3, 0]';
arrowCoordsY = arrowScaling * [0, 0.6, 0, -0.6, 0]';

for i = 1:length(pt_spacing)
   distCounter = distCounter + pt_spacing(i);
   if distCounter >= arrowSpacing
      
      direction = ptDiff(i, :);
      dirTangent = direction / norm(direction); % Points along line path tangent to sphere.
      
      ptLoc = n(i, :); % Points outward from sphere.
      dirOrth = cross(dirTangent, ptLoc); % Tangent to sphere perpendicular to dirTangent.
      
      arrowCoordsTransformed = arrowCoordsX * dirTangent + arrowCoordsY * dirOrth + ptLoc;
      patch(arrowCoordsTransformed(:, 1), arrowCoordsTransformed(:, 2), arrowCoordsTransformed(:, 3), 'r');
      distCounter = 0; 
   end
end