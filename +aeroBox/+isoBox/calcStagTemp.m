function T0 = calcStagTemp(varargin)

np = aeroBox.inputParser();
np.addRequired('mach', @isnumeric);
np.addRequired('gamma', @isnumeric);
np.addParameter('Ts', @isnumeric);
np.parse(varargin{:});

T = np.results.Ts;
gamma = np.results.gamma;
M = np.results.mach;

T0 = T * (1 + (((gamma - 1) / 2) * M^2));

end

