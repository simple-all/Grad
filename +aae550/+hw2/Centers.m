%  Thomas Satterly
% AAE 550, HW 2
% Method of Centers example, adapted

clear all

% Define constants
L = 3.5; % m
sigma = 405e6; % Pa
rho = 7850; % kg/m^3
P = 55e3; % N
E = 250e9;  %Pa
grav = 9.81; % m/s^2

% convergence tolerance for change in function value between minimizations
epsilon_f = 1e-04;
% convergence tolerance for maximum inequality constraint value
epsilon_g = 1e-04;
% convergence tolerance for maximum equality constraint violation
epsilon_h = 1e-04;
% stopping criterion for maximum number of sequential minimizations
max_ii = 1000;

% set options for linprog to use medium-scale algorithm
% also suppress display during loops
% Use dual-simplex algorithm if using Matlab R2016b or newer
options = optimoptions('linprog','Algorithm','dual-simplex','Display','iter');

% design variables:
x0 = [0.14; 0.008];   % initial design point 
% account for number of design variables
n = length(x0);
% delta x values for move limits
delta_x = [0.1; 0.01];
% lower bounds from original problem - must enter values, use -Inf if none
lb = [-Inf;-Inf];
% upper bounds from original problem - must enter values, use Inf if none
ub = [Inf;Inf];

% initial objective function and gradients
[f,gradf] = aae550.hw2.fx(x0, L, sigma, rho, P, E, grav);

% constraints of centers problem use gradients of objective and
% constraints and values of the constraint functions
[g, h, gradg, gradh] = aae550.hw2.gx(x0, L, sigma, rho, P, E, grav);

x_last = delta_x;
f_last = 1e+5;       % set first value of f_last to large number
ii = 0;              % set counter to zero
x = x0;
while (((abs(f_last - f) >= epsilon_f) | (max(g) >= epsilon_g)) ...
        & (ii < max_ii))
    % increment counter
    ii = ii + 1   % no semi-colon to obtain output

    x_diff_last = x - x_last;
    x_last = x;
    
    % store 'f_last' value
    f_last = f;
    
    % first approximation uses information from gradients of the objective
    % function and constraint functions to build the problem that searches
    % for the center of the hypersphere
    % objective of the hypersphere problem is to minimize -r (biggest
    % radius) 'linprog' uses coefficients of objective as input
    fcoeff = [zeros(n,1); -1];

    % first constraint for method of centers uses tangent to constant f(x);
    % remaining i through m constraints use tangent to g(x) = 0
    % for linprog, these linear constraints are entered using A * x <= b 
    % format first row of A is usability related constraint; first n 
    % columns are elements of gradf, n+1 column is norm of gradf
    use_A = [gradf', norm(gradf)];
    
    % remaining rows of A are feasibility related constraints; first n
    % columns are elements of gradg_j, n+1 column are norm of gradg_j
    colnormg = sqrt(sum(gradg.^2,1)); % 2-norm of each column in gradg
    feas_A = horzcat(gradg', colnormg');
    
    A = vertcat(use_A, feas_A);
    b = [0; -g'];
    
    % the MoC LP has no equality constraints
    Aeq = [];
    beq = [];
    
    % search variables for method of centers
    % s(1:n) used for update; s(n+1) = radius
    % initial guess and move limits
    s0 = zeros(n+1,1);
    % move limits on LP problem (see slide 23-26 from class 17)
    % combines original problem bounds on x with move limits
    % this keeps s values within move limits on x, and allows for
    % positive radius on hypersphere.  No upper bound needed for r,
    % so use Inf
    lb_LP = [max(-1*delta_x, (lb - x0)); 0];      
    ub_LP = [min(delta_x, (ub - x0)); Inf];      
    
    [s,radius] = linprog(fcoeff,A,b,Aeq,beq,lb_LP,ub_LP,s0,options);
    
    % This will only provide the search direction vector and the value of
    % the hypersphere radius.  Use update formula to find next x; then
    % compute new functions values, store x as new x0, increment counter
    % note:  the s vector here has n+1 elements; to update x, we only need 
    % s(1:n), s(n+1) is radius
    x = x0 + s(1:n)  % no semi-colon to obtain output
    [f,gradf] = aae550.hw2.fx(x, L, sigma, rho, P, E, grav);
    f = f * rho * pi * L;   % no semi-colon to obtain output
    [g, h, gradg, gradh] = aae550.hw2.gx(x, L, sigma, rho, P, E, grav);
    g   % no semi-colon to obtain output
    
    % Scale gradients to be on the order of the objective function
    % gradient
    %     for i = 1:size(gradg, 2)
    %         cj(i) = norm(gradf) / norm(gradg(:, i));
    %         newgradg(:, i) = cj(i) * gradg(:, i);
    %     end
%     %     gradg = newgradg;
%     
%     if all(g <= 0)
%         for i = 1:numel(x)
%             thisDiff = x(i) - x_last(i);
%             if (sign(thisDiff) ~= sign(x_diff_last(i))) && (abs(thisDiff) - abs(x_diff_last(i))) < 1e-3
%                 delta_x(i) = abs(thisDiff) / 2;
%             end
%         end
%     end
    
    x0 = x;
end