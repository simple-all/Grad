function [g, h, gradg, gradh] = q1_gx(x)
%Q1_GX Summary of this function goes here
%   Detailed explanation goes here
% 
% g(1, 1) = 1 - ((2 * x(1) * x(2)) / 3);
% g(1, 2) = ((3 * x(1)^2 - 4 * x(2)) / 3) + 1;
% 
% gradg(1, 1) = -2 * x(2) / 3;
% gradg(2, 1) = -2 * x(1) / 3;
% gradg(1, 2) = 6 * x(1) / 3;
% gradg(2, 2) = -4 / 3;
% h = [];
% gradh = [];
% return;

g(1, 1) = 1 - ((8 * x(1) * x(2)^2) / 66e6);
g(1, 2) = 1 - ((15 * x(1)^2 * x(2)) / 43e6);
g(1, 3) = -5 * x(1) + 6 * x(2);

gradg(1, 1) = -((8 * x(2)^2) / 66e6);
gradg(2, 1) = -((16 * x(1) * x(2)) / 66e6);

gradg(1, 2) = -((30 * x(1) * x(2)) / 43e6);
gradg(2, 2) = -((15 * x(1)^2) / 43e6);

gradg(1, 3) = -5;
gradg(2, 3) = 6;

h = [];
gradh = [];

end

