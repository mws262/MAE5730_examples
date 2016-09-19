% Bouncing ball example
p.g = -9.8;
restitution = 0.8;

tFinal = 15;
init = [10,0]';

opts.Events = @bounceEvent;

currentTime = 0;
currentZ = init;

tarray = [];
zarray = [];

for i = 1:10
    
% Time of event, z at event, index of event (not relevant with only 1
% event)
[newTs, newZs, te, ze, ie] = ode45(@RHS, [currentTime,tFinal], currentZ, opts, p);

tarray = [tarray;newTs(2:end,1)];
zarray = [zarray;newZs(2:end,:)];

if tarray(end) ~= tFinal
    currentTime = te;
    currentZ = [0;-restitution*ze(2)];
end

end

plot(tarray,zarray(:,1));
animate;