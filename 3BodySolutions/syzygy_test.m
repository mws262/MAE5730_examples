% Find sygygies.
[tend, inits] = gen3BodyExtra(2);

p.G = 1;
p.m = ones(3, 1);
opt = odeset('RelTol', 1e-10, 'AbsTol', 1e-10);
opt.Events = @syzygy_evnt;
[~, zarray, te, ye, ie] = ode45(@nbody_rhs, [0,  tend], inits, opt, p);
