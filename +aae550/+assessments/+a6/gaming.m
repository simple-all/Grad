close all;
clear;

f1 = @(x) x(1) + 1;
f2 = @(x) exp(x(2)) + 9;

f = @(x) [f1(x); f2(x)];

ep = [10.5, 17, 10, 5.5, 7, 8];

A = [-2 -3; 2 3];
b = [-6; 12];
Aeq = [];
beq = [];
lb = [];
ub = [];
nonlcon = @(x) aae550.assessments.a6.gnonlcon(x, f1, ep(6));
x0 = [1; 1];

options = optimset('LargeScale', 'off', 'Algorithm', 'sqp');

[x, f_opt] = fmincon(f2, x0, A, b, Aeq, beq, lb, ub, nonlcon, options);
disp(x);
disp(f_opt);