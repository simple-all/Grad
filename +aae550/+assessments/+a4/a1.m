clear;
close all;
import aae550.assessments.a4.*;

% df_dx1 = @(x) 4 * x(1)^3 - 2 * x(1) * x(2);
% df_dx2 = @(x) 2 * x(2) - x(1)^2;
% df = @(x) [df_dx1(x), df_dx2(x)];
% 
% f = @(x) (x(1)^4) + (x(2)^2) - ((x(1)^2) * x(2));
% 
% conjGrad(f, df, [-2 4]);

df_dx1 = @(x) 24 * x(1)^3 - 6 * x(1) * x(2) + 4 * x(1) - 6;
df_dx2 = @(x) -3 * x(1)^2 + 2 * x(2);
df = @(x) [df_dx1(x), df_dx2(x)];

f = @(x) 6 * x(1)^4 - 3 * x(1)^2 * x(2) + x(2)^2 + 2 * x(1)^2 - 6 * x(1) + 15;

df2_dx1_2 = @(x) 72 * x(1)^2 - 6 * x(2) + 4;
df2_dx1x2 = @(x) -6 * x(1);
df2_dx2_2 = @(x) 2;
H = @(x) [df2_dx1_2(x), df2_dx1x2(x); ...
    df2_dx1x2(x), df2_dx2_2(x)];

%conjGrad(f, df, [-1 3]);
g1 = @(x) 0.125 * x(1)^2 + (1 / 6) * x(2)^2 - 1;
g2 = @(x) 2 - x(1);
g3 = @(x) -x(2);
f = @(x) 6 * x(1)^2 + 13 * x(2)^2 - 3 * x(1) * x(2);


