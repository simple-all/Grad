function P0 = calcStagPressure(M, gamma, P)
%

P0 = P * ((1 + (((gamma - 1) / 2) * M^2))^(gamma / (gamma - 1)));


end

