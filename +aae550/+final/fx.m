function [f, gradf] = fx(angles, obj)
%FX Objective function and gradient definition
disp(angles);
ffx = @(x) 1 / obj.getBurnerThrust(x) * 1e6;
f = ffx(angles);

if nargout == 2
    grads = numel(angles);
    gradf = zeros(grads, 1);
    step = nuderst(1);
    parfor i = 1:grads
        mod = zeros(1, grads);
        mod(i) = step;
        gradf(i, 1) = (ffx(angles + mod) - f) / step;
    end
end

end

