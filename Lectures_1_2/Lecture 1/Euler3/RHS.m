function zdot = RHS( t,z,p )
% z = [x,v]
% zdot = [v,a] ( or [xdot,vdot])

x = z(1);
v = z(2);

a = -(p.k/p.m)*x;

zdot = [v,a]';

end

