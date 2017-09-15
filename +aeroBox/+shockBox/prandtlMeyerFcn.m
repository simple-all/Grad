function v = prandtlMeyerFcn(varargin)
%PRANDTLMEYER Summary of this function goes here
%   Detailed explanation goes here

np = aeroBox.inputParser();
np.addRequired('mach', @isnumeric);
np.addRequired('gamma', @isnumeric);
np.parse(varargin{:});

M1 = np.results.mach;
gamma = np.results.gamma;

v = sqrt((gamma + 1) / (gamma - 1)) * ...
    atan(sqrt((gamma - 1) / (gamma + 1) * (M1^2 - 1))) - ...
    atan(sqrt(M1^2 - 1));

end

