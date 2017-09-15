function P2_0 = calcStagPressureAfterNormal(M1, gamma, P1_0)
% Calculates the stagnation pressure after a normal shock

P2_0 = (((gamma + 1) * (M1^2)) / (((gamma - 1) * (M1^2)) + 2))^(gamma / (gamma - 1));
P2_0 = P2_0 * ((gamma + 1) / ((2 * gamma * (M1^2)) - (gamma - 1)))^(1 / (gamma - 1));
P2_0 = P1_0 * P2_0;


end

