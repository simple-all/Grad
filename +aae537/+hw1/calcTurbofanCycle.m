function [Isp, SFC] = calcTurbofanCycle(CPR, BPR, FPR, gamma, cp, M)
%CALCTURBOFANCYCLE Summary of this function goes here
%   Detailed explanation goes here
if (M >= 1)
    Isp = nan;
    SFC = nan;
    return;
end
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

% Bypass Air Fan
Pt3f = Pt2 * FPR;
Tt3f = Tt2 * FPR^((gamma - 1) / gamma);

% Bypass air nozzle
P9f = P0;
Tt9f = Tt3f;
%V9f = sqrt(2 * cp * Tt3f * (1 - (P9f / Pt3f)^((gamma - 1) / gamma)));
V9f = sqrt(((Pt3f / P9f)^((gamma - 1) / gamma) - 1) * (2 / (gamma - 1))) * calcSoundSpeed(gamma, (P9f / Pt3f)^((gamma - 1) / gamma) * Tt3f);

% Core compressor
Pt3 = Pt2 * CPR;
Tt3 = Tt2 * CPR^((gamma - 1) / gamma);

% Core combustor
Tt3_f = (Tt3 * (9 / 5)) - 459.67;
f = ((cp / 4186.798188) * (Tt4_f - Tt3_f)) / Hb;
Pt4 = Pt3;

% Core turbine
Tt5 = Tt4 - Tt3f * (1 - (1 / FPR)^((gamma - 1) / gamma)) - Tt3 * (1 - (1 / CPR)^((gamma - 1) / gamma));
Pt5 = Pt4 * (Tt5 / Tt4) ^ (gamma / (gamma - 1));

% Core nozzle
P9 = P0;
%V9 = sqrt(2 * cp * Tt5 * (1 - (P9 / Pt5)^((gamma - 1) / gamma)));
V9 = sqrt(((Pt5 / P9)^((gamma - 1) / gamma) - 1) * (2 / (gamma - 1))) * calcSoundSpeed(gamma, (P9 / Pt5)^((gamma - 1) / gamma) * Tt5);


Isp = (((1 / f) + 1) * V9 + (1 / f) * BPR * V9f - (1 / f) * (1 + BPR) * V0) / 9.81; % s
SFC = 1 / Isp; % 1/s


end

