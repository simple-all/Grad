close all;
clear all;

options = optimset('Display','iter');

x0 = [3.5; -3.5];

[x_star_1,fval_1,exitflag_1,output_1] = fminsearch(@(x) aae550.hw3.Rastrigin(x),x0,options);
[x_star_2,fval_2,exitflag_2,output_2] = fminsearch(@(x) aae550.hw3.Rastrigin(x),x_star_1,options);
fprintf('Run 1: x0=[%0.6f, %0.6f], numEvals = %d, x* = [%0.6f, %0.6f], f(x*) = %0.6f\n', x0(1), x0(2), output_1.funcCount, x_star_1(1), x_star_1(2), fval_1);
fprintf('Run 2: x0=[%0.6f, %0.6f], numEvals = %d, x* = [%0.6f, %0.6f], f(x*) = %0.6f\n', x_star_1(1), x_star_1(2), output_2.funcCount, x_star_2(1), x_star_2(2), fval_2);

