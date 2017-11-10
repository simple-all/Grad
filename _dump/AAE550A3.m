close all;
x = [-11 0 4];
y =AAE550A3_fn(x);

p = polyfit(x, y, 2);

xs = linspace(-20, 20, 100);
for i = 1:numel(xs)
    ys(i) = polyval(p, xs(i));
end

xMin = -p(2) / (2 * p(1));
yMin = polyval(p, xMin);

figure;
hold on;
plot(xs, ys);
plot(x, y, 'o');
plot(xMin, yMin, 'x');

x = [x, xMin];
y = [y, yMin];

[y, inds] = filterMin(y, 3);
x = x(inds);
y =AAE550A3_fn(x);

% X4
fprintf('X4: %0.5f\n', xMin);




p = polyfit(x, y, 2);

xs = linspace(-20, 20, 100);
for i = 1:numel(xs)
    ys(i) = polyval(p, xs(i));
end

xMin = -p(2) / (2 * p(1));
yMin = polyval(p, xMin);

figure;
hold on;
plot(xs, ys);
plot(x, y, 'o');
plot(xMin, yMin, 'x');
x = [x, xMin];
y = [y, yMin];

[y, inds] = filterMin(y, 3);
x = x(inds);
y =AAE550A3_fn(x);
% X5
fprintf('X5: %0.5f\n', xMin);



0
p = polyfit(x, y, 2);

xs = linspace(-20, 20, 100);
for i = 1:numel(xs)
    ys(i) = polyval(p, xs(i));
end

xMin = -p(2) / (2 * p(1));
yMin = polyval(p, xMin);

figure;
hold on;
plot(xs, ys);
plot(x, y, 'o');
plot(xMin, yMin, 'x');
x = [x, xMin];
y = [y, yMin];

[y, inds] = filterMin(y, 3);
x = x(inds);
y =AAE550A3_fn(x);
% X6
fprintf('X6: %0.5f\n', xMin);





p = polyfit(x, y, 2);

xs = linspace(-20, 20, 100);
for i = 1:numel(xs)
    ys(i) = polyval(p, xs(i));
end

xMin = -p(2) / (2 * p(1));
yMin = polyval(p, xMin);

figure;
hold on;
plot(xs, ys);
plot(x, y, 'o');
plot(xMin, yMin, 'x');
x = [x, xMin];
y = [y, yMin];

[y, inds] = filterMin(y, 3);
x = x(inds);
y =AAE550A3_fn(x);
% X7
fprintf('X7: %0.5f\n', xMin);
