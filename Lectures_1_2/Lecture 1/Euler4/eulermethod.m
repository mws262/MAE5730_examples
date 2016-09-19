function [tarray, zarray] = eulermethod(odefun,tspan,z0,n,p)

tarray = linspace(tspan(1),tspan(2),n+1); % initialize tarray

h = tarray(2)-tarray(1); % size of time step

zarray = zeros(n+1,length(z0)); 
zarray(1,:) = z0'; % initialize zarray

for i=1:n; % Step through the time interval
    z = zarray(i,:)'; 
    t = tarray(i);
    znew = z + h*odefun(t,z,p); %THE KEY LINE!!
    zarray(i+1,:) = znew';
end

end