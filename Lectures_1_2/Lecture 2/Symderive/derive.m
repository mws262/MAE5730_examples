% Derive kinematics -- a 3-link arm, relative angle accounting.

% Define variables
syms th1 th2 th3 thdot1 thdot2 thdot3 thdotdot1 thdotdot2 thdotdot3 l1 l2 l3 real

p1 = [l1*cos(th1); l1*sin(th1)]; % Position of first elbow

p2 = [l2*cos(th2 + th1); l2*sin(th2 + th1)] + p1;

p3 = [l3*cos(th3 + th2 + th1); l3*sin(th3 + th2 + th1)] + p2;


vp3 = jacobian(p3,[th1,th2,th3])*[thdot1,thdot2,thdot3]'; % Chain rule to get time derivative.

ap3 = jacobian(vp3,[th1,th2,th3,thdot1,thdot2,thdot3])*[thdot1,thdot2,thdot3,thdotdot1,thdotdot2,thdotdot3]'; % Again for accel

% Exampleof chain rule: jacobian(l1*sin(th1),[th1])*thdot1


matlabFunction(ap3,'File','accelP3');

% Use the function:

accelP3(1/3,1/3,1/3,0,0,0,1,0,0,0,0,0); % Special case, where three link looks like 1 rigid bar. We know accel in this case is omega^2*r towards the origin.



% Now a solving problem:
% Dumb problem -- given th1,th2 = 0, l1 l2 l3 = 1
% find th3

newP3 = subs(p3,{th1,th2,l1,l2,l3},[0,0,1,1,1]);

p3Equals0 = newP3 - [3;0];

solve(p3Equals0,th3)





