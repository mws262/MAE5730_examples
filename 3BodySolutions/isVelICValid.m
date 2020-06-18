function valid = isVelICValid(y1dot, x2dot, y2dot)
% assuming m1=m2=m3=G = 1

valid = y1dot^2 + x2dot^2 + y2dot^2 + y1dot * y2dot <= 4/3;

end