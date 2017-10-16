function [Isp, SFC] = calcTurbojetCycle(CPR, gamma, cp, M)
%CALCTURBOFANCYCLE Summary of this function goes here
%   Detailed explanation goes here
import aae537.hw1.*;
q_stupidUnits = 1500; % psf
q = q_stupidUnits * 47.88025; % Pa
V0 = calcSoundSpeed(gamma, 273) * M;
P0 = (2 * q) / (gamma * M^2);
Pt0 = calcStagPressure(P0, gamma, M);
T0 = 273; % K
Tt0 = calcStagTemperature(T0, gamma, M);
Tt4_f = 2600; % F
Tt4 = (Tt4_f + 459.67) * (5 / 9); % K
Hb = 18500; % BTU/lbm


% Inlet
Pt2 = Pt0 * MilStd5008B(M);
Tt2 = Tt0;

% Compressor
Pt3 = Pt2 * CPR;
Tt3 = Tt2 * CPR^((gamma - 1) / gamma);

% Combustor
Tt3_f = (Tt3 * (9 / 5)) - 459.67;
f = ((cp / 4186.798188) * (Tt4_f - Tt3_f)) / Hb;
if (f <= 0)
    Isp = nan;
    SFC = nan;
    return;
end
Pt4 = Pt3;

% Turbine
Tt5 = Tt4 - ((Tt3 - Tt2) / (1 + f));
%Tt5 = Tt4 - Tt3 * (1 - (1 / CPR)^((gamma - 1) / gamma));
Pt5 = Pt4 * (Tt5 / Tt4) ^ (gamma / (gamma - 1));

% Nozzle
P9 = P0;
%V9 = sqrt(2 * cp * Tt5 * (1 - (P9 / Pt5)^((gamma - 1) / gamma)));
V9 = sqrt(((Pt5 / P9)^((gamma - 1) / gamma) - 1) * (2 / (gamma - 1))) * calcSoundSpeed(gamma, (P9 / Pt5)^((gamma - 1) / gamma) * Tt5);


Isp = (((1 / f) + 1) * V9 - (1 / f) * V0) / 9.81; % s
SFC = 1 / Isp; % 1/s

if ~isreal(Isp) || Isp <= 0
    Isp = nan;
    SFC = nan;
end
end

