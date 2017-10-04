function conjGrad(f, df, x0)

s = -df(x0);
x = x0;
options = optimoptions(@fminunc, 'Algorithm','quasi-newton', 'OptimalityTolerance', 1e-15);
while (1)
    s_last = s;
    x_last = x;
    % Line search for alpha
    f_alpha = @(alpha) f(x + alpha * s);
    alpha = fminunc(f_alpha, -1, options);
    x = x + alpha * s;
    beta = (norm(df(x)) / norm(df(x_last)))^2;
    s = -df(x) + beta * s_last;
end


end

