function zout = gls(X, DX, tspan, zin, s, tout, tol, maxiter, varargin)
%GLS S-stage Gauss-Legendre solver, symplectic method.
%  Y = GLS(ODEFUN,JACOBIAN,TSPAN,Y0,S) integrates the system of ordinary
%  differential equations y' = f(t,y) using a fully implicit S-stage
%  Gauss-Legendre Runge-Kutta method by stepping from T0 to T1 to T2, etc.
%  Function ODEFUN(T,Y) must return f(t,y) in an N-dimensional column
%  vector. The vector Y0 is the initial conditions at T0. Each row in the
%  solution array Y corresponds to a time specified in TSPAN. Function 
%  JACOBIAN(T,Y) must return the Jacobian matrix of f(t,y) which is needed
%  to perform Newton iterations for solving a system of 2*N*S nonlinear
%  algebraic equations each time step. 
%
%  Y = GLS(ODEFUN,JACOBIAN,TSPAN,Y0,S,TOUT) returns the solution at times
%  specified by TOUT. This is meant either for stroboscopic sampling at
%  integer multiples of TS or to return the solution at the final time
%  specified in TSPAN. In the former case TSPAN = 0:TS/M:N*TS and 
%  TOUT = TS:TS:N*TS, whereas in the latter TOUT = TSPAN(END). Default 
%  setting is TOUT = TSPAN.
%
%  Y = GLS(ODEFUN,JACOBIAN,TSPAN,Y0,S,TOUT,TOL,MAXITER) allows to set the 
%  error tolerance TOL for the relative increment of the solution of the 
%  algebraic system, the maximum number of iterations MAXITER to be 
%  performed. Default settings are TOL = 1e-6 and MAXITER = 15.
%
%  Y = GLS(ODEFUN,JACOBIAN,TSPAN,Y0,S,TOL,MAXITER,TOUT,VARARGIN) passes the
%  additional parameters P1, P2, ... to ODEFUN and JACOBIAN as ODEFUN(T,Y,
%  P1,P2,...) and JACOBIAN(T,Y,P1,P2,...).
%
%  For general canonical Hamiltonian systems the S-stage Gauss-Lengendre 
%  methods are symplectic, have optimal order (2*S), and are also A-stable. 
%  See details in McLachlan & Atela (1992), Nonlin. 5, 541.
%
%  Example: Solve x" + w^2 sin(x) = 0, x(0) = 2, x'(0) = 0, w = 1, using a
%           6th-order method with tolerance 1e-3 and 10 maximum Newton 
%           iterations per time step, and plot solution in phase space.
%  
%           y=gls(@(t,y,w) [y(2);-w^2*sin(y(1))],... 
%                 @(t,y,w) [0 1;-w^2*cos(y(1)) 0],...
%                 [0:.025:4*pi],[2;0],...
%                 3,[0:.025:4*pi],1e-3,10,...
%                 1);
%           plot(y(:,1),y(:,2))
%
%  See also SEEQ, SEEP, SEIQ, SEIP.
%  Francisco J. Beron-Vera, 27-Mar-2005
%  $Revision: 1.2 $  $Date: 31-Mar-2005 13:52:34 $
% Set default parameters.
if nargin < 6
   tout = tspan;
   tol = 1e-6;
   maxiter=15;
elseif nargin < 7
   tol = 1e-6;
   maxiter=15;
elseif nargin < 8
   maxiter=15;
end
% Set dimensions.
Nz = length(zin);  
Ntout = length(tout);
Ntspan = length(tspan); 
if Ntspan == Ntout
   nsample = 1;
   nmax = Ntout;
elseif (Ntspan > Ntout) && (Ntout > 1)
   nsample = (Ntspan-1)/Ntout;
   nmax = nsample*Ntout+1;
else
   nsample = Ntspan-1;
   nmax = Ntspan;
