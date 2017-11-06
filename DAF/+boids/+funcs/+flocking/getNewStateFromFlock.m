function newState = getNewStateFromFlock(obj, positions, velocities)
%GETNEWSTATEFROMFLOCK Returns the new state based on gains and flock

newState = obj.spatial;
if isempty(positions)
    return;
end

% Cohesion
percievedCenter = sum(positions, 1) / numel(positions);
cohesionVector = (percievedCenter - obj.spatial.position);
cohesionVector = cohesionVector / norm(cohesionVector);

% Separation
separationVector = zeros(1, 3);
for i = 1:size(positions, 1)
    separationVector = separationVector + ...
        (obj.spatial.position - positions(i, :)) / ...
        norm(obj.spatial.position - positions(i, :))^2;
end
separationVector = separationVector / norm(separationVector);

% Alignment
perceivedVelocity = sum(velocities, 1) / numel(velocities);
alignmentVector = perceivedVelocity / norm(perceivedVelocity);


% Update the current velocity based goals
velocityMagnitude = norm(newState.velocity);

newState.velocity = newState.velocity + ...
    (cohesionVector * obj.cohesion + ...
    separationVector * obj.separation + ...
    alignmentVector * obj.alignment) * ...
    obj.getPeriodicRunPeriod();

newState.velocity = velocityMagnitude  * newState.velocity / norm(newState.velocity);

end

