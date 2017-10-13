function bool = checkConstraints(gs, x)
%CHECKCONSTRAINTS Checks that all g <= 0 are met. Returns true if all met
bool = true;
for i = 1:numel(gs)
    if gs{i}(x) > 0
        bool = false;
        return;
    end
end

end

