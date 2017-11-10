function y = fns(x)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

y = 0;
for i = 1:numel(x)
    y = y + ((ceil(abs(x(i)))^4) * floor(x(i)));
end

end

