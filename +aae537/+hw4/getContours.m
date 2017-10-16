function [betas, CPRs, err] = getContours(M0)

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

betas  = linspace(0.01, 0.99, 150);
CPRs = linspace(1.01, 80, 150);
M5_b = 0.5;
A5_c = 15.645512875129334; % ft^2
z = numel(CPRs);
parfor j = 1:numel(betas)
    beta = betas(j);

    for i = 1:z
        CPR = CPRs(i);
        % Run engine solver
        [~, err(j, i)] = aae537.hw4.solveEngine(...
            'eta_c', eta_c, ...
            'eta_b', eta_b, ...
            'eta_t', eta_t, ...
            'eta_ab', eta_ab, ...
            'eta_n', eta_n, ...
            'h', h, ...
            'Tt4', Tt4_max, ...
            'Tt7', Tt7_max, ...
            'M0', M0, ...
            'q', q, ...
            'T0', T0, ...
            'CPR', CPR, ...
            'gamma', 1.33, ....
            'cp', cp, ...
            'm_dot', m_dot, ...
            'beta', beta, ...
            'R', R, ...
            'M5_b', M5_b, ...
            'A5_c', A5_c);
    end
end


end

