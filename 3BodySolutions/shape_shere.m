solutionNumber = 7; % Which solution would you like to view?

%%% Set up initial conditions %%%
% State vector structure:
% [x1,y1,x2,y2,...,vx1,vy1,vx2,...]
%
% initPos = 0.4*[1,0, -0.5,sqrt(3)/2, -0.5,-sqrt(3)/2] + rand(1,6)-0.5;
% initVel = 0.75*[0,1, -sqrt(3)/2,-0.5,  sqrt(3)/2,-0.5]+ rand(1,6)-0.5;
% tend = 8;
% inits = [initPos,initVel];
solutions = [4, 7, 9, 10, 14, 15];
views = [  -17.1916   11.5279;
    -88, 15;
     -124.5936    9.2583;
  -65.9660    0.2562;
   -124.4100    5.4477;
 -118.4113    4.5837];
     
for i = 1:length(solutions)
    [tend,inits] = getSolutionNum(solutions(i)); % This gets one of my previously-found solutions. You can try other things as well.
    
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
    
    
    [tarrayguess,zarray] = ode45(@RHS,[0, 1.0 * tend],inits,p.odeOpts,p);
    
    p1 = zarray(:, 1:2);
    p2 = zarray(:, 3:4);
    p3 = zarray(:, 5:6);
    
    rho = 1/sqrt(2) * (p1 - p2);
    lambda = 1/sqrt(6) * (p1 + p2 - 2*p3);
    rho_magsq = sum(rho.^2, 2);
    lambda_magsq = sum(lambda.^2, 2);
    
    Rsq = rho_magsq + lambda_magsq;
    
    n = [-2 * dot(rho, lambda, 2)./Rsq, (lambda_magsq - rho_magsq)./Rsq, sum(2 * cross([rho, zeros(size(rho,1), 1)], [lambda, zeros(size(rho,1), 1)]), 2)./Rsq];
    cool
    close all;
    
    fig = figure;
    fig.Color = [1,1,1];
    fig.Position = [100, 100, 800, 800];
    ax = axes;
    % shapeSphPl = plot3(n(:, 1), n(:,2), n(:, 3), 'r');
    % shapeSphPl.LineWidth = 2;
    
    % colormap spring
    map = copper;
    map = [map; flipud(map)];
    map = [map(ceil(size(map,1)/5):end, :); map(1:floor(size(map, 1)/5), :)];
    colormap(gca, map);
    offset = 0.0
    col = linspace(0 + offset, 1 + offset, size(n, 1));
    %  col = sin(col); 2
    
    surface([n(:, 1)'; n(:, 1)'],[n(:,2)'; n(:,2)'],[n(:,3)'; n(:,3)'],[col; col],...
        'facecol','no',...
        'edgecol','interp',...
        'LineWidth', 1.8);
    
    hold on;
    [Xsph, Ysph, Zsph] = sphere(20);
    sph = surf(0.998*Xsph, 0.998*Ysph, 0.998*Zsph,  0.0 * Zsph + 0.5);
    sph.EdgeAlpha = 0.2;
    sph.FaceAlpha = 0.6;
    sph.FaceColor = [0.8, 0.88, 1];
    axis equal
    ax.Visible = false;
    
    ptX = [0, 1.5/sqrt(3), -1.5/sqrt(3)];
    ptY = [1, -0.5, -0.5];
    ptZ = [0, 0, 0];
    plpt = plot3(ptX * 0.99, ptY * 0.99, ptZ * 0.99, 'rx', 'MarkerSize', 22, 'LineWidth', 3.5);
    plot3([0, 1.5 * ptX(1)], [0, 1.5 * ptY(1)], [0, 1.5 * ptZ(1)], '--k', 'LineWidth', 0.5);
    plot3([0, 1.5 * ptX(2)], [0, 1.5 * ptY(2)], [0, 1.5 * ptZ(2)], '--k', 'LineWidth', 0.5);
    plot3([0, 1.5 * ptX(3)], [0, 1.5 * ptY(3)], [0, 1.5 * ptZ(3)], '--k', 'LineWidth', 0.5);
    ax.View = views(i, :);
    camva(4.5)
    camtarget([0,0,0])
    save2pdf(['shapesph', num2str(i)], fig, 300);
    
end
% ax.CameraPosition = [  -23.3368   -0.4133    4.3377];
% ax.CameraTarget = [0, 0.25, 0];

% Oops arrows are kind of useless due to the orbits being reversible.
% ptDiff = diff(n);
% pt_spacing = sqrt(sum(ptDiff.*ptDiff, 2));
% arrowSpacing = 1;
% distCounter = 0;
% arrowScaling = 0.04;
% arrowCoordsX = arrowScaling * [0, -3, -2.5, -3, 0]';
% arrowCoordsY = arrowScaling * [0, 0.6, 0, -0.6, 0]';
%
% for i = 1:length(pt_spacing)
%    distCounter = distCounter + pt_spacing(i);
%    if distCounter >= arrowSpacing
%
%       direction = ptDiff(i, :);
%       dirTangent = direction / norm(direction); % Points along line path tangent to sphere.
%
%       ptLoc = n(i, :); % Points outward from sphere.
%       dirOrth = cross(dirTangent, ptLoc); % Tangent to sphere perpendicular to dirTangent.
%
%       arrowCoordsTransformed = arrowCoordsX * dirTangent + arrowCoordsY * dirOrth + ptLoc;
%       patch(arrowCoordsTransformed(:, 1), arrowCoordsTransformed(:, 2), arrowCoordsTransformed(:, 3), 'r');
%       distCounter = 0;
%    end
% end