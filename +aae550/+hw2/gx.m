function [g, h, grad_g, grad_h] = gx(x, L, sigma, rho, P, E, grav)
%Thomas Satterly. g(x) for AAE 550, HW 2

R = x(1);
t = x(2);

g(1, 1) = 1 - (R / 0.02);
g(1, 2) = (t / 0.2) - 1;
g(1, 3) = 1 - (t / 0.001);
g(1, 4) = (t / 0.01) - 1;
g(1, 5) = R - 18 * t;
g(1, 6) = (5 * rho * (2 * R - t) * grav * L^3 - 0.384 * E * R^3);
g(1, 7) = (P - pi * t * (2 * R - t) * sigma) / P;

if nargout >= 2
    h = []; % No equality constraints
end

if nargout >= 3
    grad_g(1, 1) = -1 / 0.02;
    grad_g(2, 1) = 0;
    
    grad_g(1, 2) = 1 / 0.2;
    grad_g(2, 2) = 0;
    
    grad_g(1, 3) = 0;
    grad_g(2, 3) = -1 / 0.001;
    
    grad_g(1, 4) = 0;
    grad_g(2, 4) = 1 / 0.01;
    
    grad_g(1, 5) = 1;
    grad_g(2, 5) = -18;
    
    grad_g(1, 6) = (10 * rho * grav * L^3 - 1.152 * E * R^2);
    grad_g(2, 6) = (-5 * rho * grav * L^3);
    
    grad_g(1, 7) = -2 * pi * t * sigma / P;
    grad_g(2, 7) = -2 * pi * sigma * (t - R) / P;
end

if nargout >= 4
    grad_h = []; % No equality constraints
end


end

