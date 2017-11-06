classdef LeaderBird < boids.agents.NetworkedBird
    %LEADERBIRD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function runAtTime(obj, time)
            runAtTime@boids.agents.Bird(obj, time);
            
            if obj.isRunTime(time)
                % Publish self's state many times for false weighting
                for i = 1:10
                    message.spatial = obj.spatial;
                    message.id = obj.id;
                    obj.publishToTopic(obj.dataTopic, message);
                end
            end
            
        end
    end
    
end

