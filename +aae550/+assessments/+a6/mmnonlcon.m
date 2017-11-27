function [c, ceq] =mmnonlcon(x)

c(1, 1) = -x(1) - 1;
c(1, 2) = x(1) - 2;
c(1, 3) = -x(2) + 1;
c(1, 4) = x(2) - 2;
ceq = [];


end

