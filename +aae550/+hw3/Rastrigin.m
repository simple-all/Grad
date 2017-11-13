function phi = NMfunc(x)
%NMFUNC Summary of this function goes here
%   Detailed explanation goes here

f = 10 * numel(x);
for i = 1:numel(x)
    f = f + (x(i)^2 - 10 * cos(2 * pi * x(i)));
end


g(1) = (x(1) / -5.12) - 1;
g(2) = (x(1) / 5.12) - 1;

g(3) = (x(2) / -5.12) - 1;
g(4) = (x(2) / 5.12) - 1;

P = 0;
for i = 1:numel(g)
    P = P + 10 * max(0,g(i));  % use c_j = 10 for all bounds
end
phi = f + P;

end

