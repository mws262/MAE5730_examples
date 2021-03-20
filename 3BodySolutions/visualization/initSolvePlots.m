function pl = initSolvePlots(n)

    fig = figure;
    fig.Position = [100,100,800,800];

pl = {};
hold on;
for i = 1:n
    g = plot(0,0,'.','MarkerSize',30); % Could use comet instead
    pl{end+1} = g;
    pl{end+1}  = plot(0,'-','LineWidth',1,'Color',[0.8*g.Color,0.5]);
    hold on
end

axis([-2,2,-2,2]);
axis equal;
hold off;

end

