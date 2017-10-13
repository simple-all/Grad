function phi_x = extPenalty(f, x, rp, gs, hs)
%EXTPENALTY Returns the psuedo-objective function value for ext. penalty method

if nargin < 5
    hs = [];
end

if nargin < 4
    gs = [];
end

P = 0;
for i = 1:numel(gs)
    P = P + max(0, gs{i}(x))^2;
end

for i = 1:numel(hs)
    P = P + hs{i}(x)^2;
end

phi_x = f(x) + rp * P;

end

