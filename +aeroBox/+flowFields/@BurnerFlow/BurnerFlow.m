classdef BurnerFlow < handle
    %BURNERFLOW Flow with fast kinetic burning
    
    properties (SetAccess = private)
        flowElement;
        geometry;
        injectionFunc; % Function for dm_dot/dx
        h; % Heating value of the fuel
        %mdot; % Mass flow rate
    end
    
    methods
        
        function setHeatingValue(obj, h)
            obj.h = h;
        end
        
        function setGeometry(obj, geo)
            obj.geometry = geo;
        end
        
        function setInjectionFunc(obj, fh)
            assert(isa(fh, 'function_handle'), 'Must use function handle for injection function!');
            obj.injectionFunc = fh;
        end
        
        function setMassFlowRate(obj, mdot)
            obj.flowElement.setMassFlow(mdot);
        end
        
        function setFlowElement(obj, flow)
            obj.flowElement = flow;
        end
        
        function [endFlow, states] = solve(obj, numSteps, startX)
            if nargin < 2
                numSteps = 1;
            end
            
            stepSize = obj.geometry.getLength() / numSteps;
            endFlow = obj.flowElement.getCopy();
            x = 0;
            genState = @(x, flow) struct('flow', flow.getCopy(), 'x', x + startX);
            states = {};
            lastFlow = obj.flowElement.getCopy();
            for i = 1:numSteps
                states{i} = genState(x, lastFlow);
                x = x + stepSize;
                dTt_dx = lastFlow.Tt * (1 / lastFlow.mdot) * obj.injectionFunc(x) * (obj.h / (lastFlow.cp * lastFlow.Tt) - 1);
                Tt = lastFlow.Tt + dTt_dx * stepSize; 
                endFlow.setStagnationTemperature(Tt);
                
                dM_dx = lastFlow.M * ((1 + ((lastFlow.gamma - 1) / 2) * lastFlow.M^2) / (1 - lastFlow.M^2)) * ...
                    ((-1 / obj.geometry.getArea(x - stepSize)) * obj.geometry.getRateOfAreaChange + ...
                    ((1 + lastFlow.gamma * lastFlow.M^2) / 2) * (1 / lastFlow.Tt) * dTt_dx);
                endFlow.setMach(lastFlow.M + stepSize * dM_dx);
                
                endFlow.setMassFlow(endFlow.mdot + obj.injectionFunc(x) * stepSize);
                
                lastFlow = endFlow.getCopy();
            end
            states{end + 1} = genState(x, lastFlow);
        end
    end
    
end

