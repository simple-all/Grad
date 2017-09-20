function P = calcStaticPressure(varargin)

np = aeroBox.inputParser();
np.addRequired('mach', @isnumeric);
np.addRequired('gamma', @isnumeric);
np.addParameter('Pt', @isnumeric);
np.parse(varargin{:});

M = np.results.mach;
gamma = np.results.gamma;
P_0 = np.results.Pt;

P = P_0 / ((1 + (((gamma - 1) / 2) * M^2))^(gamma / (gamma - 1)));


end
