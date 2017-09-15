function M2 = calcMachAfterOblique(M1, theta, gamma, useDeg)
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

% Calculate the mach normal to the shock
M1_n = M1 * sin(beta);

% Calculate the mach normal after the shock
M2_n = machAfterNormal(M1_n, gamma);

% Calculate the mach after the shock
M2 = M2_n / sin(beta - theta);

end

