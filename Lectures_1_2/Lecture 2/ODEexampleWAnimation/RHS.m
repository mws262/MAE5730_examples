function zdot = RHS(t,z,p)

th = z(1);
thdot = z(2);

zdot = [thdot; -p.g/p.l*sin(th)];


end