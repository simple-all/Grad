function mach = calcObliqueMach(theta, beta, gamma, useDeg)
% Created by Thomas Satterly
% Solves for the mach angle of an olbique shock wave withing 0.0001 radians

% If inputs were selected in degrees, convert to radians
if (useDeg == 1)
	theta = deg2rad(theta);
	beta = deg2rad(beta);
end

% Define start condition
machStart = 0;

% Find the singularity first...don't want to be getting weird answers
for i = 1:6
	step = 1 / (10^i);
	machStart = nestedSolve1(machStart);
	machStart = machStart - step;
end

machStart = machStart + step;

% Iterate over accuracy from 1e-1 to 1e-10
for i = 1:6
	step = 1 / (10^i);
	mach = nestedSolve2(machStart);
	machStart = mach - step;
end

% Nested accelerated solver # 1
	function M = nestedSolve2(startAt)
		M = startAt;
		guess = inf;
		while (guess > cot(theta))
			M = M + step;
			guess = tan(beta) * ((((gamma + 1) * M^2) / (2 * ((M^2) * (sin(beta)^2) - 1))) - 1);
		end
	end

end