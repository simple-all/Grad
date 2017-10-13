function phi_x = extPenalty(f, x, rp, gs, cs, hs)
%EXTPENALTY Returns the psuedo-objective function value for ext. penalty method

if nargin < 4
    gs = [];
end

if nargin < 5
    cs = ones(size(gs));
end

if nargin < 6
    hs = [];
end




P = 0;
for i = 1:numel(gs)
    P = P + cs(i) * max(0, gs{i}(x))^2;
end

for i = 1:numel(hs)
    P = P + hs{i}(x)^2;
end

phi_x = f(x) + rp * P;

end

