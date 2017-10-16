function M = calcMachAtQAndAlt(q, altitude)
%P2 Summary of this function goes here
%   Detailed explanation goes here

gamma = 1.4;
[~, p, ~, ~] = aae537.hw1.atmosphere(altitude, 0);% Rankine, slug/ft^3
M = sqrt(2 * q / (gamma * p)); % Mach

% T_K = T_R * (5 / 9); % K
% a = aae537.hw1.calcSoundSpeed(1.4, T_K); %m/s
% a = a / (12 * 0.0254); % ft/s
% M = V / a; % Mach
end

