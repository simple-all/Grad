function beta = calcObliqueAngle(theta, mach, gamma, useDeg)
% Created by Thomas Satterly
% Solves for the mach angle of an oblique shock wave withing 0.0001 radians

% If inputs were selected in degrees, convert to radians
if (useDeg == 1)
	theta = deg2rad(theta);
end

% Define start condition
betaStart = 0;

% Iterate over accuracy from 1e-1 to 1e-10
for i = 1:10
	step = 1 / (10^i);
	beta = nestedSolve(betaStart);
	betaStart = beta - step;
end

% If inputs were selected in degrees, convert back to degrees
if (useDeg == 1)
	beta = rad2deg(beta);
end

% Nested accelerated solver
	function beta = nestedSolve(startAt)
		beta = startAt;
		guess = -inf;
		while (guess < tan(theta))
			beta = beta + step;
			guess = 2 * cot(beta) * ((((mach^2) * (sin(beta)^2)) - 1) / (((mach^2) * (gamma + cos(2 * beta))) + 2));
		end
	end

end