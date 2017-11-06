%  SLP example to solve in-class example from AAE 550 slide 13, class 17; 
%  last modified 01 Oct 2016 - Prof. Crossley
%
%  NOTES:  I have computed the analytic gradients for the example problem 
%  using a syntax compatible with fmincon.  The "while" loop used here 
%  will continue until the function value does not change by more than 
%  epsilon_f and the maximum constraint violation is less than epsilon_g or
%  epsilon_h and the fewer than 50 LP problems have been solved.  These 
%  particular values may need to be changed depending upon the problem 
%  being solved.  This example includes simple move limits.
%
%  written using Matlab R2012a

clear all
% convergence tolerance for change in function value between minimizations
epsilon_f = 1e-04;
% convergence tolerance for maximum inequality constraint value
epsilon_g = 1e-04;
% convergence tolerance for maximum equality constraint violation
epsilon_h = 1e-04;
% stopping criterion for maximum number of sequential minimizations
max_ii = 50;

% set options for linprog to use medium-scale algorithm
% also suppress display during loops
% Use dual-simplex algorithm if using Matlab R2016b or newer
options = optimoptions('linprog','Algorithm','simplex','Display','iter');
% options = optimoptions('linprog','Algorithm','dual-simplex','Display','iter');



% design variables:
x0 = [250; 150];   % initial design point 
% delta x values for move limits
delta_x = [55; 55];
% lower bounds from original problem - must enter values, use -Inf if none
lb = [-inf;-Inf];
% upper bounds from original problem - must enter values, use Inf if none
ub = [Inf;Inf];

% initial objective function and gradients
[f,gradf] = aae550.assessments.a5.q1_fx(x0);
% initial constraints and gradients; here, these have been computed 
% analytically and are available from example_con
[g, h, gradg, gradh] = aae550.assessments.a5.q1_gx(x0);

f_last = 1e+5;       % set first value of f_last to large number
ii = 0;              % set counter to zero

while (((abs(f_last - f) >= epsilon_f) | (max(g) >= epsilon_g) | ...
        (max(abs(h)) >= epsilon_h)) & (ii < max_ii))
    % increment counter
    ii = ii + 1   % no semi-colon to obtain output
    
    % store 'f_last' value
    f_last = f;
    
    % linearized objective function follows this format:
    % fhat = gradf(1) * x(1) + gradf(2) * x(2) 
    % linprog uses vector of coefficients as input; does not need constant 
    % term
    fhat = gradf;
    
    % linearized constraints follow this format:
    % ghat_i = gradg_i(1) * x(1) + gradg_i(2) * x(2) ...
    %   ... + (g_i(x0) - gradg_i(1) * x0(1) - gradg_i(2) * x0(2))
    % for linprog, these linear constraints are entered using A * x <= b 
    % format
    % note that Matlab will treat g and h as row vectors, so g' and h' here 
    % makes these column vectors to match class convention
    A = gradg';
    b = gradg' * x0 - g';  
    
    % the example problem has no equality constraints
    Aeq = [];
    beq = [];
    
    % move limits on LP problem (see slide 23-26 from class 17)
    % combines original problem bounds on x with move limits
    lb_LP = max(x0 - delta_x, lb);       
    ub_LP = min(x0 + delta_x, ub);        
    
    [x,fval,exitflag,output] = linprog(fhat,A,b,Aeq,beq,lb_LP,ub_LP,x0,...
        options);
    
    % This will only provide the solution to the current approximation.
    % At the new x, evaluate the original objective function, the original 
    % constraints and the gradients of these functions to build the next
    % approximation.  Compute the real function values at the current point,
    % set x0 for next approximation to the current x.
    x   % no semi-colon to obtain output
    [f,gradf] = aae550.assessments.a5.q1_fx(x);
    f   % no semi-colon to obtain output
    [g, h, gradg, gradh] = aae550.assessments.a5.q1_gx(x);
    g   % no semi-colon to obtain output
    h   % no semi-colon to obtain output
    
    x0 = x;
end
