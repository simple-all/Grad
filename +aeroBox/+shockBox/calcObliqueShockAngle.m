function [beta, M2] = calcObliqueShockAngle(varargin)
% Created by Thomas Satterly
% Solves for the mach angle of an oblique shock wave withing 0.0001 radians

np = aeroBox.inputParser();
np.addRequired('rampAngle', @isnumeric);
np.addRequired('mach', @isnumeric);
np.addRequired('gamma', @isnumeric);
np.addParameter('useDegrees', 0, @isnumeric);
np.parse(varargin{:});

theta = np.results.rampAngle;
mach = np.results.mach;
gamma = np.results.gamma;
useDeg = np.results.useDegrees;

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

% Calculate the mach normal to the shock
M1_n = mach * sin(beta);

% Calculate the mach normal after the shock
M2_n = aeroBox.shockBox.calcMachAfterNormal('mach', M1_n, 'gamma', gamma);

% Calculate the mach after the shock
M2 = M2_n / sin(beta - theta);

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