end
% Fill-in solution array with zeros.
zout = zeros(Ntout,Nz); 
if Ntspan == Ntout
   zout(1,:) = zin'; 
   nout = 2;
else
   nout = 1;
end
% Load coefficients for s-stage method.
[a b c] = abc(s);
% Main loop.
hspan = diff(tspan);
z = zin;
for n = 2:nmax
   t = tspan(n-1);
   if ~mod(n,1000)
      disp(['t = ' num2str(t) ' of ' num2str(tspan(end))])
   end
   h = hspan(n-1);
   g = newton(@(g)  F(g,  X, t, h, z, s, a, c, Nz, varargin{:}), ...
      @(g) DF(g, DX, t, h, s, a, c, Nz, varargin{:}), ...
      repmat(z,s,1), tol, maxiter);
   dz = zeros(Nz,1);
   for m = 1:s
      M = (m-1)*Nz+1:m*Nz;
      dz = dz + h*b(m)*feval(X, t+c(m)*h, g(M), varargin{:});
   end
   z = z + dz;
   if ~mod(n-1,nsample)
      zout(nout,:) = z';
      nout = nout + 1;
   end
end
%--------------------------------------------------------------------------
function out = F(g, X, t, h, z, s, a, c, Nz, varargin)
% F returns algebraic system F(g) = 0.
out = zeros(Nz*s,1);
for j = 1:s
   J = (j-1)*Nz+1:j*Nz;
	dg = zeros(Nz,1);
	for k = 1:s
		K = (k-1)*Nz+1:k*Nz;
		dg = dg + h*a(j,k)*feval(X, t+c(k)*h, g(K), varargin{:});		
	end
	out(J) = g(J) - z - dg; 
end
%--------------------------------------------------------------------------
function out = DF(g, DX, t, h, s, a, c, Nz, varargin)
% DF returns Jacobian matrix for F(g) = 0.
out = zeros(Nz*s);
for j = 1:s
   J = (j-1)*Nz+1:j*Nz;
   for k = 1:s
      K = (k-1)*Nz+1:k*Nz;
      out(J,K) = h*a(j,k)*feval(DX, t+c(k)*h, g(K), varargin{:});
   end
end
out = eye(Nz*s) - out;
%--------------------------------------------------------------------------
function [a, b, c] = abc(s)
% ABC returns coefficients for S-stage Gauss-Legendre methods. (From RKGL, 
% DiffMan package v.2 by K. Engo, A. Marthinsen & H. Munthe-Kaas.)
c = roots(slegendre(s));
c = sort(c);
V = vander(c);
V = V(:,s:-1:1);
J = diag(1./(1:s));
invV = inv(V);
a = diag(c)*V*J*invV;
b = (ones(1,s)*J*invV)';
%--------------------------------------------------------------------------
function Pn = slegendre(n)
% SLEGENDRE returns shifted Nth-order Legendre polynomials normalized in 
% the interval [0 1]. (From SLEGENDRE, DiffMan package v.2 by K. Engo, 
% A. Marthinsen & H. Munthe-Kaas.)
Pnm1 = [];
Pn = 1;
for m = 0:n-1
   A1n = m + 1;
   A2n = - 2*m - 1;
   A3n = 4*m + 2;
   A4n = - m;
   PnP1 = A2n*[0 Pn] + A3n*[Pn 0] + A4n*[0 0 Pnm1];
   PnP1 = PnP1/A1n;
   Pnm1 = Pn;
   Pn = PnP1;
end
%--------------------------------------------------------------------------
function xout = newton(sysfun, jacfun, xin, tol, maxiter, varargin)
% NEWTON solves nonlinear algebraic systems.
j = 0;
dx = tol + 1;
while (dx > tol) && (j <= maxiter)
   j = j + 1;
   F = feval(sysfun, xin, varargin{:});
   J = feval(jacfun, xin, varargin{:});
   xout = xin - J\F;
   dx = norm(xout-xin);
   xin = xout;
end