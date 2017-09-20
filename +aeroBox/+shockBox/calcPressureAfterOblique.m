function P2 = calcPressureAfterOblique(varargin)
% Created by Thomas Satterly
% Calculates the static pressure after an oblique shock

np = aeroBox.inputParser();
np.addRequired('rampAngle', @isnumeric);
np.addRequired('mach', @isnumeric);
np.addRequired('gamma', @isnumeric);
np.addParameter('useDegrees', 0, @isnumeric);
np.addParameter('Ps', @isnumeric)
np.parse(varargin{:});

theta = np.results.rampAngle;
M = np.results.mach;
gamma = np.results.gamma;
useDeg = np.results.useDegrees;
P1 = np.results.Ps;

if (useDeg == 1)
	theta = deg2rad(theta);
end

beta = aeroBox.shockBox.calcObliqueShockAngle('rampAngle', theta, 'mach', M, 'gamma', gamma);

M_n = M * sin(beta);

P2 = aeroBox.shockBox.calcPressureAfterNormal('mach', M_n, 'Ps', P1, 'gamma', gamma);

end

