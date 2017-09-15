function [M2, beta, P2_0]   = solveObliqueShock(M1, gamma, theta, P1_0, useDeg)
% Created by Thomas Satterly
% Calculates the mach number after an oblique shock
% M1 = mach number before the shock
% theta = deflection angle
% gamma = specific heat ratio
% useDeg = 0 if input in radians, 1 if input in degrees

% Convert to degrees if specified
if (useDeg == 1)
	theta = deg2rad(theta);
end

% Calculate the shock angle
beta = calcObliqueAngle(theta, M1, gamma, 0);

% Calculate the upstream mach normal to the shock
M1_n = M1 * sin(beta);

% Calculate the stagnation pressure after the oblique shock
P2_0 = calcStagPressureAfterNormal(M1_n, gamma, P1_0);

% Calculate the mach normal after the shock
M2_n = calcMachAfterNormal(M1_n, gamma);

% Calculate the mach after the shock
M2 = M2_n / sin(beta - theta);

% Convert back to degrees if specified
if (useDeg == 1)
	beta = rad2deg(beta);
end

end

