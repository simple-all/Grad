% Thomas Satterly
% AAE 550
% HW 1, Part II (b)

aae550.hw1.partII_setup;
rp = 1e10;
x0 = [0.4; 0.385];
for i = 1:40

% Define penalty coefficient
epsilon = -0.2;
% Create pseudo-objective function
objFunc = @(x) aae550.hw1.extLinIntPenalty(f, x, rp, {g1, g2, g3, g4, g5, g6, ...
    g7, g8, g9, g10}, epsilon);

options = optimoptions(@fminunc, 'Display', 'iter', 'PlotFcn', @optimplotfval);

[x_opt, f_opt, exitFlag, output, grad] = fminunc(objFunc, [0.4; 0.35], options);
%assert(f_opt == f(x_opt), 'Constraint violated in solution!');
x0 = x_opt;
rp = rp / 2;
end