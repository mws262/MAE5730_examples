close all;
%%%%% TOP VIEW %%%%%%
fig = figure;
fig.Color = [1,1,1];
fig.Position = [100, 100, 450, 800];
ax = axes;

surfaceMat = 3/4 * [1, 0.5, 0; 0.5, 1, 0; 0, 0, 1];
[evecs, evals] = eig(surfaceMat);
axHalfLengths = 1./diag(sqrt(evals));
hold on;

ax1 = plot3(axHalfLengths(1) * 1.2 * [-evecs(1, 1), evecs(1, 1)*0], ...
    axHalfLengths(1) * 1.2 * [-evecs(2, 1), evecs(2, 1)*0], ...
    axHalfLengths(1) * 1.2 * [-evecs(3, 1), evecs(3, 1)*0]);

ax2 = plot3(axHalfLengths(2) * 1.2 * [-evecs(1, 2), evecs(1, 2)], ...
    axHalfLengths(2) * 1.2 * [-evecs(2, 2), evecs(2, 2)], ...
    axHalfLengths(2) * 1.2 * [-evecs(3, 2), evecs(3, 2)]);

ax3 = plot3(axHalfLengths(3) * 1.2 * [-evecs(1, 3)*0, evecs(1, 3)], ...
    axHalfLengths(3) * 1.2 * [-evecs(2, 3)*0, evecs(2, 3)], ...
    axHalfLengths(3) * 1.2 * [-evecs(3, 3)*0, evecs(3, 3)]);

ax1.LineWidth = 3;
ax1.Color = [1, 0, 0];
ax1.Marker = '.';
ax1.MarkerSize = 30;

ax2.LineWidth = 3;
ax2.Color = [0, 0, 1];
ax2.Marker = '.';
ax2.MarkerSize = 30;

ax3.LineWidth = 3;
ax3.Color = [0, 1, 0];
ax3.Marker = '.';
ax3.MarkerSize = 30;

f= fimplicit3(@(y1,y2,x2)(y1.^2 + y1 .* y2 + y2.^2 + x2.^2 - 4/3), [0, 4/3, -4/3, 4/3, -1.2, 1.2]);
f.MeshDensity = 20;
ax.XLabel.Interpreter = 'latex';
ax.XLabel.String = '$\dot{y}_1$';
ax.XLabel.FontSize = 24;

ax.YLabel.Interpreter = 'latex';
ax.YLabel.String = '$\dot{y}_2$';
ax.YLabel.FontSize = 24;

ax.ZLabel.Interpreter = 'latex';
ax.ZLabel.String = '$\dot{x}_2$';
ax.ZLabel.FontSize = 24;
axis equal;
grid on;
ax.XLim = [0, 1.5];
ax.YLim = [-1.6, 1.5];
% ax.CameraPosition = [cos(pi/2), 0, sin(pi/2); 0, 1, 0; -sin(pi/2), 0, cos(pi/2)] * ax.CameraPosition'

save2pdf('vel_constraint_ellipsoid_top.pdf', fig, 600);

ax.CameraPosition = [1, 0, 0; 0, cos(pi/2), -sin(pi/2); 0, sin(pi/2), cos(pi/2)] * ax.CameraPosition';
fig.Position(3) = 525;

%%%% y1x1 SIDE VIEW.
ax.Units = 'normalized';
ax.XLabel.Position(1) = 0.8;
save2pdf('vel_constraint_ellipsoid_y1x2side.pdf', fig, 600);


%%%%%% y2 x2 side view

ax.CameraPosition = ...
[cos(pi/2) 0 sin(pi/2); 0 1 0; -sin(pi/2) 0 cos(pi/2)] * ...
[1, 0, 0; 0, cos(-pi/2), -sin(-pi/2); 0, sin(-pi/2), cos(-pi/2)] * ax.CameraPosition';
fig.Position(3) = 750;
ax.YLabel.Position(2) = 0.05;
ax.XLabel.Position(2) = 10; % it's in the way. get rid of it.
save2pdf('vel_constraint_ellipsoid_y2x2side.pdf', fig, 600);

%%% Oblique view
view(45.2, 54.4)
fig.Position(3) = 600;
fig.Position(4) = 700;

ax.YLabel.Position(1) = 1.7;
ax.YLabel.Position(2) = 0.4;

ax.XLabel.Position(2) = -1.8;
ax.XLabel.Position(1) = 0.5;

l = legend('Major axis', 'Intermediate axis', 'Minor axis');
l.FontSize = 12;
l.Position(2) = l.Position(2) - 0.05

save2pdf('vel_constraint_ellipsoid_oblique.pdf', fig, 600);
