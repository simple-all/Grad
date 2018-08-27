classdef Pro150_40960O8000_P < aae590.sim.base.Stage
    %PRO150_29920O3700_P Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant, Access = private)
        
        % Thrust curve, [time (s), thrust (N)]
        thrustCurve = ...
            [0 0;
            0.01 0.001;
            0.02 6.9;
            0.03 23;
            0.04 1746.6;
            0.06 9705.7;
            0.09 7654.9 
            0.1 8439.7;
            0.2 8093.5;
            0.3 8110.3 
            0.4 8289.6;
            0.5 8508.7 
            0.6 8524;
            0.7 8386.5;
            0.8 8398.8;
            0.9 8359.7;
            1 8382.7;
            1.8 8570;
            2.2 8562.7;
            2.6 8485.7 
            3 8291.9;
            3.2 8172.4 
            3.4 8103.4;
            3.8 7893.9;
            4 7737.3;
            4.4 7559.9;
            4.8 7399.4;
            5 7044.3;
            5.1 2341.9;
            5.101 0];
        
        % Fuel mass curve, [time (s), mass (g)]
        massCurve = ...
            [0  19194.;
            0.01 19194.;
            0.02  19194.;
            0.03  19193.9;
            0.04  19189.8;
            0.06  19136.1;
            0.09  19014.;
            0.1  18976.3;
            0.2  18588.8;
            0.3  18209.;
            0.4  17824.7;
            0.5  17431.;
            0.6 7031.8;
            0.7  16635.5;
            0.8  16242.1;
            0.9  15849.3;
            1  15456.9;
            1.8  12278.4;
            2.2  10672.2;
            2.6  9073.96;
            3  7501.1;
            3.2  6729.35;
            3.4  5966.44;
            3.8  4466.73;
            4  3734.04;
            4.4  2299.96;
            4.8  897.564;
            5  220.532;
            5.1  0.548869;
            5.101 0];
        
        dryMass = 13748; % Dry mass (g)
        
    end
    
    methods
        function obj = Pro150_40960O8000_P()
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

