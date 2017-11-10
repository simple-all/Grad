% Thomas Satterly
% AAE 537
% Homework 5, part iv (optimization)
clear;
close all;

% Set up the burner elements
num1 = 20;
num2 = 20;
num3 = 1;
numSteps = 1000;

angle1c = 2.11452631631579;
angle2c = 8.32210526105264;
step = 0.0032;

angle1 = linspace(angle1c - step, angle1c + step, num1);
angle2 = linspace(angle2c - step, angle2c + step, num2);
angle3 = 10;

thrust = zeros(num1, num2, num3);

parfor i = 1:num1
    for j = 1:num2
        for k = 1:num3
            burnerElement1 = aae537.hw5.BurnerSegment();
            burnerElement2 = aae537.hw5.BurnerSegment();
            burnerElement3 = aae537.hw5.BurnerSegment();
            
            % Set up the geometry
            w = 1.067724; % need to calculate this
            h = w / 5;
            
            burnerElement1.geometry.setWidth(w);
            burnerElement1.geometry.setHeight(h);
            burnerElement1.geometry.setLength(1);
            burnerElement1.geometry.setAngle(angle1(i));
            
            burnerElement2.geometry.setWidth(w);
            burnerElement2.geometry.setHeight(burnerElement1.geometry.getHeight(burnerElement1.geometry.getLength()));
            burnerElement2.geometry.setLength(1);
            burnerElement2.geometry.setAngle(angle2(j));
            
            burnerElement3.geometry.setWidth(w);
            burnerElement3.geometry.setHeight(burnerElement2.geometry.getHeight(burnerElement2.geometry.getLength()));
            burnerElement3.geometry.setLength(1);
            burnerElement3.geometry.setAngle(angle3(k));
            
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
            burnerElement1.setFlowElement(startFlow);
            
            dmdot_dt = @(x) 1.5319 * sin(pi * x);
            
            burnerElement1.setMassFlowRate(mdot);
            burnerElement1.setHeatingValue(h);
            burnerElement1.setInjectionFunc(dmdot_dt);
            
            burnerElement2.setHeatingValue(h);
            burnerElement2.setInjectionFunc(dmdot_dt);
            
            burnerElement3.setHeatingValue(h);
            burnerElement3.setInjectionFunc(dmdot_dt);
            
            % Setup solver
            
            
            [tempFlow, states1] = burnerElement1.solve(numSteps, 0);
            burnerElement2.setFlowElement(tempFlow);
            [tempFlow, states2] = burnerElement2.solve(numSteps, 1);
            burnerElement3.setFlowElement(tempFlow);
            [exitFlow, states3] = burnerElement3.solve(numSteps, 2);
            
            states = [states1 states2 states3];
            M = zeros(numSteps * 3 + 3);
            u = zeros(numSteps * 3 + 3);
            for l = 1:(numSteps * 3 + 3);
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



