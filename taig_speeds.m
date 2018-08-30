
rpm = 1500;
pitch = 0.1; % inches per revolution of the leadscrew
ipr = 0.01; % inches per revolution of the spindle
leadRperSpindleR = ipr / pitch; % Revolutions of the leadscrew per revolution of the spindle
leadRPM = leadRperSpindleR * rpm;
disp(leadRPM);