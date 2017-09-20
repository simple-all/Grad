function T = calcStaticTemp(varargin)
% 

np = aeroBox.inputParser();
np.addRequired('mach', @isnumeric);
np.addRequired('gamma', @isnumeric);
np.addParameter('Tt', @isnumeric);
np.parse(varargin{:});

M = np.results.mach;
gamma = np.results.gamma;
T_0 = np.results.Tt;

T = T_0 / (1 + (((gamma - 1) / 2) * M^2));

end

