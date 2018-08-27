function basic

elRange = linspace(20, 90, 50);
massRange = linspace(10, 100, 50);
stages = {'aae590.Cesaroni.stages.Pro150_29920O3700_P', ...
    'aae590.Cesaroni.stages.Pro150_37148O4900_P', ...
    'aae590.Cesaroni.stages.Pro150_40960O8000_P'};

for k = 1:numel(stages)
    for i = 1:numel(elRange)
        for j = 1:numel(massRange)
            [alt, speed, el] = singleRun(eval(stages{k}), elRange(i), massRange(j));
            altitudes(i, j, k) = alt;
            speeds(i, j, k) = speed;
            elevationAngles(i, j, k) = el;
        end
    end
end


for i = 1:numel(stages)
    [eGrid, mGrid] = meshgrid(elRange, massRange);
    figure;
    subplot(2, 1, 1);
    hold on;
    contourf(eGrid, mGrid, altitudes(:, :, i)' / 1e3, 500, 'LineStyle', 'none');
    t = strsplit(strrep(stages{i}, '_', '-'), '.');
    title(t{end});
    xlabel('Launch Elevation Angle (deg)');
    ylabel('Payload Mass (kg)');
    ch = colorbar();
    caxis([0.2 2.5]);
    ylabel(ch, 'Burnout Altitude (km)');
    ylim([min(massRange), max(massRange)]);
    contour(eGrid, mGrid, altitudes(:, :, i)' / 1e3, 0.5:0.5:3, 'showText', 'on', 'LineColor', [0 0 0]);
    
    
    subplot(2, 1, 2);
    hold on;
    contourf(eGrid, mGrid, speeds(:, :, i)' / 330, 500, 'LineStyle', 'none');
    xlabel('Launch Elevation Angle (deg)');
    ylabel('Payload Mass (kg)');
    view(0, 90);
    ch = colorbar();
    caxis([0.5 3]);
    ylabel(ch, 'Burnout Mach');
    ylim([min(massRange), max(massRange)]);
    contour(eGrid, mGrid, speeds(:, :, i)' / 330, 0.5:0.25:3, 'showText', 'on', 'LineColor', [0 0 0]);
end

%
% subplot(3, 1, 3);
% plot(elRange, elevationAngles);
% xlabel('Launch Elevation Angle (deg)');
% ylabel('Burnout Elevation Angle (deg)');

    function [altitude, speed, elevationAngle] = singleRun(stage, elevation, inertMass)
        
        startTime = 0;
        tStep = 0.1;
        
        stack = aae590.sim.base.Stack();
        stage1 = stage;
        stage2 = aae590.sim.stages.InertStage(inertMass, stage1.diameter, 0.5);
        stack.addStage(stage1);
        stack.addStage(stage2);
        stack.setHeading([0, cosd(elevation), sind(elevation)]);
        
        time = startTime;
        stack.launch(0);
        while ~stack.stages{1}.isDone(time);
            stack.runAtTime(time);
            %     altitude(index) = stack.position(3);
            %     speed(index) = norm(stack.velocity);
            %     elevationAngle(index) = atand(stack.velocity(3) /  norm(stack.velocity(1:2)));
            %     times(index) = time;
            time = time + tStep;
            %     index = index + 1;
        end
        
        altitude = stack.position(3);
        speed = norm(stack.velocity);
        elevationAngle = atand(stack.velocity(3) /  norm(stack.velocity(1:2)));
        
    end
end