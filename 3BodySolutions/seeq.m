function [q,p]=seeq(dqdt,dpdt,tspan,q0,p0,varargin)
%SEEQ Symplectic Euler solver, explicit method.
%  [Q P] = SEEQ(DQDT,DPDT,TSPAN,Q0,P0) solves Hamilton's equations dq/dt = 
%  T'(p), dp/t = - V'(q) using an implicit Euler solver by stepping from
%  T0 to T1 to T2, etc. Functions DQDT(P) and DPDT(Q) must return T'(p) and
%  - V'(q) in the form of a N-dimensional column vectors. Vectors Q0 and P0
%  are the initial conditions at T0. Each row in the solution arrays Q and
%  P corresponds to a time specified in TSPAN.  
%
%  [Q P] = SEEQ(DQDT,DPDT,TSPAN,Q0,P0,VARARGIN) passes the additional
%  parameters R1, R2, ... to functions DQDT(P,R1,R2,...) and DPDT(Q,R1,
%  R2,...).
%
%  To construct this numerical integrator the q-variable is treated by the
%  implicit Euler method and the p-variable by the explicit Euler method 
%  for a nonseparable Hamiltonian H(q,p). An explicit integrator results 
%  when H(q,p) = T(p) + V(q).
%
%  See also SEEQ, SEEP, SEIP, GLS.
%  Francisco J. Beron-Vera, 28-Mar-2005
%  $Revision: 1.0 $  $Date: 28-Mar-2005 14:58:31 $
N = length(q0);  
Nt = length(tspan); 
hs = diff(tspan);
q = zeros(N,Nt); q(:,1)=q0;
p = zeros(N,Nt); p(:,1)=p0;
for nt = 2:Nt
   t = tspan(nt-1); if ~mod(nt,100), disp(['t = ' num2str(t)]), end
   h = hs(nt-1);
   q(:,nt) = q(:,nt-1) + h * feval(dqdt, p(:,nt-1), varargin{:});
	p(:,nt) = p(:,nt-1) + h * feval(dpdt, q(:,nt)  , varargin{:}); 
end
q = q.';
p = p.';