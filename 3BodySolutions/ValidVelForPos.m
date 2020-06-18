function ValidVelForPos
x2 = -0.75;
y2 = 0.1;
p.G = 1;
p.m1 = 1;
p.m2 = 1;
p.m3 = 1;
tmax = 20;
opt = odeset;
opt.Events = @evnt;
opt.RelTol = 1e-2;
opt.AbsTol = 1e-2
count = 1;
warning('off','all')
% 
fig = figure;
pl = plot(0,0, '.', 'MarkerSize', 5);
[y1g, x2g] = ndgrid(linspace(-1, -1,100),  linspace(-1, 1, 100));
for k = 1:size(y1g, 1)
    for j = 1:size(y1g, 2)
        res = doICsStayValid(y1g(k,j), x2g(k,j), 0.8);
        if res == 0
            disp('pt');
            pl.XData(end+1) = y1g(k,j);
            pl.YData(end+1) = x2g(k,j);
            drawnow;
        end
    end
end

% fimp = fimplicit(@(y1, x2)doICsStayValid(y1, x2, 0.2), [-0.4, -0.26, -0.18, -0.1], 'MeshDensity', 50); %, 0.3, 0.5], 'MeshDensity', 50); %) 

% fimp = fimplicit3(@doICsStayValid, [-0.4, -0.26, -0.18, 0, 0.3, 0.5], 'MeshDensity', 50); %) 
disp('done');
    function res = doICsStayValid(y1dot, x2dot, y2dot)
        res = zeros(1, length(y1dot));
        for i = 1:1
            if isVelICValid(y1dot(i), x2dot(i), y2dot(i))
                [fullICs, minICs] = makeFullICs(x2, y2, y1dot(i), x2dot(i), y2dot(i), p);

                [t, z, TE,YE,IE] = ode45(@RHS, [0, tmax], fullICs, opt, p);

                res(i) = tmax - t(end);
                if res(i) < 0.001
                    fullICs
                    res(i)
                end
            else
               res(i) = NaN;
            end
        end
%         count = count+1;
%         if count % 100 == 0
%            disp(count); 
%         end
    end

    function [val, isterm, dir] = evnt(t,z,p) 
        val = [z(1)^2 + z(2)^2 - 1.1;
            z(3)^2 + z(4)^2 - 1;
            z(5)^2 + z(6)^2 - 1];
        isterm = [1; 1; 1];
        dir = [0; 0; 0];
    end
end