classdef WrappingMovement < publicsim.funcs.movement.NewtonMotion
    %WRAPPINGMOVEMENT Moves objects in world with edge wrapping
    
    properties (SetAccess = private)
        world % Wrapping world
    end
    
    methods
        function obj = WrappingMovement(world)
            assert(isa(world, 'boids.util.WrappingWorld'), 'World is not the correct type!');
            obj.world = world;
        end
        
        function [newState, startState] = updateLocation(obj, currentState, timeOffset)
            [newState, startState] = ...
                updateLocation@publicsim.funcs.movement.NewtonMotion(obj, currentState, timeOffset);
            
            if newState.position(1) > obj.world.xMax
                newState.position(1) = newState.position(1) - (obj.world.xMax - obj.world.xMin);
            elseif newState.position(1) < obj.world.xMin
                newState.position(1) = newState.position(1) + (obj.world.xMax - obj.world.xMin);
            end
            
            if newState.position(2) > obj.world.yMax
                newState.position(2) = newState.position(2) - (obj.world.yMax - obj.world.yMin);
            elseif newState.position(2) < obj.world.yMin
                newState.position(2) = newState.position(2) + (obj.world.yMax - obj.world.yMin);
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



