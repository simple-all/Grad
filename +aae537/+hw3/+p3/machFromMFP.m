function M = machFromMFP(varargin)
%SOLVEMFPFORMACH Summary of this function goes here
%   Detailed explanation goes here

np = aeroBox.inputParser();
np.addParameter('gamma', @isnumeric);
np.addParameter('R', @isnumeric);
np.addParameter('MFP', @isnumeric);
np.addOptional('isSonic', 0, @isnumeric)
np.parse(varargin{:});

gamma = np.results.gamma;
R = np.results.R;
MFP = np.results.MFP;

err = inf;
if np.results.isSonic
    M = 2;
else
    M = 0.5;
end

step = 0.1;
lastDir = 1;
tol = 1e-6;
while abs(err) > tol
    if err >  0
        M = M - step;
    else
        M = M + step;
    end
    
    if np.results.isSonic && M < 1
        M = 1;
    elseif ~np.results.isSonic && M > 1
        M = 1;
    end
    
    err = sqrt(gamma / R) * (M / ((1 + ((gamma - 1) / 2) * M^2)^((gamma + 1) / (2 * (gamma - 1))))) - MFP;
    if sign(err) ~= lastDir
        step = step / 2;
    end
    lastDir = sign(err);
end

end

