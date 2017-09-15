function M2 = machAfterNormal(M1, gamma)
% Returns the mach after a normal shock wave

M2 = ((gamma - 1) * M1^2) + 2;
M2 = M2 / ((2 * gamma * M1^2) - (gamma - 1));
M2 = sqrt(M2);

end

