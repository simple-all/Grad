% Test out orientation stuff
clear;
close all;

fig = figure;
ax = gca;
ax.Clipping = 'off';
hold on;
axis equal;

% Plot axis origin
axiMat = diag([1 1 1]) * 2;
for i = 1:3
    x = [0, axiMat(i, 1)];
    y = [0, axiMat(i, 2)];
    z = [0, axiMat(i, 3)];
    plot3(x, y, z);
end

% theta = linspace(-180, 180, 10);
% phi = linspace(-90, 90, 10);
% spin = linspace(0, 0, 10);
theta = 45;
phi = 0;
spin = 0;
for i = 1:numel(theta);
    %for j = 1:numel(phi)
    %   for k = 1:numel(spin)
            q = publicsim.util.orient.azEl2Quat(theta(i), phi(i), spin(i));
            publicsim.util.orient.plotArrow(fig, [0 0 0], q, 1);
    %    end
    %end
end

