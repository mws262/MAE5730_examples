function fig = plot3body(zarrayguess,varargin)

fig = figure;
fig.Position = [100,100,1000,1000];

hold on
g1 = plot(zarrayguess(end,1),zarrayguess(end,2),'.','MarkerSize',30); % Could use comet instead
g1tail = plot(zarrayguess(:,1),zarrayguess(:,2),'--','LineWidth',2,'Color',[0.8*g1.Color,0.5]);
g2 = plot(zarrayguess(end,3),zarrayguess(end,4),'.','MarkerSize',30);
g2tail = plot(zarrayguess(:,3),zarrayguess(:,4),'--','LineWidth',2,'Color',[0.8*g2.Color,0.5]);
g3 = plot(zarrayguess(end,5),zarrayguess(end,6),'.','MarkerSize',30);
g3tail = plot(zarrayguess(:,5),zarrayguess(:,6),'--','LineWidth',2,'Color',[0.8*g3.Color,0.5]);

if size(varargin) > 0
    zarray = varargin{1};
    p1 = plot(zarray(end,1),zarray(end,2),'.','MarkerSize',50,'Color',g1.Color); % Could use comet instead
    p1tail = plot(zarray(:,1),zarray(:,2),'--','LineWidth',3,'Color',0.8*g1.Color);
    p2 = plot(zarray(end,3),zarray(end,4),'.','MarkerSize',50,'Color',g2.Color);
    p2tail = plot(zarray(:,3),zarray(:,4),'--','LineWidth',3,'Color',0.8*g2.Color);
    p3 = plot(zarray(end,5),zarray(end,6),'.','MarkerSize',50,'Color',g3.Color);
    p3tail = plot(zarray(:,5),zarray(:,6),'--','LineWidth',3,'Color',0.8*g3.Color);
end

hold off

axis([-1.8,1.8,-1.8,1.8]);

end

