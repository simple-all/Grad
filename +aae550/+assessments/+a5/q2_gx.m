function [g, h, gradg, gradh] = q2_gx(x)
%Q2_GX Summary of this function goes here
%   Detailed explanation goes here

h = [];
gradh = [];

g = x(1)^2 + x(2)^2 + x(3)^2 - 24;

gradg(1, 1) = 2 * x(1);
gradg(2, 1) = 2 * x(2);
gradg(3, 1) = 2 * x(3);

end

