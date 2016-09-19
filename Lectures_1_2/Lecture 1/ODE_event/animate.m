% Animate the bouncing ball (the "good" way)

f = figure;

hold on
ballPath = plot(tarray,zarray(:,1));
ball = plot(0,0,'.k','MarkerSize',40);
hold on

axis([0 tFinal 0 init(1)]);

tic % Start the clock
animTime = 0;

while animTime < tarray(end)
   
    animZ = interp1(tarray,zarray(:,1),animTime);
    
    
    ball.XData = animTime;
    ball.YData = animZ;
   
    drawnow;
    
    animTime = toc;
   
end
