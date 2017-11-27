function [c, ceq] =goalnonlcon(x, f1, f2, w, f1_opt, f2_opt)

c(1, 1) = -3 + 5 * (x(1) - 2)^3 + x(2);
c(1, 2) = -4.25 - 2 * (x(2) - x(1) + 0.6)^2 + x(1) + x(2);
c(1, 3) = -x(1);
c(1, 4) = -x(2);


if nargin > 1
    c(1, 5) = (f1(x) - w(1) * x(3)) - f1_opt;
    c(1, 6) = (f2(x) - w(2) * x(3)) - f2_opt;
end
ceq = [];


end

