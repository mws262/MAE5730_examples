G = 1;
n = 5;

x = sym('x', [n, 1], 'real');
y = sym('y', [n, 1], 'real');

xdot = sym('xdot', [n, 1], 'real');
ydot = sym('ydot', [n, 1], 'real');

m = sym('m', [n, 1], 'positive');
%m = ones([n, 1]);

p = [x, y];

xdiffs = x - x';
ydiffs = y - y';
distssq = xdiffs.^2 + ydiffs.^2;
dists = sqrt(distssq);

abase = G * repmat(m, [1, n]) ./(distssq .* dists); % missing the direction itself.

xaccels = xdiffs .* abase;
yaccels = ydiffs .* abase;

xaccels(isnan(xaccels)) = 0;

yaccels(isnan(yaccels)) = 0;

xaccels = sum(xaccels, 1);
yaccels = sum(yaccels, 1);




