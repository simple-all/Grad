function fh = DoOnlyOnce()
%DOEVERYONECE Summary of this function goes here
%   Detailed explanation goes here

    hasDone = 0;

    fh = @(states) subDoEveryOnce(states);

    function [isDone, states] = subDoEveryOnce(states)
        if ~hasDone && states(1) == 0
            states(1) = 1;
        else
            states(2) = ~states(2);
        end
        isDone = 0;
    end

end

