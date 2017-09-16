% Thomas Satterly
% AAE 537
% HW 1, Problem 1

clear;
close all;

import aeroBox.shockBox.*;

gamma = 1.4;
% Mach 2 conditions
rampAngle = 4; % degrees

% Part (i)
% Solve for the total turning angle at the end when M_0 = 2
[shockAngle, M1] = calcObliqueShockAngle('rampAngle', rampAngle, ...
    'mach', 2, 'gamma', gamma, 'useDegrees', 1);
v1 = aeroBox.shockBox.prandtlMeyerFcn('mach', M1, 'gamma', 1.4);
v_end = aeroBox.shockBox.prandtlMeyerFcn('mach', 1, 'gamma', 1.4);
isoRampTurning = rad2deg(v1 - v_end);
totalTurning = isoRampTurning + rampAngle;
% End Part (i)


% Part (ii)
% Solve for conditions and geometry at mach 4

% Ramp section
[shockAngle, M1] = calcObliqueShockAngle('rampAngle', rampAngle, ...
    'mach', 4, 'gamma', gamma, 'useDegrees', 1);
v1 = aeroBox.shockBox.prandtlMeyerFcn('mach', M1, 'gamma', 1.4);
x(1) = 0;
x_0 = 1 / tand(shockAngle + rampAngle);
h_0 = 1; % Total inlet height (to cowl lip)
% Solve for h_w
slope1 = tand(rampAngle + asind(1 / M1));
slope2 = tand(rampAngle);
yInt1 = h_0 - slope1 * x_0;
yInt2 = 0;
x_w = (yInt2 - yInt1) / (slope1 - slope2);

h_w = 0.9;
mu_w = asind(1 / M1);
x_w = (h_0 - h_w) / tand(rampAngle);

% Isentropic spike section


startMach = M1;
endMach = aeroBox.shockBox.calcPMExpansionFan('mach', M1, 'gamma', 1.4, 'useDegrees', 1, 'turningAngle', -isoRampTurning);
numSteps = 200;
machs = linspace(startMach, endMach, numSteps - 1);

fAngle = asind(1 / endMach) + totalTurning;
fx = [0, x_0];
yInt = h_0 - x_0 * tand(fAngle);
fy = [yInt, h_0];

% M_enter = M1;
% lastSlope = tand(rampAngle);
% lastYInt = 0;
slope2 = tan(deg2rad(rampAngle));
yInt2 = 0;
for i = 1:numel(machs);
    thisMach = machs(i);
    mu = asin(1 / thisMach);
    v =  aeroBox.shockBox.prandtlMeyerFcn('mach', thisMach, 'gamma', 1.4);
    h(i) = h_w * (M1 / thisMach) * ((2 + (gamma - 1) * M1^2) / (2 + (gamma - 1) * thisMach^2))^-((gamma + 1) / (2 * (gamma - 1)));
    x(i) = x_0 - h(i) / (tan(mu + deg2rad(rampAngle) + v1 - v));
    
%     [shockAngle, M_enter] = calcObliqueShockAngle('rampAngle', angleStep, ...
%         'mach', M_enter, 'gamma', gamma, 'useDegrees', 1);
%     shockSlope = tand(shockAngle + (i * angleStep) + rampAngle);
%     yInt = h - (shockSlope * l);
%     x(1 + i) = (yInt - lastYInt) / (lastSlope - shockSlope);
%     y(1 + i) = shockSlope * x(1 + i) + yInt;
%     lastSlope = tand((i * angleStep) + rampAngle);
%     lastYInt = y(1 + i) - (lastSlope * x(1 + i));
end

x = [0, x_w, x];
y = h_0 - [h_0, h_w, h];

figure;
hold on;
plot(x, y);
plot(x_0, h_0, 'r*');
plot(fx, fy, 'g--');
axis equal;







