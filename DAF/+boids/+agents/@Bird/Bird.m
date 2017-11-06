classdef Bird < publicsim.agents.base.Movable & publicsim.agents.base.Periodic & publicsim.agents.physical.Worldly
    %BIRD Basic implementation of a "bird" type
    
    properties
        runTime = 0.2; % [s]
        
        separation = 0.10;
        alignment = 1;
        cohesion = 0.3;
        
        maxDist = 4;
        maxAngle = 150;
    end
    
    methods
        function obj = Bird()
            % Do nothing
        end
        
        function init(obj)
            % Initialize periodic calls
            movementManager = boids.funcs.movement.WrappingMovement(obj.world);
            obj.setMovementManager(movementManager);
            
            velocity = [rand() - 0.5, rand() - 0.5, 0];
            velocity = velocity / norm(velocity);
            position = [rand() * (obj.world.xMax - obj.world.xMin) + obj.world.xMin, ...
                rand() * (obj.world.yMax - obj.world.yMin) + obj.world.yMin, 0];
            acceleration = [0 0 0];
            initState.velocity = velocity;
            initState.position = position;
            initState.acceleration = acceleration;
            obj.setInitialState(0, initState);
            
            obj.initPeriodic(obj.runTime);
        end
        
        function runAtTime(obj, time)
            % Methods for getting info about surroinding birds should be
            % implemented on inhereting classes. This just runs the update
            % function
            if obj.isRunTime(time)
                obj.updateMovement(time);
            end
        end
    end
    
    methods (Static,Access=private)
        
        function addPropertyLogs(obj)
            % Adds periodic logs of position
            obj.addPeriodicLogItems({'getPosition', 'getVelocity'}, 0.2);
        end
        
    end
    
    methods (Static, Access = {?publicsim.tests.UniversalTester})
        function tests = test()
            % Run all tests
            tests = {};
        end
    end
    
end

