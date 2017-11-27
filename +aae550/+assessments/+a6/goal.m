close all;
clear;

f1 = @(x) (x(1) + x(2) - 8)^2 + 0.75 * (x(2) - x(1) + 3)^2;
f2 = @(x) 0.65 * (x(1) - 1)^2 + 0.75 * (x(2) - 4)^2;

f = @(x) [f1(x); f2(x)];

A = [];
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
nonlcon = @(x) aae550.assessments.a6.goalnonlcon(x);
x0 = [10; 10];

options = optimset('LargeScale', 'off', 'Algorithm', 'sqp');

[x1, f1_opt] = fmincon(f1, x0, A, b, Aeq, beq, lb, ub, nonlcon, options);
[x2, f2_opt] = fmincon(f2, x0, A, b, Aeq, beq, lb, ub, nonlcon, options);

x0 = [10; 10; 1];
phi = @(x) x(3);

w = [0.9 0.1];

nonlcon = @(x) aae550.assessments.a6.goalnonlcon(x, f1, f2, w, f1_opt, f2_opt);


[x_g, f_g] = fmincon(phi, x0, A, b, Aeq, beq, lb, ub, nonlcon, options);
f1(x_g)
f2(x_g)
