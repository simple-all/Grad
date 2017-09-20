function P0 = calcStagPressure(varargin)
%

np = aeroBox.inputParser();
np.addRequired('mach', @isnumeric);
np.addRequired('gamma', @isnumeric);
np.addParameter('Ps', @isnumeric);
np.parse(varargin{:});

M = np.results.mach;
gamma = np.results.gamma;
P = np.results.Ps;

P0 = P * ((1 + (((gamma - 1) / 2) * M^2))^(gamma / (gamma - 1)));


end

