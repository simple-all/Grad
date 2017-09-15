function P2 = calcPressureAfterNormal(M, P1, gamma)
% Created by Thomas Satterly

P2 = P1 * (((2 * gamma * M^2) - (gamma - 1)) / (gamma + 1));

end

