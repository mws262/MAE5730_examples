function updateSolvePlots( zarray,plots )
n = length(plots)/2;

for i = 1:n
    plots{2 * i - 1}.XData = zarray(end, i);
    plots{2 * i - 1}.YData = zarray(end, i + n);
    plots{2 * i}.XData = zarray(:,i);
    plots{2 * i}.YData = zarray(:,i + n);
    
end
drawnow;

end

