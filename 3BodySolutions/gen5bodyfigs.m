periods = [];
x1 = [];
y1 = [];
x2 = [];
y2 = [];
x3 = [];
y3 = [];
x4 = [];
y4 = [];
x5 = [];
y5 = [];

xd1 = [];
yd1 = [];
xd2 = [];
yd2 = [];
xd3 = [];
yd3 = [];
xd4 = [];
yd4 = [];
xd5 = [];
yd5 = [];

for i = 1:7
   close all;
   [tend, inits] = get5BodySol(i);
   save2pdf(['5body_', num2str(i)], gcf, 300);
   periods(end + 1) = tend;
    x1(end + 1) = inits(1);
    y1(end + 1) = inits(6);
    x2(end + 1) = inits(2);
    y2(end + 1) = inits(7);
    x3(end + 1) = inits(3);
    y3(end + 1) = inits(8);
    x4(end + 1) = inits(4);
    y4(end + 1) = inits(9);
    x5(end + 1) = inits(5);
    y5(end + 1) = inits(10);
    
    xd1(end + 1) = inits(1 + 10);
    yd1(end + 1) = inits(6 + 10);
    xd2(end + 1) = inits(2 + 10);
    yd2(end + 1) = inits(7 + 10);
    xd3(end + 1) = inits(3 + 10);
    yd3(end + 1) = inits(8 + 10);
    xd4(end + 1) = inits(4 + 10);
    yd4(end + 1) = inits(9 + 10);
    xd5(end + 1) = inits(5 + 10);
    yd5(end + 1) = inits(10 + 10);
end

for i = 1:6
   fprintf('%.12f & ', periods(i))  
end
fprintf('%.12f \\\\ \n', periods(7)) 

for i = 1:6
   fprintf('%.12f & ', x1(i))  
end
fprintf('%.12f \\\\ \n', x1(7))  

for i = 1:6
   fprintf('%.12f & ', x2(i))  
end
fprintf('%.12f \\\\ \n', x2(7))  

for i = 1:6
   fprintf('%.12f & ', x3(i))  
end
fprintf('%.12f \\\\ \n', x3(7))  

for i = 1:6
   fprintf('%.12f & ', x4(i))  
end
fprintf('%.12f \\\\ \n', x4(7))  

for i = 1:6
   fprintf('%.12f & ', x5(i))  
end
fprintf('%.12f \\\\ \n', x5(7))  

for i = 1:6
   fprintf('%.12f & ', y1(i))  
end
fprintf('%.12f \\\\ \n', y1(7))  

for i = 1:6
   fprintf('%.12f & ', y2(i))  
end
fprintf('%.12f \\\\ \n', y2(7))  

for i = 1:6
   fprintf('%.12f & ', y3(i))  
end
fprintf('%.12f \\\\ \n', y3(7))  

for i = 1:6
   fprintf('%.12f & ', y4(i))  
end
fprintf('%.12f \\\\ \n', y4(7))  

for i = 1:6
   fprintf('%.12f & ', y5(i))  
end
fprintf('%.12f \\\\ \n', y5(7))  

for i = 1:6
   fprintf('%.12f & ', xd1(i))  
end
fprintf('%.12f \\\\ \n', xd1(7))  

for i = 1:6
   fprintf('%.12f & ', xd2(i))  
end
fprintf('%.12f \\\\ \n', xd2(7))  

for i = 1:6
   fprintf('%.12f & ', xd3(i))  
end
fprintf('%.12f \\\\ \n', xd3(7))  

for i = 1:6
   fprintf('%.12f & ', xd4(i))  
end
fprintf('%.12f \\\\ \n', xd4(7))  

for i = 1:6
   fprintf('%.12f & ', xd5(i))  
end
fprintf('%.12f \\\\ \n', xd5(7))  

for i = 1:6
   fprintf('%.12f & ', yd1(i))  
end
fprintf('%.12f \\\\ \n', yd1(7))  

for i = 1:6
   fprintf('%.12f & ', yd2(i))  
end
fprintf('%.12f \\\\ \n', yd2(7))  

for i = 1:6
   fprintf('%.12f & ', yd3(i))  
end
fprintf('%.12f \\\\ \n', yd3(7))  

for i = 1:6
   fprintf('%.12f & ', yd4(i))  
end
fprintf('%.12f \\\\ \n', yd4(7))  

for i = 1:6
   fprintf('%.12f & ', yd5(i))  
end
fprintf('%.12f \\\\ \n', yd5(7))  
