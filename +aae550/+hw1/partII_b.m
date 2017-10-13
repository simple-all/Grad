% Thomas Satterly
% AAE 550
% HW 1, Part II (b)
clear;
close all;

% Setup problem
aae550.hw1.partII_setup;

rp = 1e4;
maxErr = 1e-3;
err = inf;
fLast = inf;
x0 = [0.43; 0.42];
[isValid, gx] = aae550.hw1.checkConstraints(gs, x0);
assert(isValid, 'Starting point not valid!');
% Scale constraint equations at starting point to the same value
% cs = [1e4 1e4 1e4 1e4 1e4 1e4 1e2 1 1 1e3];
% cs = (min(gx)) ./ gx;
% for i = 1:numel(gs)
%     gs{i} = @(x) cs(i) * gs{i}(x);
% end

while err > maxErr
    
    % Create pseudo-objective function
    objFunc = @(x) aae550.hw1.intPenalty(f, x, rp, gs);
    
    options = optimoptions(@fminunc, 'Algorithm', 'quasi-newton', ...
        'Display', 'iter', 'PlotFcn', @optimplotfval, ...
        'MaxFunctionEvaluations', 1e5);
    
    [x_opt, f_opt, exitFlag, output, grad] = fminunc(objFunc, x0, options);
    [isValid, gx] = aae550.hw1.checkConstraints(gs, x_opt);
    assert(isValid, 'Constraints violated!');
    err = abs(f_opt - fLast);
    fLast = f_opt;
    x0 = x_opt;
    rp = rp / 10;
end

[~, gx] = aae550.hw1.checkConstraints(gs, x_opt);