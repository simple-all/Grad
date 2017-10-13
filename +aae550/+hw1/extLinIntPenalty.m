function phi_x = intPenalty(f, x, rp, gs, epsilon)
%INTPENALTY Returns the psuedo-objective function value for extended linear interior penalty method

if nargin < 4
    gs = [];
end

P = 0;
for i = 1:numel(gs)
    gi = gs{i}(x);
    if gi <= epsilon
        P = P + (-1 / gi);
    else
        P = P - ((2 * epsilon - gi) / epsilon^2);
    end
end

phi_x = f(x) + rp * P;

end

