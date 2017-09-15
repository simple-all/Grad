function P2 = calcPressureAfterOblique(M, P1, theta, gamma, useDeg)
% Created by Thomas Satterly
% Calculates the static pressure after an oblique shock

if (useDeg == 1)
	theta = deg2rad(theta);
end

beta = calcObliqueAngle(theta, M, gamma, 0);

M_n = M * sin(beta);

P2 = calcPressureAfterNormal(M_n, P1, gamma);

end

