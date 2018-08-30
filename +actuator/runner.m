clc;
clear all;
close all;

% Make pseudo actuators
act1 = actuator.Linear();
act2 = actuator.Linear();
act2.speedMod = 0.8;

tstep = 0.1; % s
startTime = 0;
endTime = 100;
time = 0;

pos1 = []; % Position of actuator (real)
pos2 = [];
rp1 = []; % Reported position of actuators (from encorder)
rp2 = [];
ts = [];
df = [];
idf = [];
s1 = [];
s2 = [];
extra = 0.2; % Make PWM width (20%) that controller can vary
maxiDiff = 1; % Max integral windup
iDiff = 0;
dir = 1;

p = 0.1; % Proportional gain
i = 2; % Integral gain

overallSpeed = 0.5; % 50% speed
useController = 1; % 1 = use controller, 0 = do not use controller

while (time <= endTime)
    if (time > 50)
        dir = -1;
        act1.dir = -1;
        act2.dir = -1;
    end
    
    diff = act1.getReadout() - act2.getReadout(); % Current different (proportional)
    iDiff = sign(diff) * min(maxiDiff, abs(diff + iDiff)); % Integrate
    
    % Add PI control to speed
    speed1 = overallSpeed + min((diff * p + iDiff * i), 1) * -1 * extra * dir;
    speed2 = overallSpeed + min((diff * p + iDiff * i), 1) * extra * dir;
    
    % Limit speed to 100% PWM
    speed1 = min(speed1, 1);
    speed2 = min(speed2, 1);
    
    % Set PWM
    if (useController)
        act1.setPWM(speed1);
        act2.setPWM(speed2);
    else
        act1.setPWM(overallSpeed);
        act2.setPWM(overallSpeed);
    end
        
    % Simulate
    act1.runAtTime(time);
    act2.runAtTime(time);
    
    % Record stuff
    pos1(end + 1) = act1.position;
    pos2(end + 1) = act2.position;
    rp1(end + 1) = act1.getReadout();
    rp2(end + 1) = act2.getReadout();
    ts(end + 1) = time;
    df(end + 1) = diff;
    idf(end + 1) = iDiff;
    s1(end + 1) = speed1;
    s2(end + 1) = speed2;
    
    time = time + tstep;
    
end

figure();
subplot(3, 1, 1);
hold on;
plot(ts, pos1, 'r', 'LineWidth', 2);
plot(ts, pos2, 'b', 'LineWidth', 2);
% plot(ts, rp1, 'g--', 'LineWidth', 2);
% plot(ts, rp2, 'k--', 'LineWidth', 2);
legend('Act 1 Position', 'Act 2 Position');
subplot(3, 1,2 );
hold on;
plot(ts, s1, 'r');
plot(ts, s2, 'b');
legend('Speed 1', 'Speed 2');

subplot(3, 1, 3);
plot(ts, df);
legend('Diff');
% figure();
% hold on;
% plot(ts, df);
% plot(ts, idf);
% legend('Diff', 'iDiff');


