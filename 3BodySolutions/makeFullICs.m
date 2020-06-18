function [fullICs, minICs] = makeFullICs(x2, y2, y1dot, x2dot, y2dot, p)
x1 = 1;
y1 = 0;
x1dot = 0;

x3 = -(p.m1 * x1 + p.m2 * x2) / p.m3;
y3 = -(p.m1 * y1 + p.m2 * y2) / p.m3;
x3dot = -(p.m1 * x1dot + p.m2 * x2dot) / p.m3;
y3dot = -(p.m1 * y1dot + p.m2 * y2dot) / p.m3;

fullICs = [x1, y1, x2, y2, x3, y3, x1dot, y1dot, x2dot, y2dot, x3dot, y3dot];
minICs = [x1, y1, x2, y2, x1dot, y1dot, x2dot, y2dot];
end
