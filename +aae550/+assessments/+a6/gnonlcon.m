function [c, ceq] = gnonlcon(x, f, ep)

c(1, 1) = -x(1);
c(1, 2) = -x(2);
c(1, 3) = x(2) - 2;
c(1, 4) = f(x) - ep;
ceq = [];


end

