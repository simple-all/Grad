classdef InertStage < aae590.sim.base.Stage
    %INERTSTAGE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        mass;
    end
    
    methods
        function obj = InertStage(mass, diameter, length)
            obj.mass = mass;
            obj.diameter = diameter;
            obj.length = length;
        end
        
        function mass = getMass(obj, ~)
            mass = obj.mass;
        end
        
        function thrust = getThrust(~, ~)
            thrust = 0;
        end
    end
    
end

