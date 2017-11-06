function [f, gradf] = q2_fx(x)
%Q2_FX Summary of this function goes here
%   Detailed explanation goes here

f = (x(1) - 3)^2 + (x(2) + 4)^2 + (x(3) + 1)^2;

gradf(1, 1) = 2 * (x(1) - 3);
gradf(2, 1) = 2 * (x(2) + 4);
gradf(3, 1) = 2 * (x(3) + 1);

end

