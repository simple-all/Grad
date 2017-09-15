function rat = densityRatio(M, gamma)
% Calculates the density ratio from a normal shock

rat = ((gamma + 1) * M^2) / ((gamma - 1) * M^2 + 2);

end

