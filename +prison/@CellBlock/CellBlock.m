classdef CellBlock < handle
    %CELLBLOCK Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        inmates = {};
        numInmates = 0;
    end
    
    methods
        function AddInmate(obj, inmate)
            obj.numInmates = obj.numInmates + 1;
            obj.inmates{obj.numInmates} = inmate;
            inmate.number = obj.numInmates;
        end
    end
    
end

