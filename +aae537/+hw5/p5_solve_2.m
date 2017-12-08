% Thomas Satterly
% AAE 537
% Homework 5, part iv (optimization)
clear;
close all;

% Set up the burner elements
num1 = 1;
num2 = 1;
num3 = 1;
numSteps = 1000;

angle1c = 2.11452631631579;
angle2c = 8.32210526105264;
step = 0.0032;

angle1 = linspace(angle1c - step, angle1c + step, num1);
angle2 = linspace(angle2c - step, angle2c + step, num2);
angle3 = 10;

thrust = zeros(num1, num2, num3);
dmdot_dt = @(x) abs(1.5319 * sin(pi * x));

for i = 1:num1
    for j = 1:num2
        for k = 1:num3
            
            burner = aae550.final.Burner();
            
            % Set up the geometry
            w = 1.067724; % need to calculate this
            h = w / 5;
            
            
            
            angles = [angle1(i), angle2(k), angle3(k)];
            widths = [w w w];
            heights = [h h h];
            lengths = [1 1 1];
            
            
            
            % Setup the initial flow
            gamma = 1.4;
            M0 = 6; % Freestream mach
            M3 = 2.5; % Mach at isolator exit
            pr = 0.7; % Inlet/compression system total pressure recovery factor
            mdot = 100; % [kg/s] Mass flow of air at isolator exit
            h = 120908000;  % J/kg
            startFlow = aeroBox.flowFields.FlowElement();
            startFlow.setCp(1216); % J/kg*K
            startFlow.setR(287.058); % J/kg*K
            startFlow.setGamma(1.4);
            startFlow.setMach(M3);
            startFlow.setStagnationTemperature(aeroBox.isoBox.calcStagTemp('mach', M0, 'gamma', gamma, 'Ts', 227));
            startFlow.setStagnationPressure(aeroBox.isoBox.calcStagPressure('mach', M0, 'gamma', gamma, 'Ps', 1117) * pr);
            startFlow.setMassFlow(mdot);
            
            burner.setGeometry(widths, heights, lengths, angles);
            burner.setHeatingValue(h);
            burner.setInjectionFunc(dmdot_dt);
            burner.setStartFlow(startFlow);
            
            
            % Setup solver
            
            
            burner.solve();
            
            states = burner.states;
            M = zeros(1, numel(states));
            u = zeros(1, numel(states));
            for l = 1:numel(states)
                flow = states{l}.flow;
                M(l) = flow.M();
                mdot(l) = flow.mdot();
                u(l) = flow.u();
            end
            if any(M < 1)
                thrust(i, j, k) = -1;
            else
                thrust(i, j, k) = u(end) * mdot(end);
            end
        end
    end
end

[maxThrust, ind] = max(thrust(:));
[a, b, c] = ind2sub(size(thrust), ind);

fprintf('Maximum thrust near the point:\n angle1 = %0.3f\n angle2 = %0.3f\n angle3 = %0.3f\n', angle1(a), angle2(b), angle3(c));



