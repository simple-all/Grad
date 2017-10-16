clc;
close all;
clear;

figure;
hold on;

M0 = [2, 2.5, 3, 3.5, 4];
for i = 1:numel(M0)
    [beta, CPR, err] =  aae537.hw4.getContours(M0(i));
    [C, cObj] = contour(CPR, beta, real((err + M0(i))), [M0(i), M0(i)]);
    clabel(C, cObj);
end

xlabel('CPR');
ylabel('\beta');
title('Feasible Design Space at Variable Mach');