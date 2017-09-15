function T = calcStaticTemp(M, gamma, T_0)
% 

T = T_0 / (1 + (((gamma - 1) / 2) * M^2));

end

