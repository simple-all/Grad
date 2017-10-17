% Thomas Satterly
% AAE 550
% HW 1, Problem 1, Part 8

k1 = 3000; 
k2 = 1000;
k3 = 2500;
k4 = 1500;
P1 = 500;
P2 = 1000;

K = [k1 + k2, -k2; -k2, k2 + k3 + k4];
P = [P1; P2];

x_opt = inv(K) * P;
fprintf('x*: [%0.6f; %0.6f]\n', x_opt(1), x_opt(2));