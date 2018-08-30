classdef Inmate < handle
    %INMATE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        number;
        switchFunc;
    end
    
    methods
        function obj = Inmate(funcHandle)
            obj.switchFunc = funcHandle;
        end
        
        function [isDone, states] = interact(obj, states)
            [isDone, states] = obj.switchFunc(states);
        end
    end
    
end

