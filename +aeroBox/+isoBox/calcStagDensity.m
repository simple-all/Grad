function rho = calcStagDensity(varargin)
% Calculates the static density of a supersonic flow

np = aeroBox.inputParser();
np.addRequired('mach', @isnumeric);
np.addRequired('gamma', @isnumeric);
np.addParameter('rho', @isnumeric);
np.parse(varargin{:});

M = np.results.mach;
gamma = np.results.gamma;
rho = np.results.rho_t;

rho = rho * ((1 + (((gamma - 1) / 2) * M^2))^(1 / (gamma - 1)));

end

