close all;
clear;

f1 = @(x) 3 * x(1)^2 - 3.75 * x(2)^2;
f2 = @(x) (4 * x(1)) / (3 * x(2));

f = @(x) [f1(x); f2(x)];

A = [];
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
nonlcon = @(x) aae550.assessments.a6.mmnonlcon(x);
x0 = [1; 1];

options = optimset('LargeScale', 'off', 'Algorithm', 'sqp');

[x1, f1_opt] = fmincon(f1, x0, A, b, Aeq, beq, lb, ub, nonlcon, options);
[x2, f2_opt] = fmincon(f2, x0, A, b, Aeq, beq, lb, ub, nonlcon, options);

a = [1 0];

phi = @(x) max((a(1) * ((f1(x) - f1_opt) / f1_opt)^2), ...
    (a(2) * ((f2(x) - f2_opt) / f2_opt)^2));

[x_mm, f_mm] = fmincon(phi, x0, A, b, Aeq, beq, lb, ub, nonlcon, options);

f1(x_mm)
f2(x_mm)

