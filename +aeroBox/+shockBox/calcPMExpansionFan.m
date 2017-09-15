function M2 = calcPMExpansionFan(varargin)
%CALCPMEXPANSIONGAN Summary of this function goes here
%   Detailed explanation goes here

np = aeroBox.inputParser();
np.addRequired('mach', @isnumeric);
np.addRequired('gamma', @isnumeric);
np.addRequired('turningAngle', @isnumeric);
np.addParameter('useDegrees', 0, @isnumeric);
np.parse(varargin{:});

M1 = np.results.mach;
gamma = np.results.gamma;
useDeg = np.results.useDegrees;
theta = np.results.turningAngle;



if (useDeg == 1)
	theta = deg2rad(theta);
end

% Calculate the target angle
v1 = aeroBox.shockBox.prandtlMeyerFcn('mach', M1, 'gamma', gamma);
target = v1 + theta;

% Set the initial value to start solving, then solve iteratively
M2 = 0;
for i = 1:6
	step = 1 / (10^i);
	M2 = nestedSolve(M2);
	if (M2 >= 50)
		break;
	end
	M2 = M2 - step;
end

% Accelerated iterative solver
	function mach = nestedSolve(startAt)
		mach = startAt;
		vm = -inf;
		while (vm < target)
			mach = mach + step;
			vm = aeroBox.shockBox.prandtlMeyerFcn('mach', mach, 'gamma', gamma);
			if (mach >= 50)
				break;
			end
		end
	end

end

