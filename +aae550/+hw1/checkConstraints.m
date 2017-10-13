function [bool, vals] = checkConstraints(gs, x)
%CHECKCONSTRAINTS Checks that all g <= 0 are met. Returns true if all met
bool = true;
for i = 1:numel(gs)
    vals(i) = gs{i}(x);
    if vals(i) > 0
        bool = false;
    end
end

end

