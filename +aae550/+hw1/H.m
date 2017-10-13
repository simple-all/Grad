function h = H(x, K, P)
% Thomas Satterly
% AAE 550
% HW 1, Problem 1

% Make sure all provided matricies are the correct dimension
assert(all(size(x) == [2, 1]));
assert(all(size(K) == [2, 2]));
assert(all(size(P) == [2, 1]));

h = K; % woo


end

