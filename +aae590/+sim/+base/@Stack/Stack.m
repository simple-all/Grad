classdef Stack < aae590.sim.Agent
    %STACK Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        stages = {};
        stageIndex = 0;
    end
    
    methods
        function addStage(obj, stage)
            obj.stages{end + 1} = stage;
        end
        
        function launch(obj, time)
            obj.activateStage(time);
            obj.lastTime = time;
        end
        
        function activateStage(obj, time)
            obj.stageIndex = obj.stageIndex + 1;
            obj.stages{obj.stageIndex}.activate(time);
        end
        
        function runAtTime(obj, time)
            dragCoeff = 0.25;
            [~, ~, density, ~] = aae590.atmosphere(obj.position(3) * 3.28, 1);
            density = density * 515.378819; % slugs/ft^3 to kg/m^3
            density = 1.225;
            speed = norm(obj.velocity);
            drag = 0.5 * density * speed^2 * (pi * (obj.stages{obj.stageIndex}.diameter / 2)^2) * dragCoeff;
            dragVect = -drag * obj.heading;
            thrust = obj.stages{obj.stageIndex}.getThrust(time);
            thrustVect = thrust * obj.heading;
            gravity = [0 0 -9.81];
            netAccel = gravity + (dragVect / obj.getMass(time)) + (thrustVect / obj.getMass(time));
            obj.velocity = obj.velocity + netAccel * (time - obj.lastTime);
            obj.position = obj.position + obj.velocity * (time - obj.lastTime);
            obj.lastTime = time;
        end
        
        function mass = getMass(obj, time)
            mass = 0;
            for i = obj.stageIndex:numel(obj.stages)
                mass = mass + obj.stages{i}.getMass(time);
            end
        end
    end
    
end

