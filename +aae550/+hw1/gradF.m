function dF = gradF(x, K, P)
% Thomas Satterly
% AAE 550
% HW 1, Problem 1

% Make sure all provided matricies are the correct dimension
assert(all(size(x) == [2, 1]));
assert(all(size(K) == [2, 2]));
assert(all(size(P) == [2, 1]));

x1 = x(1, 1);
x2 = x(2, 1);

dF(1, 1) = x(1, 1) * K(1, 1) + x2 * K(1, 2) - P(1, 1);
dF(2, 1) = x(2, 1) * K(2, 2) + x1 * K(1, 2) - P(2, 1);

dFF = x' * K - P;

end

