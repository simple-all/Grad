function P = calcStaticPressure(M, gamma, P_0)
%

P = P_0 / ((1 + (((gamma - 1) / 2) * M^2))^(gamma / (gamma - 1)));


end
