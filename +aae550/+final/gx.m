function [g, h, gradg, gradh] = gx(angles, obj, maxAngleDiff, minMach, minEndMach, maxTemp)
%GX Summary of this function goes here
%   Detailed explanation goes here

ggx = @(x) aae550.final.ggx(x, obj, maxAngleDiff, minMach, minEndMach, maxTemp);
[g, h] = ggx(angles);

if nargout == 4
    grads = numel(angles);
    gradg = zeros(grads, size(g, 2));
    step = nuderst(1);
    parfor i = 1:grads
        mod = zeros(1, grads);
        mod(i) = step;
        gradg(i, :) = (ggx(angles + mod) - g) / step;
    end
end

gradh = [];

end

