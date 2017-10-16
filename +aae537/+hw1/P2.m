clc;
close all;
clear all;

import aae537.hw1.*;
q = [1000, 2000]; % psf

A = linspace(0, 160e3, 500); % Altitude (ft)
for i = 1:numel(A)
    for j = 1:numel(q)
        M(j, i) = calcMachAtQAndAlt(q(j), A(i));
    end
end

figure;
hold on;
plot(M(1, :), A);
plot(M(2, :), A);
legend('q = 1000 psf', 'q = 2000 psf');
xlabel('Mach No.');
ylabel('Altitude (ft)');
grid on;
title('Constant q trajectory, Mach v. Altitude');