function A = ALM(f, x, rp, gs, lambda)
%ALM Returns the psuedo-objective function value augmented Lagrange matrix
%method

if nargin < 4
    gs = [];
end

P = 0;
for i = 1:numel(gs)
    gx = gs{i}(x);
    psi = max(gx, -lambda(i) / (2 * rp));
    P = P + lambda(i) * psi + rp * psi^2;
end

A = f(x) + P;

end

