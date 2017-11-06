% Thomas Satterly
% AAE 537
% Homework 5
clear;
close all;

% Set up the burner elements

burnerElement1 = aae537.hw5.BurnerSegment();
burnerElement2 = aae537.hw5.BurnerSegment();
burnerElement3 = aae537.hw5.BurnerSegment();

% Set up the geometry
w = 1.067724; % need to calculate this
h = w / 5;

burnerElement1.geometry.setWidth(w);
burnerElement1.geometry.setHeight(h);
burnerElement1.geometry.setLength(1);
burnerElement1.geometry.setAngle(10);

burnerElement2.geometry.setWidth(w);
burnerElement2.geometry.setHeight(burnerElement1.geometry.getHeight(burnerElement1.geometry.getLength()));
burnerElement2.geometry.setLength(1);
burnerElement2.geometry.setAngle(12);

burnerElement3.geometry.setWidth(w);
burnerElement3.geometry.setHeight(burnerElement2.geometry.getHeight(burnerElement2.geometry.getLength()));
burnerElement3.geometry.setLength(1);
burnerElement3.geometry.setAngle(14);

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

%dmdot_dt = @(x) 1.5319 * (-(1 / pi) * (cos(pi * x) - 1)) / x;
dmdot_dt = @(x) 1.5319 * sin(pi * x);

burnerElement1.setMassFlowRate(mdot);
burnerElement1.setHeatingValue(h);
burnerElement1.setInjectionFunc(dmdot_dt);

burnerElement2.setHeatingValue(h);
burnerElement2.setInjectionFunc(dmdot_dt);

burnerElement3.setHeatingValue(h);
burnerElement3.setInjectionFunc(dmdot_dt);

% Setup solver

numSteps = 1000;
[tempFlow, states1] = burnerElement1.solve(numSteps, 0);
burnerElement2.setFlowElement(tempFlow);
[tempFlow, states2] = burnerElement2.solve(numSteps, 1);
burnerElement3.setFlowElement(tempFlow);
[exitFlow, states3] = burnerElement3.solve(numSteps, 2);

states = [states1 states2 states3];

for i = 1:numel(states)
    flow = states{i}.flow;
    x(i) = states{i}.x;
    T(i) = flow.T();
    P(i) = flow.P();
    Pt(i) = flow.Pt();
    M(i) = flow.M();
    mdot(i) = flow.mdot();
    u(i) = flow.u();
end

figure;
plot(x, T);
xlabel('Distance');
ylabel('Temperature [K]');
title('Temperature Profile');


figure;
plot(x, P);
xlabel('Distance');
ylabel('Static Pressure [Pa]');
title('Static Pressure Profile');

figure;
plot(x, Pt);
xlabel('Distance');
ylabel('Stagnation Pressure [Pa]');
title('Stagnation Pressure Profile');

figure;
plot(x, M);
xlabel('Distance');
ylabel('Mach Number');
title('Mach Profile');

figure;
plot(x, mdot);
xlabel('Distance');
ylabel('Mass Flow Rate [kg/s]');
title('Mass Flow Rate Profile');

figure;
plot(x, u);
xlabel('Distance');
ylabel('Flow Velocity [m/s]');
title('Flow Velocity Profile');


