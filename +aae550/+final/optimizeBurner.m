%  Thomas Satterly
% SQP

clear all
tic;
% L = 3.5; % m
% sigma = 405e6; % Pa
% rho = 7850; % kg/m^3
% P = 55e3; % N
% E = 250e9;  %Pa
% grav = 9.81; % m/s^2

%x0 = [11.8865   13.8865   15.8865   17.8865   19.8865   21.8865   23.8865   25.8865   27.8865   29.7339   30.8845   32.0303   33.1764   34.3221   35.4667   36.6099   37.7518   38.9479];
x0 = [9.6927  9.6927 14.6927  14.6927 15.3238  15.3238 14.1870  14.1870 11.4936  11.4936  8.1842  8.1842   6.8586 6.8586   3.0623 3.0623];
maxAngleDiff = 5;
minMach = 1.05;
minEndMach = 1.15;
memObj = aae550.final.memBurner();
f_x = @(angles) aae550.final.fx(angles, memObj);
g_x = @(angles) aae550.final.gx(angles, memObj, maxAngleDiff, minMach, minEndMach);

% no linear inequality constraints
A = [];
b = [];
% no linear equality constraints
Aeq = [];
beq = [];
% lower bounds (no explicit bounds in example)
lb = zeros(1, numel(x0));
% upper bounds (no explicit bounds in example)
ub = 40 * ones(1, numel(x0));
% set options for medium scale algorithm with active set (SQP as described
% in class; these options do not include user-defined gradients
options = optimoptions('fmincon','Algorithm','sqp', 'Display','iter-detailed', ...
    'SpecifyObjectiveGradient', true, ...
    'SpecifyConstraintGradient', true, ...
    'UseParallel', false);
% initial guess  - note that this is infeasible

[x,fval,exitflag,output] = fmincon(f_x,x0,A,b,Aeq,beq,lb,ub,g_x,options)
toc;
% NOTES:  since this is a direct constrained minimization method, you
% should try several initial design points to be sure that you have not
% located a local minimum.