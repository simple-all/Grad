function theta = calcPMLimit(varargin)
%CALCPMLIMIT Summary of this function goes here
%   Detailed explanation goes here
np = aeroBox.inputParser();
np.addRequired('mach', @isnumeric);
np.addRequired('gamma', @isnumeric);
np.addParameter('useDegrees', 0, @isnumeric);
np.parse(varargin{:});

M1 = np.results.mach;
gamma = np.results.gamma;
useDeg = np.results.useDegrees;

v1 = aeroBox.shockBox.prandtlMeyerFcn('mach', M1, 'gamma', gamma);
vMax = (pi / 2) * (sqrt((gamma + 1) / (gamma - 1)) - 1);
theta = vMax - v1;
if useDeg
    theta = rad2deg(theta);
end

end

