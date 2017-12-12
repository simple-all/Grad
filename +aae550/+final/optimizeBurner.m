%  Thomas Satterly
% SQP

clear all;
tic;

x0 = linspace(20, 20, 20);

maxAngleDiff = 5;
minMach = 1.05;
minEndMach = 1.15;
maxTemp = 2700;
memObj = aae550.final.memBurner();
f_x = @(angles) aae550.final.fx(angles, memObj);
g_x = @(angles) aae550.final.gx(angles, memObj, maxAngleDiff, minMach, minEndMach, maxTemp);

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

[x,fval,exitflag,output] = fmincon(f_x,x0,A,b,Aeq,beq,lb,ub,g_x,options);
toc;
