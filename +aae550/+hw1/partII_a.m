% Thomas Satterly
% AAE 550
% HW 1, Part II (a)
clear;
close all;

aae550.hw1.partII_setup;
gs = {g1, g2, g3, g4, g5, g6, g7, g8, g9, g10};

% Define penalty coefficient
rp = 1e7;
maxErr = 1e-3;
err = inf;
fLast = inf;
x0 = [0.4; 0.385];
while err > maxErr
    
    % Create pseudo-objective function
    objFunc = @(x) aae550.hw1.extPenalty(f, x, rp, gs);
    
    options = optimoptions(@fminunc, 'Display', 'iter', 'PlotFcn', @optimplotfval);
    
    [x_opt, f_opt, exitFlag, output, grad] = fminunc(objFunc, [0.4; 0.35], options);
    assert(aae550.hw1.checkConstraints(gs, x_opt), 'Constraints violated!');
    err = abs(f_opt - fLast);
    fLast = f_opt;
    x0 = x_opt;
    rp = rp * 10;
end