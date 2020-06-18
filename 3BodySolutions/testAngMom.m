clear all;

[tend,inits] = getSolutionNum(5); % This gets one of my previously-found solutions. You can try other things as well.

x1 = inits(1);
x2 = inits(3);
x3 = inits(5);
xdot1 = inits(7);
xdot2 = inits(9);
xdot3 = inits(11);

y1 = inits(2);
y2 = inits(4);
y3 = inits(6);
ydot1 = inits(8);
ydot2 = inits(10);
ydot3 = inits(12);

angMom(1,1,1,x1,x2,x3,xdot1,xdot2,xdot3,y1,y2,y3,ydot1,ydot2,ydot3)