% Basic test
close all;
clear;

% Define the log path
logPath = '\log\boids';

% Create the simulation instance
simInst = publicsim.sim.Instance(logPath);

% Define overall sim parameters
startTime = 0; %[s]
endTime = 30; %[s]

% Create the world
world = boids.util.WrappingWorld();
xMin = -10;
xMax = 10;
yMin = -10;
yMax = 10;
world.setBounds(xMin, xMax, yMin, yMax);

for i = 1:50
    % Create a bird
    bird = boids.agents.Bird(world);
    
    % Give the bird a random initial state
    velocity = [rand() - 0.5, rand() - 0.5, 0];
    velocity = velocity / norm(velocity);
    position = [rand() * (xMax - xMin) + xMin, rand() * (yMax - yMin) + yMin, 0];
    acceleration = [0 0 0];
    initState.velocity = velocity;
    initState.position = position;
    initState.acceleration = acceleration;
    bird.setInitialState(0, initState);
    
    % Add the bird to the simulation
    simInst.AddCallee(bird);
end

% Run the sim
simInst.runUntil(startTime, endTime);

% Post processes
boids.tests.testWorld.post();

