% Derive dynamics of 3-body system

syms x1 y1 xdot1 ydot1 x2 y2 xdot2 ydot2 x3 y3 xdot3 ydot3 G m1 m2 m3 real

% Point positions
p1 = [x1;y1];
p2 = [x2;y2];
p3 = [x3;y3];

v1 = [xdot1; ydot1];
v2 = [xdot2; ydot2];
v3 = [xdot3; ydot3];

% Vector from point 1 to 2, etc
r1_2 = p2 - p1;
r1_3 = p3 - p1;
r2_3 = p3 - p2;

% Force on 1 by 3
f1_3 = G*m1*m3/dot(r1_3,r1_3)*r1_3/norm(r1_3);
% Force on 3 by 1
f3_1 = -f1_3;

% Force on 2 by 3
f2_3 = G*m2*m3/dot(r2_3,r2_3)*r2_3/norm(r2_3);
% Force on 3 by 2
f3_2 = -f2_3;

% Force on 1 by 2
f1_2 = G*m1*m2/dot(r1_2,r1_2)*r1_2/norm(r1_2);
% Force on 2 by 1
f2_1 = -f1_2;

% a = f/m for point 1
a1 = (f1_2 + f1_3)/m1;
a2 = (f2_1 + f2_3)/m2;
a3 = (f3_1 + f3_2)/m3;

a = [a1;a2;a3];

matlabFunction(a,'file','accel');

com = (m1 * p1 + m2 * p2 + m3 * p3) / (m1 + m2 + m3);

angMom = dot(cross([p1 - com; 0], m1 * [v1; 0]) + cross([p2 - com; 0], m2 * [v2; 0]) + cross([p3 - com; 0], m3 * [v3; 0]), [0;0;1]);
matlabFunction(angMom, 'file', 'angMom');

potE = -G * m1 * m2 / norm(r1_2) + ...
    -G * m1 * m3 / norm(r1_3) + ...
    -G * m2 * m3 / norm(r2_3);
kinE = 1/2 * (m1 * (v1' * v1) + m2 * (v2' * v2) + m2 * (v3' * v3));

totE = potE + kinE;

invars = [x1, y1, x2, y2, x3, y3, xdot1, ydot1, xdot2, ydot2, xdot3, ydot3];

dynJ = jacobian([v1;v2;v3;a], invars);
matlabFunction(dynJ, 'File', 'dynJ', 'Vars', {invars, G, m1, m2, m3});

matlabFunction(potE, 'File', 'potE', 'Vars', {invars, G, m1, m2, m3});
matlabFunction(kinE, 'File', 'kinE', 'Vars', {invars, G, m1, m2, m3});
matlabFunction(totE, 'File', 'totE', 'Vars', {invars, G, m1, m2, m3});



