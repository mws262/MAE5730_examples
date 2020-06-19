close all; clear all;


fig = figure;
ax = axes;
fig.Color = [1, 1, 1];
fig.Position = [100, 100, 1000, 800];
    
cols = lines(5);
hold on;

p1 = [2,2];
p2 = [-0.5, 2.2];
p3 = [-0.9, -1.7];
ps = [p1; p2; p3];

p12 = p2 - p1;
p23 = p3 - p2;
p13 = p3 - p1;

pdiff = [p12; p23; -p13; p13; -p12; -p23];
pdiff = pdiff ./ sqrt(sum(pdiff .* pdiff, 2));
psextra = [ps; ps];
quiv = quiver(psextra(:, 1), psextra(:, 2), pdiff(:, 1), pdiff(:, 2));
quiv.AutoScale = 'off';
quiv.Color = [0,0,0];
quiv.LineWidth = 4;

plot(p1(1), p1(2), '.', 'MarkerSize', 90, 'Color', cols(1, :));
plot(p2(1), p2(2), '.', 'MarkerSize', 90, 'Color', cols(5, :));
plot(p3(1),  p3(2), '.', 'MarkerSize', 90, 'Color', cols(3, :));

tp1 = text(p1(1) + 0.4, p1(2) + 0.4, '$\vec{p}_1 = (x_1, y_1)$', 'Interpreter', 'latex', 'FontSize', 30);
tp2 = text(p2(1) - 2.1, p2(2) + 0.4, '$\vec{p}_2 = (x_2, y_2)$', 'Interpreter', 'latex', 'FontSize', 30, 'HorizontalAlignment', 'left');
tp3 = text(p3(1) - 1.2, p3(2) - 0.5, '$\vec{p}_3 = (x_3, y_3)$', 'Interpreter', 'latex', 'FontSize', 30, 'HorizontalAlignment', 'left');


f21 = text(p1(1) - 0.7, p1(2) + 0.4, '$\vec{F}_{2/1}$', 'Interpreter', 'latex', 'FontSize', 24);
f31 = text(p1(1) - 0.2, p1(2) - 0.6, '$\vec{F}_{3/1}$', 'Interpreter', 'latex', 'FontSize', 24);

f12 = text(p2(1) + 0.4, p2(2) + 0.3, '$-\vec{F}_{2/1}$', 'Interpreter', 'latex', 'FontSize', 24);
f13 = text(p3(1) + 0.6, p3(2) + 0.4, '$-\vec{F}_{3/1}$', 'Interpreter', 'latex', 'FontSize', 24);

f23 = text(p2(1) - 0.75, p2(2) - 0.5, '$\vec{F}_{3/2}$', 'Interpreter', 'latex', 'FontSize', 24);
f32 = text(p3(1) - 0.9, p3(2) + 0.6, '$-\vec{F}_{3/2}$', 'Interpreter', 'latex', 'FontSize', 24);

iax = text(3.1, 0.2, '$\hat{i}$', 'Interpreter', 'latex', 'FontSize', 30);
jax = text(0, 3.3, '$\hat{j}$', 'Interpreter', 'latex', 'FontSize', 30);
orig = text(0.05, 0.2, '$\mathcal O$', 'Interpreter', 'latex', 'FontSize', 30);
plot(0,0, 'k.', 'MarkerSize', 20);

ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.XTickLabel = {};
ax.YTickLabel = {};

axis equal
axis([-3, 3, -3, 3]); 

save2pdf('body3fbd.pdf', fig, 600);