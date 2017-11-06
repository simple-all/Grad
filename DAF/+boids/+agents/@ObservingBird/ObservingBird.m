classdef ObservingBird < boids.agents.Bird & publicsim.agents.base.Detectable
    %OBSERVINGBIRD Bird that uses observable groups to flock
    
    properties
        observableObjectManager; % Observable manager
    end
    
    methods
        
        function obj = ObservingBird()
            obj@boids.agents.Bird();
        end
        
        function runAtTime(obj, time)
            if obj.isRunTime(time)
                % Get all observable birds
                birds = obj.observableObjectManager.getObservables(time);
                
                % For each birds (that is not self), get the location and
                % direction
                %             positions = zeros(numel(birds) - 1, 3);
                %             velocities = zeros(numel(birds) - 1, 3);
                idx = 0;
                positions = [];
                for i = 1:numel(birds)
                    if birds{i}.id ~= obj.id
                        birdPosition = birds{i}.getPosition();
                        birdPosition = boids.funcs.flocking.unwrapPositions(obj, birdPosition);
                        perceptionVector = birdPosition - obj.spatial.position;
                        perceptionAngle = acosd(dot(perceptionVector, obj.spatial.velocity) / ...
                            (norm(perceptionVector) * norm(obj.spatial.velocity)));
                        if (norm(birdPosition - obj.spatial.position) < obj.maxDist) && ...
                            abs(perceptionAngle) < obj.maxAngle
                            idx = idx + 1;
                            positions(idx, :) = birdPosition; %#ok<AGROW>
                            velocities(idx, :) = birds{i}.getVelocity(); %#ok<AGROW>
                        end
                    end
                end
                
                if ~isempty(positions)
                    newState = boids.funcs.flocking.getNewStateFromFlock(obj, positions, velocities);
                    obj.setState(newState);
                end
                
                runAtTime@boids.agents.Bird(obj, time);
            end
        end
        
        function setObservableManager(obj,manager)
            obj.observableObjectManager=manager;
        end
    end
    
    methods (Static, Access = {?publicsim.tests.UniversalTester})
        function tests = test()
            % Run all tests
            tests = {};
        end
    end
    
end

