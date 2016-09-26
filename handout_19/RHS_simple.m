function zdot = RHS_simple(t,z,p)
% Simple polar pendulum EOM

zdot = [z(2);-p.g/p.l*sin(z(1))];

end

