function x = AAE550A2()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here





x = zeros(1, 4);
x(1) = -3;
x(2) = 3;
while abs(x(2) - x(1)) > 0.001
    [x(3), x(4)] = getPoints(x(1), x(2));
    f = fun(x);
    if f(3) < f(4)
        x(2) = x(4);
    else
        x(1) = x(3);
    end
end
disp('x');
disp(x);
disp('f');
disp(f);



end

function fx = fun(x)
    fx = 2 * x.^3 + 27 * x.^2 + 3;
end

function [p1, p2] = getPoints(min, max)
gr = (1 + sqrt(5)) / 2;
    dist = max - min;
    seg = dist / (gr + 1);
    p1 = min + seg;
    p2 = max - seg;
end
