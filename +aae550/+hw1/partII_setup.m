% Thomas Satterly
% AAE 550
% HW 1, Part II

% Define known constants

E = 210000000; % kPa
sigma_a = 155000; % kPa
tau_a = 50000; % kPa
rho = 7800; % kg/m^3
w = 1.7; % kN/m
H = 8; % m
P = 5; % kN
do_max = 0.5; % m
do_min = 0.05; % m
di_max = 0.45; % m
di_min = 0.04; % m
dRat_max = 60;
t_max = 0.02; % m
t_min = 0.005; % m
delta_a = 0.1; % m

% Define constraint equations
g1 = @(x) 0.05 - x(2);
g2 = @(x) x(1) - 0.5;
g3 = @(x) 0.04 - x(2);
g4 = @(x) x(2) - 0.45;
g5 = @(x) (x(1) + x(2)) / (2 * (x(1) - x(2))) - 60;
g6 = @(x) 0.005 - x(1) + x(2);
g7 = @(x) x(1) - x(2) - 0.02;
g8 = @(x) (16 * (P + w * H) / (pi * (x(1)^4 - x(2)^4))) * (x(1)^2 + x(1) * x(2) + x(2)^2) - tau_a;
g9 = @(x) (32 * (P * H + 0.5 * w * H^2) / (pi * (x(1)^4 - x(2)^4))) * x(1) - sigma_a;
g10 = @(x) (64 / (pi * E * (x(1)^4 - x(2)^4))) * ((P * H^3) / 3 + (w * H^4) / 8) - delta_a;

% Define objective function
f = @(x) max(rho * (pi / 4) * (x(1)^2 - x(2)^2) * H, 0);

