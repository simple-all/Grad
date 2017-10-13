% Thomas Satterly
% AAE 550
% HW 1, Problem 1, Part 3a

import aae550.hw1.*;
close all;
clear;

k1 = 3000; 
k2 = 1000;
k3 = 2500;
k4 = 1500;
P1 = 500;
P2 = 1000;

K = [k1 + k2, -k2; -k2, k2 + k3 + k4];
P = [P1; P2];

x0 = [0; 0];

func = @(x) f(x, K, P);

options = optimoptions(@fminunc, 'Algorithm', 'quasi-newton', ...
    'GradObj', 'off', 'Display', 'iter');

[x_opt, f_opt, exitFlag, output, grad] = fminunc(func, x0, options);