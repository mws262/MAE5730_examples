function [ triggerValue, stop, directionToCheck ] = myEvent( t,z,p )
%MYEVENT Event function for when the projectile hits the ground
%   Takes the same arguments as ODE45. Only ever called by ODE45.

triggerValue = z(2); % Stop when triggerValue == 0. ie when y == 0.
stop = true; % Kill ode45 when this occurs.
directionToCheck = -1; % We only expect y to go from positive to negative.
end

