function [f, gradf ] = q1_fx(x)
%Q1_FX Summary of this function goes here
%   Detailed explanation goes here

% f = x(1)^4 + x(2)^2 - x(1)^2 * x(2);
% 
% gradf(1, 1) = 4 * x(1)^3 - 2 * x(1) * x(2);
% gradf(2, 1) = 2 * x(2) - x(1)^2;
% 
% return;


f = 7.25 * x(1) * x(2);

gradf(1, 1) = 7.25 * x(2);
gradf(2, 1) = 7.25 * x(1);


end

