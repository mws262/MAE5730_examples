close all;
xcircle = linspace(-1, 1, 100);
ycircleUp = sqrt(1 - xcircle.^2);
ycircleDown = -sqrt(1 - xcircle.^2);

col = lines(5);

fig = figure;
fig.Color = [1,1,1]
ax = axes; 


hold on;

% Mass 1 fixed.

plot(xcircle, ycircleDown, 'k--', 'Color', [0, 0, 0, 0.5]);
plot(xcircle, ycircleUp, 'k--', 'Color', [0, 0, 0, 0.5]);
plot(1, 0, '.', 'MarkerSize', 50, 'Color', col(1, :));

pt2anglerange = linspace(-pi/3, pi/3, 100);
pt2fill = fill(-cos(pt2anglerange), sin(pt2anglerange), col(5, :));
pt3fill = fill(cos(pt2anglerange) - 1, sin(pt2anglerange), col(3, :));

pt2fill.FaceAlpha = 0.6;
pt2fill.LineWidth = 1;
pt2fill.LineStyle = '--';

pt3fill.FaceAlpha = 0.6;
pt3fill.LineWidth = 1;
pt3fill.LineStyle = '--';

plot([-1, 1], sqrt(3)/2 * [1, 1], 'k--', 'Color', [0, 0, 0, 0.5]);
plot([-1, 1], -sqrt(3)/2 * [1, 1], 'k--', 'Color', [0, 0, 0, 0.5]);

ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
axis([-1.3, 1.3 -1.3 1.3]);
% xlabel('$x$');
% ylabel('$y$');
ax.XLabel.Interpreter = 'latex';
ax.YLabel.Interpreter = 'latex';

% ax.XAxis.TickLabelInterpreter = 'latex';
ax.XAxis.FontSize = 12;
ax.XAxis.TickValues = [-1, -0.5, 0, 0.5 1];
ax.XAxis.TickLabelFormat = '%g       ';
ax.XAxis.TickDirection = 'both';
ax.XAxis.TickLabels = {};
ax.XAxis.LineWidth = 1;
% ax.YAxis.TickLabelInterpreter = 'latex';
ax.YAxis.FontSize = 12;
ax.YAxis.TickValues = [-1 1];
ax.YAxis.TickLabelFormat = '%g';
ax.YAxis.TickDirection = 'both';
ax.YAxis.TickLabels = {};
ax.YAxis.LineWidth = 1;

ax.XLabel.FontSize = 18;
ax.YLabel.FontSize = 18;


text(-0.1, 1.1, '$1$', 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 14, 'BackgroundColor', [1, 1, 1, 0]);
text(-0.15, -1.1, '$-1$', 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 14, 'BackgroundColor', [1, 1, 1, 0]);

text(-1.15, -0.15, '$-1$', 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 14, 'BackgroundColor', [1, 1, 1, 0]);
text(1.1, -0.15, '$1$', 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 14, 'BackgroundColor', [1, 1, 1, 0]);



text(1, 0.2, '$p_1$', 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 14, 'BackgroundColor', [1, 1, 1, 0.7]);
text(-0.8, 0.2, '$p_2$', 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 14);
text(-0.2, 0.2, '$p_3$', 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 14);

text(1.3, 0.1, '$x$', 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 16, 'BackgroundColor', [1, 1, 1, 0]);
text(0, 1.4, '$y$', 'Interpreter', 'latex', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 16, 'BackgroundColor', [1, 1, 1, 0.7]);

axis equal;
    save2pdf(['InitialConditionPossibilities.pdf'], gcf, 600);
