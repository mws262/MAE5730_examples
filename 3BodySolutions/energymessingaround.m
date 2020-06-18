syms G m1 m2 m3 positive
syms x1 x2 x3 xd1 xd2 xd3 y1 y2 y3 yd1 yd2 yd3 real;


xd3 = m2 * xd2 / m3;
yd3 = (m2 * yd2 + m2 * yd1) / m3;


kinit = 1/2 * m1 * (yd1^2) + 1/2 * m2 * (xd2^2 + yd2^2) + 1/2 * m3 * (xd3^2 + yd3^2);
kinit = subs(kinit, [m1,m2,m3], [1,1,1])
uinit = 4/3