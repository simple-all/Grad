classdef Stage < handle
    %STAGE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        activationTime = []; % Ignition time (s)
        diameter = []; % Diameter (m)
        length = []; % Length (m)
    end
    
    methods
        function activate(obj, time)
            obj.activationTime = time;
        end
        
        function bool = isDone(obj, time)
            bool = 0;
        end
    end
    
    methods (Abstract)
        thrust = getThrust(obj, time);
        mass = getMass(obj, time);
    end
    
end

