periods = [];
x1 = [];
y1 = [];
x2 = [];
y2 = [];
x3 = [];
y3 = [];
x4 = [];
y4 = [];


xd1 = [];
yd1 = [];
xd2 = [];
yd2 = [];
xd3 = [];
yd3 = [];
xd4 = [];
yd4 = [];

num = 8;
for i = 1:num
   close all;
   [tend, inits] = get4BodySol(i);
   save2pdf(['4body_', num2str(i)], gcf, 300);
   periods(end + 1) = tend;
    x1(end + 1) = inits(1);
    y1(end + 1) = inits(5);
    x2(end + 1) = inits(2);
    y2(end + 1) = inits(6);
    x3(end + 1) = inits(3);
    y3(end + 1) = inits(7);
    x4(end + 1) = inits(4);
    y4(end + 1) = inits(8);

    
    xd1(end + 1) = inits(1 + 8);
    yd1(end + 1) = inits(5 + 8);
    xd2(end + 1) = inits(2 + 8);
    yd2(end + 1) = inits(6 + 8);
    xd3(end + 1) = inits(3 + 8);
    yd3(end + 1) = inits(7 + 8);
    xd4(end + 1) = inits(4 + 8);
    yd4(end + 1) = inits(8 + 8);

end

for i = 1:num - 1
   fprintf('%.12f & ', periods(i))  
end
fprintf('%.12f \\\\ \n', periods(num)) 

for i = 1:num - 1
   fprintf('%.12f & ', x1(i))  
end
fprintf('%.12f \\\\ \n', x1(num))  

for i = 1:num - 1
   fprintf('%.12f & ', x2(i))  
end
fprintf('%.12f \\\\ \n', x2(num))  

for i = 1:num - 1
   fprintf('%.12f & ', x3(i))  
end
fprintf('%.12f \\\\ \n', x3(num))  

for i = 1:num - 1
   fprintf('%.12f & ', x4(i))  
end
fprintf('%.12f \\\\ \n', x4(num))  

for i = 1:num - 1
   fprintf('%.12f & ', y1(i))  
end
fprintf('%.12f \\\\ \n', y1(num))  

for i = 1:num - 1
   fprintf('%.12f & ', y2(i))  
end
fprintf('%.12f \\\\ \n', y2(num))  

for i = 1:num - 1
   fprintf('%.12f & ', y3(i))  
end
fprintf('%.12f \\\\ \n', y3(num))  

for i = 1:num - 1
   fprintf('%.12f & ', y4(i))  
end
fprintf('%.12f \\\\ \n', y4(num))  

for i = 1:num - 1
   fprintf('%.12f & ', xd1(i))  
end
fprintf('%.12f \\\\ \n', xd1(num))  

for i = 1:num - 1
   fprintf('%.12f & ', xd2(i))  
end
fprintf('%.12f \\\\ \n', xd2(num))  

for i = 1:num - 1
   fprintf('%.12f & ', xd3(i))  
end
fprintf('%.12f \\\\ \n', xd3(num))  

for i = 1:num - 1
   fprintf('%.12f & ', xd4(i))  
end
fprintf('%.12f \\\\ \n', xd4(num))  

for i = 1:num - 1
   fprintf('%.12f & ', yd1(i))  
end
fprintf('%.12f \\\\ \n', yd1(num))  

for i = 1:num - 1
   fprintf('%.12f & ', yd2(i))  
end
fprintf('%.12f \\\\ \n', yd2(num))  

for i = 1:num - 1
   fprintf('%.12f & ', yd3(i))  
end
fprintf('%.12f \\\\ \n', yd3(num))  

for i = 1:num - 1
   fprintf('%.12f & ', yd4(i))  
end
fprintf('%.12f \\\\ \n', yd4(num))  