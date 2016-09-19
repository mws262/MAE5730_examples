function pl = initSolvePlots(varargin)
if length(varargin) == 3
    subplot(varargin{1},varargin{2},varargin{3});
else
    fig = figure;
    fig.Position = [100,100,800,800];
end
hold on
g1 = plot(0,0,'.','MarkerSize',30); % Could use comet instead
g1tail = plot(0,'--','LineWidth',2,'Color',[0.8*g1.Color,0.5]);
g2 = plot(0,'.','MarkerSize',30);
g2tail = plot(0,'--','LineWidth',2,'Color',[0.8*g2.Color,0.5]);
g3 = plot(0,'.','MarkerSize',30);
g3tail = plot(0,0,'--','LineWidth',2,'Color',[0.8*g3.Color,0.5]);
hold off
axis([-2,2,-2,2]);
pl = {g1,g1tail,g2,g2tail,g3,g3tail};

end

