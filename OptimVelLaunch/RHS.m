function zdot = RHS( t,z,p )
% Dynamics for projectile with quadratic drag.

jhat = [ 0 1]';

r = z(1:2);
v = z(3:4);

rdot = v;

vdot = (- p.c *norm(v)*v )/p.m  - p.g*jhat;

zdot = [rdot;vdot];

end

