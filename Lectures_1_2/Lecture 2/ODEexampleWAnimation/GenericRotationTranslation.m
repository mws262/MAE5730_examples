close all; clear all;
%% Example for both rotating and translating an object as an animation.
% Should be easy enough to change the positions, angles, times, and shape
% information to match your problem.

% Define some arbitrary path for the object.
times = linspace(0, 10, 100)';
positions = [sin(times), times];
angles = linspace(0, 8 * pi, length(times))';

plot(positions(:,1), positions(:,2), ':'); % Just plotting so we can see the path that the object should take. Not essential.
hold on;

% Make some graphics object to transform.
object = patch([-1 -1 1 1], [-1 1 1 -1], 'b'); % Could also be another shape with different number of vertices.
initialVertices = object.Vertices; % Save the initial vertices to transform during the animation.

axis equal;
axis([-10, 10, -2, 12]);

currentTime = 0;
tic; % Start timer.
while currentTime < times(end)
    
    % Interpolate both angles and positions to the current time.
    currentAngle = interp1(times, angles, currentTime);
    currentPosition = interp1(times, positions, currentTime);
    rotation = [cos(currentAngle), -sin(currentAngle); sin(currentAngle), cos(currentAngle)];

    % MOST IMPORTANT. Rotate first, then translate. Rotation will always
    % happen about (0, 0). May need to subtract an offset before rotating,
    % and then add it back in afterwards.
    object.Vertices = (rotation * initialVertices')' + currentPosition;
    
    drawnow; % Update graphics.

    currentTime = toc; % Update time from timer.
end