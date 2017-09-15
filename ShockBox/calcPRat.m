function PRat = calcPRat(M, gamma)
% Calculates the stagnation pressure ratio from a normal shock

if (M <= 1)
	PRat = 1;
	return;
end

PRat = (((gamma + 1) * M^2) / ((gamma - 1) * M^2 + 2)) ^ (gamma / (gamma - 1));

PRat = PRat * (((gamma + 1) / (2 * gamma * M^2 - (gamma - 1))) ^ (1 / (gamma - 1)));

end

