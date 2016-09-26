function zdot = RHS_derived(t,z,p)
% Uses the symbolically derived ODE for y acceleration.

y = z(1);
ydot = z(2);

yaccel = ydotdot(p.g,p.l,y,ydot); % See deriver.m for details.

zdot = [ydot; yaccel];

end