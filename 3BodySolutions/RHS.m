function zdot = RHS( t,z,p )

% Positions are z(1:6), velocities are z(7:12)

a = accel(p.G,p.m1,p.m2,p.m3,z(1),z(3),z(5),z(2),z(4),z(6));

zdot = [z(7:12);a];

end

