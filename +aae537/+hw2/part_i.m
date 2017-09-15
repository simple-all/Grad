% Thomas Satterly
% AAE 537
% HW 1, Problem 1, Part (i)

import aeroBox.shockBox.*;

gamma = 1.4;
% Mach 2 conditions
rampAngle = 4; % degrees

% Solve for the total turning angle at the end when M_0 = 2
[shockAngle, M1] = calcObliqueShockAngle('rampAngle', rampAngle, 'mach', 2, 'gamma', gamma, 'useDegrees', 1);
v1 = aeroBox.shockBox.prandtlMeyerFcn('mach', M1, 'gamma', 1.4);
v2 = aeroBox.shockBox.prandtlMeyerFcn('mach', 1, 'gamma', 1.4);
isoRampTurning = rad2deg(v1 - v2);
totalTurning = isoRampTurning + rampAngle;