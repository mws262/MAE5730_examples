% lt = linspace(0, 4/3, 100)
% res = zeros(100, 2);
% for i = 1:100
% 
% fn = @(y)(deal(y(1).^2 + y(1) * y(2) + y(2)^2 - (4/3- lt(i).^2), 0))
% res(i, :) = fmincon(@(y)(y(2)), [2/sqrt(3), -0.577], [], [], [], [], [0,-10], [0,10], fn)
% end
lt = linspace(0, 4/3, 100)

% for i = 1:100
% pl = fimplicit(@(y1,y2)(y1.^2 + y1 .* y2 + y2.^2 - (4/3 - lt(i).^2)), 'MeshDensity', 501);
% pl.ZData = lt(i) * ones(size(pl.XData));
% drawnow;
% end
f= fimplicit3(@(y1,y2,x2)(y1.^2 + y1 .* y2 + y2.^2 + x2.^2 - 4/3), [0, 4/3, -4/3, 4/3, -1.2, 1.2])
