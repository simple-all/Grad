classdef Agent < handle
    %AGENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        position = [0, 0, 0]; % Location [m, m, m]
        velocity = [0, 0, 0]; % Velocity [m/s, m/s, m/s]
        heading = [0, 0, 1];
        lastTime = 0;
    end
    methods 
        function setHeading(obj, heading)
            obj.heading = heading / norm(heading);
        end
        
    end
    methods (Abstract)
        runAtTime(obj, time);
    end
    
end

