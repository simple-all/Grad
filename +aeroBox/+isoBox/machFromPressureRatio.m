function M = machFromPressureRatio(varargin)
%MACHFROMPRESSURERATIO Summary of this function goes here
%   Detailed explanation goes here

np = aeroBox.inputParser();
np.addRequired('Prat', @isnumeric);
np.addRequired('gamma', @isnumeric);
np.parse(varargin{:});

gamma = np.results.gamma;
Prat = np.results.Prat;

M = sqrt((2 / (gamma - 1)) * (Prat^(-(gamma - 1) / gamma) - 1));
end

