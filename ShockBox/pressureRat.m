function rat = pressureRat(M, gamma)
% Calculates the pressure ratio across a normal shock
rat = (2 * gamma * M^2 - (gamma - 1)) / (gamma + 1);

end

