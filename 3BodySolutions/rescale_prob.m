close all;
for i = 1:30
[tend,inits] = getSolutionNum(i);
p.G = 1;
p.m1 = 1;
p.m2 = 1;
p.m3 = 1;

% First find the initial COM of the system and subtract it off. Assuming
% equal masses.
COM = [sum(inits([1,3,5])), sum(inits([2,4,6]))]/3;
inits([1,3,5]) = inits([1,3,5]) - COM(1);
inits([2,4,6]) = inits([2,4,6]) - COM(2);

% Solver/integration options
p.odeOpts = odeset;
p.odeOpts.RelTol = 1e-10;
p.odeOpts.AbsTol = 1e-10;
[tarray,zarray] = ode45(@RHS,[0,tend],inits,p.odeOpts,p);
% plot3body(zarray)

% Find max pt from the origin!
sq = zarray .* zarray;
mag = sqrt(sq(:, [1,3,5]) + sq(:, [2,4,6]));
[partMagMax, partIdxMax] = max(mag, [], 1);

[totalMagMax, totalIdxMax] = max(partMagMax);

idxMaxOverall = partIdxMax(totalIdxMax);
timeMax = tarray(idxMaxOverall);
stateMax = zarray(idxMaxOverall, :);

scaleFactor = 1/totalMagMax;

velScale = totalMagMax^(-3/2);

stateRescale = [stateMax(1:6) * scaleFactor, stateMax(7:end) / sqrt(scaleFactor)];
tendScale = tend * velScale;
[tarray,zarray] = ode45(@RHS,[0,tendScale],stateRescale,p.odeOpts,p);
plot3body(zarray);

hold on;
thCirc = linspace(0, 2 * pi, 200);
plot(cos(thCirc), sin(thCirc));

x1 = stateRescale(1);
y1 = stateRescale(2);
x2 = stateRescale(3);
y2 = stateRescale(4);
x3 = stateRescale(5);
y3 = stateRescale(6);

xd1 = stateRescale(7);
yd1 = stateRescale(8);
xd2 = stateRescale(9);
yd2 = stateRescale(10);
xd3 = stateRescale(11);
yd3 = stateRescale(12);

dist12 = sqrt((x1 - x2)^2 + (y1 - y2)^2);
dist13 = sqrt((x1 - x3)^2 + (y1 - y3)^2);
dist23 = sqrt((x3 - x2)^2 + (y3 - y2)^2);

pot = -(1/dist12 + 1/dist13 + 1/dist23);

v1 = sqrt(xd1^2 + yd1^2);
v2 = sqrt(xd2^2 + yd2^2);
v3 = sqrt(xd3^2 + yd3^2);

ke = 1/2 * (v1^2 + v2^2 + v3^2);

pot + ke


end