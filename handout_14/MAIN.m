% Matt Sheen's solution for Handout 14.
%
% The functions phidot.m and positions.m are symbolically derived and
% auto-created by derive.m. All work was done symbolically.

clear all; close all
% derive;

t = transpose(0:0.01:12*pi); % Time interval.

phi_dot = phidot(t); % Evaluate phidot using the function we wrote in derive.m
phi = cumtrapz(t,phi_dot); % Integrate angular rate over time to get phi. No ode45 required!
pos = positions(phi,t); % Get positions of all the particles (written in derive.m).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% All below this is animation. See derive.m for the math. %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Plotting/animation
fig = figure;
fig.Position = [100,100,1200,1000];
% Animation of plate
subplot(2,3,[1,2,4,5]);
hold on
pl1 = plot(0,0,'.','MarkerSize',40); % The 4 masses
pl2 = plot(0,0,'.','MarkerSize',40);
pl3 = plot(0,0,'.','MarkerSize',40);
pl4 = plot(0,0,'.','MarkerSize',40);
plate = patch([-4,-4,4,4],[-4,4,4,-4],'r'); % The background plate
plate.FaceAlpha = 0.2;
plateVert = plate.Vertices;
phase = 0:0.05:2*pi;
p3CircPts = [cos(phase) + 2; sin(phase)]; % The two circles on which p3 and p4 rotate
p3Circle = plot(p3CircPts(1,:),p3CircPts(2,:),':');
p4CircPts = [cos(phase) - 2; sin(phase)];
p4Circle = plot(p4CircPts(1,:),p4CircPts(2,:),':');
axis(1.2*[-4,4,-5.5,5.5]);
hold off

% Phi
subplot(2,3,3);
hold on
phiPlot = plot(t,phi);
phiPlotDot = plot(0,0,'.','MarkerSize',40);
xlabel('time');
ylabel('phi');
hold off

% Phidot
subplot(2,3,6);
hold on
phidotPlot = plot(t,phi_dot);
phidotPlotDot = plot(0,0,'.','MarkerSize',40);
xlabel('time');
ylabel('phidot');
hold off

tfactor = 1;
tCurrent = 0;
tic
% Animation loop updates
while tCurrent*tfactor < t(end)
    
    % Interpolate in time
    currPos = interp1(t,pos,tCurrent*tfactor);
    currPhi = interp1(t,phi,tCurrent*tfactor);
    currPhidot = interp1(t,phi_dot,tCurrent*tfactor);
    
    rot = [cos(currPhi),-sin(currPhi);sin(currPhi),cos(currPhi)];
    
    % Mass positions
    pl1.XData = currPos(1);
    pl1.YData = currPos(2);

    pl2.XData = currPos(3);
    pl2.YData = currPos(4);
    
    pl3.XData = currPos(5);
    pl3.YData = currPos(6);
    
    pl4.XData = currPos(7);
    pl4.YData = currPos(8);
    
    plate.Vertices = (rot*(plateVert'))';
    currP3Circ = rot*p3CircPts;
    currP4Circ = rot*p4CircPts;
    p3Circle.XData = currP3Circ(1,:);
    p3Circle.YData = currP3Circ(2,:);
    p4Circle.XData = currP4Circ(1,:);
    p4Circle.YData = currP4Circ(2,:);
    
    % Other plots
    phiPlotDot.XData = tCurrent*tfactor;
    phiPlotDot.YData = currPhi;
    
    phidotPlotDot.XData = tCurrent*tfactor;
    phidotPlotDot.YData = currPhidot;
    
    drawnow;
    tCurrent = toc;
end


