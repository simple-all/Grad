% Thomas Satterly
% AAE 550
% HW 1, Part II (a)
clear;
close all;
clc;

% Setup problem
aae550.hw1.partII_setup;

x = linspace(0.28, 0.48, 500);
[x1, x2] = meshgrid(x, x);

for i = 1:size(x1, 1)
    for j = 1:size(x1, 2)
        y(i, j) = f([x1(i, j); x2(i, j)]);
        for k = 1:numel(gs)
            gy(i, j, k) = gs{k}([x1(i, j); x2(i, j)]);
        end
    end
end


figure;
hold on;
for i = 1:numel(gs)
    [C, h] = contour(x1, x2, gy(:, :, i), [0, 0], 'LineColor', 'k');
end

for i = 1:size(y, 1)
    for j = 1:size(y, 2)
        isValid = 1;
        for k = 1:numel(gs)
            if gy(i, j, k) > 0
                isValid = nan;
                break;
            end
        end
        yVal(i, j) = isValid * y(i, j);
    end
end
surf(x1, x2, yVal,'LineStyle', 'none');

val = min(yVal(~isnan(yVal)));
[a, b] = find(yVal == val);
xOpt = [x1(a, b); x2(a, b)];
