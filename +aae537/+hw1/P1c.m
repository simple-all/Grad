clc;
clear all;
close all;

import aae537.hw1.*;

M = linspace(0.01, 10, 500);

Turbofan = struct('Isp', [], 'SFC', []);
Turbojet = Turbofan;
AfterburningTurbojet = Turbofan;
Ramjet = Turbofan;
Scramjet = Ramjet;

cp = 1256; % J/kg*K
gamma = 1.4;

for i = 1:numel(M)
    [Turbofan.Isp(i), Turbofan.SFC(i)] = calcTurbofanCycle(30, 6, 2, gamma, cp, M(i));
    [Turbojet.Isp(i), Turbojet.SFC(i)] = calcTurbojetCycle(10, gamma, cp, M(i));
    [AfterburningTurbojet.Isp(i), AfterburningTurbojet.SFC(i)] = calcAfterburningTurbojetCycle(10, gamma, cp, M(i));
    [Ramjet.Isp(i), Ramjet.SFC(i)] = calcRamjetCycle(gamma, cp, M(i));
    [Scramjet.Isp(i), Scramjet.SFC(i)] = calcScramjetCycle(gamma, cp, M(i));
end

figure;
hold on;
plot(M, Turbofan.Isp);
plot(M, Turbojet.Isp);
plot(M, AfterburningTurbojet.Isp);
plot(M, Ramjet.Isp);
plot(M, Scramjet.Isp);

xlabel('Mach No.');
ylabel('Isp (s)');
title('Performance of Propulsion Systems');


legend('Turbofan', 'Turbojet', 'Afterburning Turbojet', 'Ramjet', 'Scramjet');