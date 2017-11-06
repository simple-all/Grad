classdef Bird < publicsim.analysis.CoordinatedAnalyzer
    %BIRD Basic bird analyzer
    
    properties
        movementAnalyzer;
        logger;
    end
    
    methods
        function obj = Bird(logger, coordinator)
            if ~exist('coordinator', 'var')
                coordinator = publicsim.analysis.Coordinator();
            end
            obj@publicsim.analysis.CoordinatedAnalyzer(coordinator);
            obj.logger=logger;
            obj.movementAnalyzer = obj.coordinator.requestAnalyzer('publicsim.analysis.basic.Movement', obj.logger);
        end
        
        function figHandle = plotBirds(obj, figHandle)
            % Make a figure if none provided
            if nargin < 2
                figHandle = figure();
            end
            % Get all bird data
            birdData = obj.movementAnalyzer.getPositionsForClass('boids.agents.Bird');
            ids = unique(birdData.agentIds);
            figure(figHandle);
            hold on;
            for i = 1:numel(ids)
                inds = birdData.agentIds == ids(i);
                plot3(birdData.positions(inds, 1), ...
                    birdData.positions(inds, 2), ...
                    birdData.positions(inds, 3), '.', 'DisplayName', num2str(ids(i)));
            end
            legend('show');
        end
        
        function frames = animateBirds(obj, world)
            % Get all bird data
            birdData = obj.movementAnalyzer.getPositionsForClass('boids.agents.Bird');
            ids = unique(birdData.agentIds);
            
            birdHandles = cell(1, numel(ids));
            figHandle = figure();
            ax = gca();
            xlim([world.xMin, world.xMax]);
            ylim([world.yMin, world.yMax]);
            hold on;
            for i = 1:numel(birdHandles)
                birdHandles{i} = plot3(0, 0, 0, '.');
            end
            
            % Update figure at each time
            times = sort(unique(birdData.times));
            for i = 1:numel(times)
                for j = 1:numel(ids)
                    inds = and(birdData.agentIds == ids(j), birdData.times' == times(i));
                    thisIndex = find(inds, 1);
                    birdHandles{j}.XData = birdData.positions(thisIndex, 1);
                    birdHandles{j}.YData = birdData.positions(thisIndex, 2);
                    birdHandles{j}.ZData = birdData.positions(thisIndex, 3);
                    %                     birdHandles{j}.UData = birdData.velocities(thisIndex, 1) / 3;
                    %                     birdHandles{j}.VData = birdData.velocities(thisIndex, 2) / 3;
                    %                     birdHandles{j}.WData = birdData.velocities(thisIndex, 3) / 3;
                end
                frames(i) = getframe(ax);
            end
            
        end
    end
    
end

