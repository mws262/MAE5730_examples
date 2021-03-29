function [val, isterm, dir] = syzygy_evnt(t,z,p)


% val =  z(1:length(z)/2).^2 - 24; 
% isterm = ones(length(z)/2,1); 
% dir = ones(length(z)/2,1);


x  = z(1:3);
y = z(4:6);

xd = z(7:9);
yd = z(10:12);

diff12 = [x(2) - x(1), y(2) - y(1)];
diff13 = [x(3) - x(1), y(3) - y(1)];

mag12 = norm(diff12);
mag13 = norm(diff13);

% Dot product between relative positions should be 1 or -1 at sygygies.
inlineCondition = (dot(diff12, diff13)/mag12/mag13)^2 - 1 + 1e-4

dot([xd(1), yd(1)], diff12)
dot([xd(2), yd(2)], diff12)
dot([xd(3), yd(3)], diff12)

val = inlineCondition;
isterm = 0;
dir = 1;
end