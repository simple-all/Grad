classdef NetworkedBird < boids.agents.Bird & publicsim.agents.base.Networked
    %OBSERVINGBIRD Bird that uses network messages to flock
    
    properties
        universalTopicKey = 'birdie';
    end
    
    properties(SetAccess = private)
        dataTopic;
    end
    
    methods
        
        function obj = NetworkedBird()
            obj@boids.agents.Bird();
        end
        
        function init(obj)
            init@boids.agents.Bird(obj);
            
            % Subscribe to topic
            obj.setDataTopic(obj.getDataTopic(obj.universalTopicKey, [], []));
            obj.subscribeToTopic(obj.dataTopic);
            obj.runTime = 2;
        end
        
        function setDataTopic(obj, topic)
            obj.dataTopic = topic;
        end
        
        function runAtTime(obj, time)
            if obj.isRunTime(time)
                % Publish self's state
                message.spatial = obj.spatial;
                message.id = obj.id;
                obj.publishToTopic(obj.dataTopic, message);
                
                % Get any new data
                [~, rxData] = obj.getNewMessages();
                % For each birds (that is not self), get the location and
                % direction
                
                if ~isempty(rxData)
                    idx = 0;
                    positions = [];
                    for i = 1:numel(rxData)
                        if rxData{i}.id ~= obj.id
                            birdPosition = rxData{i}.spatial.position();
                            birdPosition = boids.funcs.flocking.unwrapPositions(obj, birdPosition);
                            perceptionVector = birdPosition - obj.spatial.position;
                            perceptionAngle = acosd(dot(perceptionVector, obj.spatial.velocity) / ...
                                (norm(perceptionVector) * norm(obj.spatial.velocity)));
                            if (norm(birdPosition - obj.spatial.position) < obj.maxDist) && ...
                                    abs(perceptionAngle) < obj.maxAngle
                                idx = idx + 1;
                                positions(idx, :) = birdPosition; %#ok<AGROW>
                                velocities(idx, :) = rxData{i}.spatial.velocity(); %#ok<AGROW>
                            end
                        end
                    end
                    
                    if ~isempty(positions)
                        newState = boids.funcs.flocking.getNewStateFromFlock(obj, positions, velocities);
                        obj.setState(newState);
                    end
                end
                
                runAtTime@boids.agents.Bird(obj, time);
            end
        end
    end
    
    methods (Static, Access = {?publicsim.tests.UniversalTester})
        function tests = test()
            % Run all tests
            tests = {};
        end
    end
    
end

