function rho = calcStaticDensity(varargin)
% Calculates the static density of a supersonic flow

np = aeroBox.inputParser();
np.addRequired('mach', @isnumeric);
np.addRequired('gamma', @isnumeric);
np.addParameter('rho_t', @isnumeric);
np.parse(varargin{:});

M = np.results.mach;
gamma = np.results.gamma;
rho_0 = np.results.rho_t;

rho = rho_0 / ((1 + (((gamma - 1) / 2) * M^2))^(1 / (gamma - 1)));

end

