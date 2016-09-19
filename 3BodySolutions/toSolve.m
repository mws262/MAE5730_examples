function defect = toSolve(soln,p,figs)
% soln structure: [tend,x1,y1,xdot1,...]

[tarray,zarray] = ode45(@RHS,[0,soln(1)],soln(2:end),p.odeOpts,p);
defect = zarray(end,:) - zarray(1,:);

if p.showSolverGuesses
    updateSolvePlots(zarray,figs);
end

end