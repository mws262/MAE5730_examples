function fig = animate( tarray,zarray,p )
% Given tarray and zarray from ode45, animate the 3-body problem.

fig = figure;
fig.Position = [1000,100,1400,1400];

hold on
p1 = plot(0,0,'.','MarkerSize',50); % Could use comet instead
p1tail = plot(0,0,'--','LineWidth',2,'Color',0.8*p1.Color);
p2 = plot(0,0,'.','MarkerSize',50);
p2tail = plot(0,0,'--','LineWidth',2,'Color',0.8*p2.Color);
p3 = plot(0,0,'.','MarkerSize',50);
p3tail = plot(0,0,'--','LineWidth',2,'Color',0.8*p3.Color);
hold off

axis([-2.2,2.2,-2.2,2.2]);

currTime = 0;
tic;

while currTime*p.tfactor < tarray(end)
    if ~ishandle(fig)
        break;
    end
    
    zcurr = interp1(tarray,zarray,currTime*p.tfactor);
    
    % Update the dot positions
    p1.XData = zcurr(1);
    p1.YData = zcurr(2);
    
    p2.XData = zcurr(3);
    p2.YData = zcurr(4);
    
    p3.XData = zcurr(5);
    p3.YData = zcurr(6);
    
    % Update the tails (not bothering with interpolation, just all points
    % before this)
    tind = find(tarray<currTime*p.tfactor,1,'last');
    
    p1tail.XData = zarray(1:tind,1);
    p1tail.YData = zarray(1:tind,2);
    p2tail.XData = zarray(1:tind,3);
    p2tail.YData = zarray(1:tind,4);
    p3tail.XData = zarray(1:tind,5);
    p3tail.YData = zarray(1:tind,6);
    
    drawnow;
    
    currTime = currTime + 0.01; %toc;
end
end

