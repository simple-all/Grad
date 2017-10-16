% Thomas Satterly
% AAE 537
% Homework 4

% Basic setup scripts, defines parameters constant throughout the problem

h = 18500 * 778.169; % Kersone heating value, ft*lbf/lbm
eta_c = 0.88; % Compressor efficiency
eta_b = 0.95; % Burner efficiency
eta_t = 0.9; % Turbine efficiency
eta_ab = 0.9; % Afterburner efficiency
eta_n = 0.9; % Nozzle efficiency
cp = 0.3 * 778.169; % ft*lbd/lbm-degF
gamma = 1.33; % Ratio of specific heats
Tt4_max = 3000 + 459.67; % Degrees R
Tt7_max = 3700 + 459.67; % Degrees R
m_dot = 500; % lbm/sec
q = 1500; % lbf/ft^2
T0 = 491.4; % R at STP
R = 53.3533; % ft*lbf / lb*R