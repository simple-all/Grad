% Thomas Satterly
% STAT 514, HW 8

% Full regression from SAS
% f = @(x1, x2, t) -549.1 + 132.5 * x1 - 0.93333 * x2 + 9.30889 * t +...
%     -2.36222 * x1 * t - 0.0422 * x2 * t +...
%     -0.03252 * t^2 + 0.01044 * x1 * t^2 + 0.00019556 * x2 * t^2;

% % Regression split up between glass types
f1 = @(t) -416.6 + 6.9467 * t - 0.0221 * t^2;
f2 = @(t) -550.0333 + 9.2667 * t - 0.0323 * t^2;
f3 = @(t) -680.6667 + 11.7133 * t - 0.0432 * t^2;

% Temperature space
temps = linspace(100, 150, 50);

% Raw data
t = [100 100 100 125 125 125 150 150 150];
g1 = [58 56.8 57 107 106.7 106.5 129.2 128 128.6];
g2 = [55 53 57.9 107 103.5 105 117.8 116.2 109.9];
g3 = [54.6 57.5 59.9 106.5 107.3 108.6 101.7 105.4 103.9];

for i = 1:numel(temps)
    y11(i) = f1(temps(i));
    y22(i) = f2(temps(i));
    y33(i) = f3(temps(i));
end

% Plot
figure;
subplot(3, 1, 1);
hold on;
plot(temps, y11);
plot(t, g1, 'o');
title('Glass 1');
xlabel('Temperature');
ylabel('Output');

subplot(3, 1, 2);
hold on;
plot(temps, y22);
plot(t, g2, 'o');
title('Glass 2');
xlabel('Temperature');
ylabel('Output');

subplot(3, 1, 3);
hold on;
plot(temps, y33);
plot(t, g3, 'o');
title('Glass 3');
xlabel('Temperature');
ylabel('Output');


