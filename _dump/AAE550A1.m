function x = AAE550A1(x_0)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


err = inf;
x_new = x_0;
while err > 1e-7
    x = x_new;
    f = 12.7 - (3.88 * x) - (sqrt(7) * x^2) + (3 * x^4);
    df = -3.88 - (2 * sqrt(7) * x) + (12 * x^3);
    df2 = -2 * sqrt(7) + 36 * x^2;
    err = f;
    x_new = x - df / df2;
end

end

