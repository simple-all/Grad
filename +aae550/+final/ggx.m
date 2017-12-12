function [g, h] = ggx(angles, obj, maxAngleDiff, minMach, minEndMach, maxTemp)
%GX Nonlinear constraint function


% Assert that sequential angles differ by less than 2 degrees
% There should be (n - 1) * 2 contraints for this section
for i = 1:numel(angles) - 1
    g(1, (i * 2) - 1) = ((angles(i) - angles(i + 1)) / maxAngleDiff) - 1;
    g(1, i * 2) = ((angles(i + 1) - angles(i)) / maxAngleDiff) - 1;
end

% Assert the minimum Mach 
[~, M, T] = obj.getBurnerThrust(angles);
startInd = size(g, 2);
for i = 1:numel(M)
    g(1, startInd + i) = 1 - (M(i) / minMach);
end

% Assert maximum temperature
startInd = size(g, 2);
for i = 1:numel(T)
    g(1, startInd + i) = (T(i) / maxTemp) - 1;
end

% Assert the minimum end Mach
g(1, size(g, 2) + 1) = 1 - (M(end) / minEndMach);

h = [];

end

