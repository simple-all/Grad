function M2 = calcMachAfterNormal(varargin)
% Returns the mach after a normal shock wave

np = aeroBox.inputParser();
np.addRequired('mach', @isnumeric);
np.addRequired('gamma', @isnumeric);
np.parse(varargin{:});

M1 = np.results.mach;
gamma = np.results.gamma;

M2 = ((gamma - 1) * M1^2) + 2;
M2 = M2 / ((2 * gamma * M1^2) - (gamma - 1));
M2 = sqrt(M2);

end

