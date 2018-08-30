function fh = RecordKeeper(g)
%RECORDKEEPER Summary of this function goes here
%   Detailed explanation goes here
goal = g;
numCounted = 0;
fh = @(states) subRecordKeeper(states);
    function [isDone, states] = subRecordKeeper(states)
        isDone = 0;
        if states(1)
            states(1) = 0;
            numCounted = numCounted + 1;
        else
            states(2) = ~states(2);
        end
        if numCounted == goal
            isDone = 1;
        end
    end
end

