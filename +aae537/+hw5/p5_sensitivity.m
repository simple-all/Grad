% Thomas Satterly
% AAE 537
% Homework 5, part iv (sensitivity plots)
clear;
close all;

% Set up the burner elements
numAngles = 10;
numSteps = 1000;

angle1c = 3;
angle2c = 9;
angle3c = 14;
step = 0.6;

angle1 = linspace(angle1c - step, angle1c + step, numAngles);
angle2 = linspace(angle2c - step, angle2c + step, numAngles);
angle3 = linspace(angle3c - step, angle3c + step, numAngles);

for i = 1:3
    for j = 1:numAngles
        burnerElement1 = aae537.hw5.BurnerSegment();
        burnerElement2 = aae537.hw5.BurnerSegment();
        burnerElement3 = aae537.hw5.BurnerSegment();
        
        % Set up the geometry
        w = 1.067724; % need to calculate this
        h = w / 5;
        
        switch i
            case 1
                a1 = angle1(j);
                a2 = angle2c;
                a3 = angle3c;
            case 2
                a1 = angle1c;
                a2 = angle2(j);
                a3 = angle3c;
            case 3
                a1 = angle1c;
                a2 = angle2c;
                a3 = angle3(j);
        end
        
        burnerElement1.geometry.setWidth(w);
        burnerElement1.geometry.setHeight(h);
        burnerElement1.geometry.setLength(1);
        burnerElement1.geometry.setAngle(a1);
        
        burnerElement2.geometry.setWidth(w);
        burnerElement2.geometry.setHeight(burnerElement1.geometry.getHeight(burnerElement1.geometry.getLength()));
        burnerElement2.geometry.setLength(1);
        burnerElement2.geometry.setAngle(a2);
        
        burnerElement3.geometry.setWidth(w);
        burnerElement3.geometry.setHeight(burnerElement2.geometry.getHeight(burnerElement2.geometry.getLength()));
        burnerElement3.geometry.setLength(1);
        burnerElement3.geometry.setAngle(a3);
        
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
        for l = 1:(numSteps * 3 + 3);
            flow = states{l}.flow;
            M(l) = flow.M();
            mdot(l) = flow.mdot();
            u(l) = flow.u();
        end
        if any(M < 1)
            thrust(j) = -1;
        else
            thrust(j) = u(end) * mdot(end);
        end
    end
    
    figure;
    switch i
        case 1
            angles = angle1;
            xl = '\alpha_1';
            tl = 'Sensitivity of \alpha_1';
        case 2
            angles = angle2;
            xl = '\alpha_2';
            tl = 'Sensitivity of \alpha_2';
        case 3
            angles = angle3;
            xl = '\alpha_3';
            tl = 'Sensitivity of \alpha_3';
    end
    plot(angles, thrust);
    xlabel(xl);
    ylabel('Jet Thrust');
    title(tl);
    
end



