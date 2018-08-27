classdef Pro150_37148O4900_P < aae590.sim.base.Stage
    %PRO150_29920O3700_P Summary of this class goes here
    % Detailed explanation goes here
    
    properties (Constant, Access = private)
        
        % Thrust curve, [time (s), thrust (N)]
        thrustCurve = ...
            [0 0;
            0.06 800;
            0.1 4000;
            0.15 5500;
            0.25 5160;
            0.45 5130;
            0.8 5400;
            1 5300;
            2 5450;
            3 5347;
            4 5160;
            5 4950;
            6 4700;
            6.8 4400;
            7.05 4400;
            7.3 3800;
            7.6 300;
            7.8 0];
        
        % Fuel mass curve, [time (s), mass (g)]
        massCurve = ...
            [0 18898.;
            0.06 18885.8;
            0.1 18837.;
            0.15 18716.1;
            0.25 18445.;
            0.45 17921.5;
            0.8 16984.1;
            1 16439.8;
            2 13705.5;
            3 10959.3;
            4 8286.8;
            5 5715.3;
            6 3260.8;
            6.8 1409.11;
            7.05 849.537;
            7.3 328.115;
            7.6 15.2611;
            7.8 0];
        
        dryMass = 13750; % Dry mass (g)
        
    end
    
    methods
        function obj = Pro150_37148O4900_P()
            obj.diameter = 0.160782; % m
            obj.length = 1.09347; % m
        end
        
        function thrust = getThrust(obj, time)
            if isempty(obj.activationTime)
                thrust = 0;
                return;
            end
            if (time < obj.activationTime) || ((time - obj.activationTime) > obj.thrustCurve(end, 1))
                thrust = 0;
                return;
            end
            thrust = interp1(obj.thrustCurve(:, 1), obj.thrustCurve(:, 2), time - obj.activationTime, 'pchip', 0);
        end
        
        function mass = getMass(obj, time)
            if isempty(obj.activationTime)
                mass = (obj.dryMass + obj.massCurve(1, 2)) / 1e3;
                return;
            end
            if (time < obj.activationTime)
                mass = (obj.dryMass + obj.massCurve(1, 2)) / 1e3;
                return;
            end
            mass = (interp1(obj.massCurve(:, 1), obj.massCurve(:, 2), time - obj.activationTime, 'pchip', 0) ...
                + obj.dryMass) / 1e3;
        end
        
        function bool = isDone(obj, time)
            if (time - obj.activationTime) > obj.thrustCurve(end, 1)
                bool = 1;
            else
                bool = 0;
            end
        end
    end
    
end

