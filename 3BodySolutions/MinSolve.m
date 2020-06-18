function MinSolve


fsolveOpts = optimset('fsolve');
fsolveOpts.Algorithm = 'levenberg-marquardt'; % fsolve will default to this anyway after a few seconds and a warning message.
fsolveOpts.TolX = 1e-8;
fsolveOpts.Display = 'iter';
odeOpts = odeset;
odeOpts.RelTol = 1e-10;
odeOpts.AbsTol = 1e-10;
par.G = 1;
par.m1 = 1;
par.m2 = 1;
par.m3 = 1;
solution = 1000 * ones(6, 1); % something that will fail initially.

while (~isVelICValid(solution(4), solution(5), solution(6)) || ~isP2Valid(solution(2), solution(3)) || ~solution(1) > 0.01 || (fullIC(5) == 0 && fullIC(6) == 0))
    guess = 2 * rand(6,1) - 1;
    guess(1) = 10;

    while (~isVelICValid(guess(4), guess(5), guess(6)) || ~isP2Valid(guess(2), guess(3)))
    guess = 2 * rand(6,1) - 1;    
    guess(1) = 6;
    end

    disp('found one');
    disp(guess);

    solution = fsolve(@toSolve,guess,fsolveOpts)
    fullIC = makeFullICs(solution(2), solution(3), solution(4), solution(5), solution(6), par);
end
[tarrayguess,zarrayguess] = ode45(@RHS,[0,solution(1)],fullIC,odeOpts,par);

    plot3body(zarrayguess);
axis equal
    function defect = toSolve(P)
        
        [fullICs, minICs] = makeFullICs(P(2),P(3),P(4),P(5),P(6), par);
        [tarray,zarray] = ode45(@rhs,[0,P(1)],minICs, odeOpts);
        defect = zarray(end,:) - zarray(1,:);
    end

    function zdot = rhs(t, z)
        x1 = z(1);
        x2 = z(3);
        y1 = z(2);
        y2 = z(4);
        
       a = accelMin(1,1,1,1, x1, x2, y1, y2);
        zdot = [z(5:8); a];
    end
end