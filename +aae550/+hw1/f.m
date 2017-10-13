function [y, dy, ddy] = f(x, K, P)
% Thomas Satterly
% AAE 550
% HW 1, Problem 1

% Make sure all provided matricies are the correct dimension
assert(all(size(x) == [2, 1]));
assert(all(size(K) == [2, 2]));
assert(all(size(P) == [2, 1]));

y = 0.5 * x' * K * x - x' * P;

% Optional: Return derivatives if requested
if nargout >= 2
    dy = aae550.hw1.gradF(x, K, P);
end
if nargout >= 3
    ddy = aae550.hw1.H(x, K, P);
end
end

