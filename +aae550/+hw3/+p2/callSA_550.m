% Thomas Satterly
% AAE 550, HW 3
% Problem 2

close all;
clear all;

bounds = [-5.12, 5.12;
    -5.12, 5.12]; % upper and lower bounds

X0 = [-5; 5]; % initial design NOTE: this is a column vector

options = zeros(1,9); % set up options array for non-default inputs

options(1) = 15;  % initial temperature (default = 50)
options(6) = 0.3; % cooling rate (default = 0.5)
options(8) = 1e6; % Maximum number of iterations

[xstar,fstar,count,accept,oob]= aae550.hw3.p2.SA_550(@(x) aae550.hw3.Rastrigin(x),bounds,X0,options);
fprintf('\n');
disp(xstar);
