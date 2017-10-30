%  Thomas Satterly
% AAE 550, HW 2
% SQP example, adapted for numeric gradients
clear all

L = 3.5; % m
sigma = 405e6; % Pa
rho = 7850; % kg/m^3
P = 55e3; % N
E = 250e9;  %Pa
grav = 9.81; % m/s^2

f_x = @(x) aae550.hw2.fx(x, L, sigma, rho, P, E, grav);
g_x = @(x) aae550.hw2.gx(x, L, sigma, rho, P, E, grav);



% no linear inequality constraints
A = [];
b = [];
% no linear equality constraints
Aeq = [];
beq = [];
% lower bounds (no explicit bounds in example)
lb = [ ];
% upper bounds (no explicit bounds in example)
ub = [];
% set options for medium scale algorithm with active set (SQP as described
% in class; these options do not include user-defined gradients
options = optimoptions('fmincon','Algorithm','sqp', 'Display','iter');
% initial guess  - note that this is infeasible
x0 = [0.02; 0.0012];
[x,fval,exitflag,output] = fmincon(f_x,x0,A,b,Aeq,beq,lb,ub, ...
    g_x,options)

% NOTES:  since this is a direct constrained minimization method, you
% should try several initial design points to be sure that you have not
% located a local minimum.