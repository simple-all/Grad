function [vals, inds] = filterMin(x, n)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


for i = 1:n
    [val, ind] = min(x);
    vals(i) = val;
    inds(i) = ind;
    x(ind) = inf;
end

end

