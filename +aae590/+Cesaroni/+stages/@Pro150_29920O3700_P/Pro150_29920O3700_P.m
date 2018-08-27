classdef Pro150_29920O3700_P < aae590.sim.base.Stage
    %PRO150_29920O3700_P Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant, Access = private)
        
        % Thrust curve, [time (s), thrust (N)]
        thrustCurve = ...
            [0 0;
            0.052 1009.02;
            0.071 1646.91;
            0.084 2505.16;
            0.09 3183.63;
            0.116 3409.79;
            0.187 3114.05;
            0.245 3050.26;
            0.316 3108.25;
            0.445 3241.62;
            0.594 3461.99;
            0.819 3653.35;
            1.155 3676.55;
            1.503 3775.13;
            2.471 3931.7;
            3.277 4012.89;
            4.213 4030.28;
            4.787 3983.89;
            5.206 3925.9;
            5.671 3867.91;
            5.981 3850.51;
            6.413 3751.93;
            6.923 3618.56;
            7.387 3496.78;
            7.645 3363.4;
            7.819 3102.45;
            7.903 2905.28;
            7.942 2383.38;
            7.981 1948.45;
            8.026 1310.57;
            8.084 695.876;
            8.135 359.536;
            8.187 162.371;
            8.277 81.186;
            8.387 0];
        
        % Fuel mass curve, [time (s), mass (g)]
        massCurve = ...
            [0 17157;
            0.052 17142;
            0.071 17127.5;
            0.084 17112.1;
            0.09 17102.3;
            0.116 17053.2;
            0.187 16920.6;
            0.245 16818.2;
            0.316 16693.;
            0.445 16458.4;
            0.594 16172.4;
            0.819 15713.9;
            1.155 15008.6;
            1.503 14266;
            2.471 12129.7;
            3.277 10296;
            4.213 8140.11;
            4.787 6822.79;
            5.206 5873.71;
            5.671 4835.89;
            5.981 4150.7;
            6.413 3210.2;
            6.923 2133.77;
            7.387 1188.32;
            7.645 681.479;
            7.819 359.301;
            7.903 214.787;
            7.942 155.722;
            7.981 107.343;
            8.026 65.3456;
            8.084 32.0202;
            8.135 16.6063;
            8.187 8.83455;
            8.277 2.55738;
            8.387 0;]
        
        dryMass = 13234; % Dry mass (g)
            
    end
    
    methods
        function obj = Pro150_29920O3700_P()
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

