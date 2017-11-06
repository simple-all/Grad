function positions = unwrapPositions(obj, positions)
%UNWRAPPOSITIONS Unwraps perceived positions states

for i = 1:size(positions, 1)
    diff = positions(i, :) - obj.spatial.position;
    if abs(diff(1)) > ((obj.world.xMax - obj.world.xMin) / 2)
        if diff(1) < 0
            positions(i, 1) = positions(i, 1) + (obj.world.xMax - obj.world.xMin);
        else
            positions(i, 1) = positions(i, 1) - (obj.world.xMax - obj.world.xMin);
        end
    end
    
    if abs(diff(2)) > ((obj.world.yMax - obj.world.yMin) / 2)
        if diff(2) < 0
            positions(i, 2) = positions(i, 1) + (obj.world.yMax - obj.world.yMin);
        else
            positions(i, 2) = positions(i, 1) - (obj.world.yMax - obj.world.yMin);
        end
    end
end


end

