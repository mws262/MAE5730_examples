close all; clear all;
% Series of examples of ways to animate a pendulum. Whatever you choose,
% please do NOT use Version 0.

%% Set up pendulum problem and integrate.
% Define parameters
g = 10;
l = 1;

rhs = @(t, z)([z(2); -g/l * sin(z(1))]); % Defined dynamics function as an anonymous function. t, z are inputs. g, l are fixed as defined above. Returns zdot.

% Simulation time span
tspan = [0, 2];

% Initial conditions
init = [pi/2, 0];

options = odeset('AbsTol', 1e-6, 'RelTol', 1e-6);
[tarray, zarray] = ode45(rhs, tspan, init, options);

plot(tarray, zarray(:,1));

%% Version 0: PLOTPLOTPLOTPLOT -- BAD. Resist the urge to do this!
figure;
for i = 1:length(tarray)
   th = zarray(i, 1);
   
   % Very slow and inefficient to have plot and axis commands inside a
   % loop. MATLAB is essentially creating new plots and axes every loop
   % iteration.
   plot([0, l*sin(th)], [0, -l*cos(th)]);
   axis equal
   axis([-2 2 -2 2]); 
   pause(0.02)
end

%% Version 1: XData, YData editing -- Better, but animation time might be faster or slower than it should be.
figure;
pend = plot(0,0); % Create a plot once.
axis equal;
axis([-2 2 -2 2]);

for i = 1:length(tarray)
    th = zarray(i, 1);
    pend.XData = [0, l*sin(th)]; % Change the data in the single plot to move the pendulum.
    pend.YData = [0, -l*cos(th)];
    pause(0.02)
end


%% Version 2: Correct animation timing -- Best.
figure;
pend = plot(0, 0); % Create a plot once outside the loop
axis equal
axis([-2 2 -2 2]);

timeFactor = 1; % If you want to run faster or slower than real time, e.g. 2 means twice real time.

currTime = 0;
tic; % Start timer.
while currTime < tspan(2) * timeFactor % Current time less than the final simulation time.
    % Interpolate pendulum angle at the current animation time.
    th = interp1(tarray, zarray(:, 1), currTime * timeFactor);
    
    pend.XData = [0, l * sin(th)];
    pend.YData = [0, -l * cos(th)];
    drawnow;
    
    currTime = toc; % Set current time to the timer's current value.
end

%% Version 3: Animating something besides a line.
figure;
% Make a 'patch', basically a box in this case. Can have as many vertices
% as you want.
pend = patch([-0.05, 0.05, 0.05, -0.05], [0, 0, -l, -l], 'r');
originalVertices = pend.Vertices; % Keep track of the untransformed vertices of the patch.

axis equal
axis([-2 2 -2 2]);

timeFactor = 1;
currTime = 0;
tic;
while currTime < tspan(2) * timeFactor
    % Interpolate angle to current time.
    th = interp1(tarray, zarray(:, 1), currTime * timeFactor);
    
    % Rotation matrix.
    rotation = [cos(th), -sin(th); sin(th), cos(th)];
    
    % Rotate all vertices in one matrix operation. 
    pend.Vertices = (rotation * originalVertices')'; % Transpose maxes the first row x's, second row y's. This makes the dimensions match for the matrix multiply. Then transpose back to match the original shape of the vertex matrix.
    drawnow;
    
    currTime = toc;
end
