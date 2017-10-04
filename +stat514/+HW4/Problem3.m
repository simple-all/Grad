% Thomas Satterly
% STAT 514, HW 4
% Problem 3, Part C

clear;
close all;

% Transform and estimator functions
x = @(t) (t - 137.5) / 25;
P1 = @(t) 2 * x(t);
P2 = @(t) x(t)^2 - 1.25;
P3 = @(t) (10 / 3) * (x(t)^3 - 2.05 * x(t));

% Define range of temperatures to test
t = linspace(90, 180, 100);

% Full polynomial and significant terms polynomial functions
f = @(t) 21.64 + 0.178 * P1(t) + 0.9 * P2(t) - 0.094 * P3(t);
f_sig = @(t) 21.64 + 0.178 * P1(t) + 0.9 * P2(t);

% Calculate polynomial values over the defined range
for i = 1:numel(t)
    y(i) = f(t(i));
    y_sig(i) = f_sig(t(i));
end

% Import observed data
data = importdata('+stat514\+HW4\temperature.dat');

% Convert from assigned test values to true temperature
tVals = [1, 2, 3, 4];
trueT = [100, 125, 150, 175];
for i = 1:numel(tVals)
    data(data(:, 1) == tVals(i)) = trueT(i);
end

% Find the minimum density from the significant terms calculations
[val, ind] = min(y_sig);

% Plot
figure;
hold on;
plot(data(:, 1), data(:, 2), '*');
plot(t, y);
plot(t, y_sig);
plot(t(ind), val, '*');
text(t(ind) + 2, val - 0.15, sprintf('t: %0.2f, f(t): %0.2f', t(ind), val));
legend('Observed Data', 'Full Polynomial', 'Significant Terms', 'Minimum Density');
xlabel('Firing Temperature');
ylabel('Brick Density');

