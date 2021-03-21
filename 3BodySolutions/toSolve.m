function defect = toSolve(soln,p,figs)
% soln structure: [tend,x1,y1,xdot1,...]
%  zarray = ode5(@nbody_rhs,0:0.001:soln(1),soln(2:end), p);

tic
n = length(soln) - 1; % minus period.
x = soln(1:n/4);
y = soln(n/4 + 1:n/2);
xd = soln(n/2 + 1:3*n/4);
yd = soln(3*n/4 + 1:n);

init = [x;;y;xd;yd];
% init = [x;-sum(x);y;-sum(y);xd;-sum(xd);yd;-sum(yd)];

if any(abs(init(1:(length(init)/2))) > 11.5) % soln(end) < 0.1 ||
       disp(['stuff too big ', num2str(max(abs(init(1:(length(init)/2)))))]); 
           errID = 'myComponent:inputError';
    msgtext = 'Input does not have the expected format.';

    ME = MException(errID,msgtext);

    throw(ME);
end


[~,zarray] = ode45(@nbody_rhs,[0,soln(end)],init,p.odeOpts,p); %soln(1:end-1)
% if isempty(te)
%     te = soln(end);
% end
dur = toc;
n = n/4;
% fin = [zarray(:, 1:n), zarray(:, n + 2:2*n + 1), zarray(:, 2*n + 3:3*n + 2), zarray(:, 3*n + 4:4*n + 3)];
fin = zarray;
defect = [fin(end,:) - fin(1,:)]; % 100*(te - soln(end)), 
fprintf('.');
% 
% if te < 0.01 || dur > 20
%     errID = 'myComponent:inputError';
% msgtext = 'Input does not have the expected format.';
% 
% ME = MException(errID,msgtext);
% 
% throw(ME);
% end
if p.showSolverGuesses
    updateSolvePlots(zarray,figs);
end

end