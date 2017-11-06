classdef WrappingWorld < publicsim.tests.UniversalTester
    %WRAPPINGWORLD Defines the bounds of a wrapping 2D world
    
    properties (SetAccess = private)
        xMin;
        xMax;
        yMin;
        yMax;
    end
    
    methods
        function setBounds(obj, xMin, xMax, yMin, yMax)
            obj.xMin = xMin;
            obj.xMax = xMax;
            obj.yMin = yMin;
            obj.yMax = yMax;
        end
        
        function pos = convert_lla2ecef(obj, lla)
            pos = lla;
        end
        
        function pos = convert_ecef2lla(obj, ecef)
            pos = ecef;
        end
        
        function dist = gcdist(obj, p1_1, p1_2, p2_1, p2_2)
            p1 = [p1_1, p1_2];
            p2 = [p2_1, p2_2];
            dist = norm(p1 - p2);
        end
        
    end
    
end

