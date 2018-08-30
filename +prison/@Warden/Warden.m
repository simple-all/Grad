classdef Warden < handle
    %WARDEN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        cellBlock;
        selected = [];
        numSelected = 0;
    end
    
    methods
        function obj = Warden(cb)
            obj.cellBlock = cb;
        end
        
        function inmate = getNextInmate(obj)
            iter = randi([1, obj.cellBlock.numInmates], 1);
            if ~any(iter == obj.selected)
                obj.numSelected = obj.numSelected + 1;
                obj.selected(obj.numSelected) = iter;
            end
            inmate = obj.cellBlock.inmates{iter};
        end
        
        function bool  = isDone(obj)
            bool = obj.numSelected == obj.cellBlock.numInmates;
        end
    end
    
end

