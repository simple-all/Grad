function P2 = calcPressureAfterNormal(varargin)
% Created by Thomas Satterly

np = aeroBox.inputParser();
np.addRequired('mach', @isnumeric);
np.addRequired('gamma', @isnumeric);
np.addRequired('Ps', @isnumeic);
np.parse(varargin{:});

M = np.results.mach;
P1 = np.results.Ps;
gamma = np.results.gamma;

P2 = P1 * (((2 * gamma * M^2) - (gamma - 1)) / (gamma + 1));

end

