function zdot = nbody_rhs(~, z, p)
% An adaptable equations of motion function for the n-body problem. The
% dimension of the input will determine the number of bodies being
% considered. All inputs should be as columns. The state ordering is:
% z = [x1, x2, x3, ..., y1, y2, y3, ..., xd1, xd2, xd3, ..., yd1, yd2,
% yd3]'

n = length(z) / 4; % Number of bodies.
% Separate out the states.
x = z(1:n);
y = z(n + 1:2 * n);
xd = z(2 * n + 1:3 * n);
yd = z(3 * n + 1:4 * n);

% Take all the distance differences between particles. Becomes an nxn
% matrix.
xdiffs = x - x';
ydiffs = y - y';
distssq = xdiffs.^2 + ydiffs.^2;
dists = sqrt(distssq);

% G * m1 * m2 / r12^3 -- We'll cancel out one of the r12 when applying the direction. 
abase = p.G * repmat(p.m, [1, n]) ./(distssq .* dists); % missing the direction itself.

xaccels = xdiffs .* abase;
yaccels = ydiffs .* abase;

% Elements on the diagonal are the effects of particles on themselves,
% which causes div by zero. 
xaccels(isnan(xaccels)) = 0;
yaccels(isnan(yaccels)) = 0;

% The columns of the result are the forces due to each of the pairwise
% interactions.
xaccels = sum(xaccels, 1)';
yaccels = sum(yaccels, 1)';

zdot = [xd; yd; xaccels; yaccels];

end