function zdot = RHS( t,z,p )
x = z(1:length(z)/2);
xdot = z(length(z)/2+1:end);

xddot = p.Mmat\(p.Amat - p.Kmat*x);

zdot = [xdot;xddot];
end

