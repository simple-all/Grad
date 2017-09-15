function rho = calcStaticDensity(M, gamma, rho_0)
% Calculates the static density of a supersonic flow

rho = rho_0 / ((1 + (((gamma - 1) / 2) * M^2))^(1 / (gamma - 1)));

end

