classdef memBurner < handle
    
    properties
        fh
    end
    methods
        
        function obj = memBurner()
            obj.fh = @(x) aae550.final.getBurnerThrust(x);
            obj.fh = memoize(obj.fh);
        end
        
        function [Thrust, M] = getBurnerThrust(obj, angles)
            %MEMGETBURNERTHRUST Summary of this function goes here
            %   Detailed explanation goes here
            [Thrust, M] = obj.fh(angles);
        end
    end
end

