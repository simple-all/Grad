function rho_0 = calcStagDensity(M, gamma, rho)
% Calculates the stagnation density

rho_0 = rho * ((1 + (((gamma - 1) / 2) * M^2))^(1 / (gamma - 1)));

end

