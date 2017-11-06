function fh = detectApoapsis(obj)

shouldRun = 1;
lastAltitude = -inf;
fh = @detectApoapsisNested;


    function bool = detectApoapsisNested(~)
        if ~shouldRun
            bool = 0;
            return;
        end
        lla = obj.world.convert_ecef2lla(obj.getPosition());
        currentAltitude = lla(3);
        if currentAltitude < lastAltitude
            bool = 1;
            shouldRun = 0;
        else
            bool = 0;
        end
        lastAltitude = currentAltitude;
    end
end