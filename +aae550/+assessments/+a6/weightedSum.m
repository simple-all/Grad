close all;
clear;

f1 = @(x) (x(1) - 4)^2 + (x(2) - 11)^2;
f2 = @(x) (x(1) - 8)^2 + (x(2) - 17.2)^2;

f = @(x) [f1(x); f2(x)];

A = [-5 -6; -3 4];
b = [-10; 10];
Aeq = [];
beq = [];
lb = [0; 0];
ub = [];
nonlcon = @(x) aae550.assessments.a6.wsnonlcon(x);
x0 = [10; 10];

options = optimset('LargeScale', 'off', 'Algorithm', 'sqp');

[x1, f1_opt] = fmincon(f1, x0, A, b, Aeq, beq, lb, ub, nonlcon, options);
[x2, f2_opt] = fmincon(f2, x0, A, b, Aeq, beq, lb, ub, nonlcon, options);


a = [0; 1];

phi = @(x) (a(1) * ((f1(x) - f1_opt) / abs(f1_opt))^2) + ...
    (a(2) * ((f2(x) - f2_opt) / abs(f2_opt))^2);

[x_ws, f_ws] = fmincon(phi, x0, A, b, Aeq, beq, lb, ub, nonlcon);

f1(x_ws)
f2(x_ws)


