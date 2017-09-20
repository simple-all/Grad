function H = calcARatio(Ma, gamma)
% Calculates the sonic area ratio given macha and gamma
H = (1 / Ma) * ((2 + (gamma - 1) * (Ma^2)) / (gamma + 1))^((gamma + 1) / (2 * (gamma - 1)));

end

