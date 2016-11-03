% Derive equations, simulate, and animate a spring-mass system.
% User specifies the number of masses below.
%
% Matthew Sheen

clear all; close all
%% System parameters and number of masses
numMasses = 5;
Kvals = 100*ones(numMasses+1,1); % Spring constants
Mvals = ones(numMasses,1); % Masses
Lvals = ones(numMasses+1,1); % Rest lengths
wall1Pos = 0; % Lefthand wall position
wall2Pos = sum(Lvals); % Right-hand wall position

tend = 15;
tfactor = 2; % Animation time scaling factor

%% Symbolic derivation for the number of masses specified 
m = sym('m',[numMasses,1]); % Array of masses
x = sym('x',[numMasses,1]); % Array of mass positions (a state variable)
k = sym('k',[numMasses+1,1]); % Array of spring constants
l = sym('l',[numMasses+1,1]); % Array of spring rest lengths

springForces = (k.*([x;wall2Pos] - [wall1Pos;x] - l)); % Forces exerted by each spring

massForces = springForces(2:end) - springForces(1:end-1); % Each mass gets the force from the spring ahead of it and gets pulled back by the spring behind it.

% Mxddot + Kx = A is the form.
Kmat = -jacobian(massForces,x); % Isolate the terms multiplying x's and move to the other side of the equation.
Mmat = diag(m);
Amat = simplify(massForces - jacobian(massForces,x)*x); % Whatever leftover terms on the force side get collected into this term.

% Substitute a bunch of values in
Kmatnumeric = subs(Kmat,k,Kvals);
Mmatnumeric = subs(Mmat,m,Mvals);
Amatnumeric = subs(Amat,[k;l],[Kvals;Lvals]);

% Convert from a 'symbolic' matrix to a numeric one
p.Kmat = double(Kmatnumeric);
p.Mmat = double(Mmatnumeric);
p.Amat = double(Amatnumeric);


%% Simulate

[evec,ev] = eig(p.Mmat\p.Kmat); % Just for fun, get some normal modes

initX = cumsum(Lvals(1:end-1)); % Each mass is at rest length.
initV = evec(:,2); % Change index to get a different mode. %zeros(size(initX));

opts = odeset;
[tarray,zarray] = ode45(@RHS,[0,tend],[initX; initV],opts,p);

%% Animate
figure;
hold on
massPlot = plot(zeros(numMasses,1),zeros(numMasses,1),'.b','MarkerSize',20);
axis([0 sum(Lvals) -0.5 0.5]);

currentTime = 0;
tic;

while currentTime*tfactor < tarray(end)
    zstar = interp1(tarray,zarray,currentTime*tfactor);
    massPlot.XData = zstar(1:numMasses);
    massPlot.YData = zeros(1,numMasses);
    drawnow;
    currentTime = toc;
end

