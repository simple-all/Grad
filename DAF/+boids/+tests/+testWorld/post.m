% Get the logging data
log = publicsim.sim.Logger(logPath);
log.restore();

% Create a analysis coordinator
coordinator = publicsim.analysis.Coordinator();

% Get the movement analyzer
birdAnalyzer = coordinator.requestAnalyzer('boids.analysis.Bird', log);

frames = birdAnalyzer.animateBirds(world);