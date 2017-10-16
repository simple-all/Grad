function Pt = calcStagPressure(P, gamma, M)
%CALCSTAGPRESSURE Summary of this function goes here
%   Detailed explanation goes here

Pt = P * (1 + ((gamma - 1) / 2) * M^2)^(gamma / (gamma - 1));

end

