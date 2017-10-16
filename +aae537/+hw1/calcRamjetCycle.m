function [Isp, SFC] = calcRamjetCycle(gamma, cp, M)
%CALCRAMJETCYCLE Summary of this function goes here
%   Detailed explanation goes here

if (M < 1.7)
    Isp = nan;
    SFC = nan;
    return;
end

import aae537.hw1.*;
V0 = calcSoundSpeed(gamma, 273) * M;
P0 = 101325; % Pa
Pt0 = calcStagPressure(P0, gamma, M);
T0 = 273; % K
Tt0 = calcStagTemperature(T0, gamma, M);
Tt4_f = 3500; % F
Tt4 = (Tt4_f + 459.67) * (5 / 9); % K
Hb = 18500; % BTU/lbm


% Inlet
Pt2 = Pt0 * MilStd5008B(M);
Tt2 = Tt0;

% Compressor
Pt3 = Pt2;
Tt3 = Tt2;

% Combustor
Tt3_f = (Tt3 * (9 / 5)) - 459.67;
f = ((cp / 4186.798188) * (Tt4_f - Tt3_f)) / Hb;
if (f <= 0)
    Isp = nan;
    SFC = nan;
    return;
end
Pt4 = Pt3;

% Nozzle
P9 = P0;
%V9 = sqrt(2 * cp * Tt5 * (1 - (P9 / Pt5)^((gamma - 1) / gamma)));
V9 = sqrt(((Pt4 / P9)^((gamma - 1) / gamma) - 1) * (2 / (gamma - 1))) * calcSoundSpeed(gamma, (P9 / Pt4)^((gamma - 1) / gamma) * Tt4);


Isp = (((1 / f) + 1) * V9 - (1 / f) * V0) / 9.81; % s
SFC = 1 / Isp; % 1/s

if ~isreal(Isp) || Isp <= 0
    Isp = nan;
    SFC = nan;
end

end

