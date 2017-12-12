classdef memBurner < handle
    % Memoized burner function
    properties
        fh; % Memoized function handle
    end
    methods
        
        function obj = memBurner()
            obj.fh = @(x) aae550.final.getBurnerThrust(x);
            try %#ok<TRYNC>
                obj.fh = memoize(obj.fh);
            end
        end
        
        function [Thrust, M, T] = getBurnerThrust(obj, angles)
            %MEMGETBURNERTHRUST Summary of this function goes here
            %   Detailed explanation goes here
            [Thrust, M, T] = obj.fh(angles);
        end
    end
end

