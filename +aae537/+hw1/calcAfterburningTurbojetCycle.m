function [Isp, SFC] = calcAfterburningTurbojetCycle(CPR, gamma, cp, M)
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
Tt6_f = 3500; % F
Tt6 = (Tt6_f + 459.67) * (5 / 9); % K
Hb = 18500; % BTU/lbm


% Inlet
Pt2 = Pt0 * MilStd5008B(M);
Tt2 = Tt0;

% Compressor
Pt3 = Pt2 * CPR;
Tt3 = Tt2 * CPR^((gamma - 1) / gamma);

% Combustor
Tt3_f = (Tt3 * (9 / 5)) - 459.67;
f_c = ((cp / 4186.798188) * (Tt4_f - Tt3_f)) / Hb;
if (f_c <= 0)
    Isp = nan;
    SFC = nan;
    return;
end
Pt4 = Pt3;

% Turbine
Tt5 = Tt4 - ((Tt3 - Tt2) / (1 + f_c));
Pt5 = Pt4 * (Tt5 / Tt4) ^ (gamma / (gamma - 1));

% Afterburner

Tt5_f = (Tt5 * (9 / 5)) - 459.67;
f_ab = ((cp / 4186.798188) * (Tt6_f - Tt5_f)) / Hb;
Pt6 = Pt5;

f = f_c + f_ab;
% Nozzle
P9 = P0;
%V9 = sqrt(2 * cp * Tt6 * (1 - (P9 / Pt6)^((gamma - 1) / gamma)));
V9 = sqrt(((Pt6 / P9)^((gamma - 1) / gamma) - 1) * (2 / (gamma - 1))) * calcSoundSpeed(gamma, (P9 / Pt6)^((gamma - 1) / gamma) * Tt6);


Isp = (((1 / f) + 1) * V9 - (1 / f) * V0) / 9.81; % s
SFC = 1 / Isp; % 1/s

if ~isreal(Isp) || Isp <= 0
    Isp = nan;
    SFC = nan;
end
end

