function world = createWorld()
%CREATEWORLD Creates the world
world = boids.util.WrappingWorld();
xMin = -10;
xMax = 10;
yMin = -10;
yMax = 10;
world.setBounds(xMin, xMax, yMin, yMax);
end

