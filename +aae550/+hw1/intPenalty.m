function phi_x = intPenalty(f, x, rp, gs)
%INTPENALTY Returns the psuedo-objective function value for int. penalty method

if nargin < 4
    gs = [];
end

P = 0;
for i = 1:numel(gs)
    P = P + (-1 / gs{i}(x));
end

phi_x = f(x) + rp * P;

end

