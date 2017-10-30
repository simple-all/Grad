function [f, grad_f] = fx(x, L, sigma, rho, P, E, grav)
%Thomas Satterly. f(x) for AAE 550, HW 2


R = x(1);
t = x(2);

f = rho * pi * t * (2 * R - t) * L;

if nargout == 2
    grad_f(1, 1) = 2 * rho * pi * t * L;
    grad_f(2, 1) = 2 * rho * pi * L * (R - t);
end


end

