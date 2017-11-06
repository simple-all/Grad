function world = createWorld()
%CREATEWORLD Creates the world
world = boids.util.WrappingWorld();
xMin = -20;
xMax = 20;
yMin = -20;
yMax = 20;
world.setBounds(xMin, xMax, yMin, yMax);
end

