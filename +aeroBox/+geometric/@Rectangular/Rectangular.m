classdef Rectangular < handle
    %RECTANGULAR Rectangular cross section duct with linearly varying height
    
    properties (SetAccess = private)
        w; % Width at the start
        h; % Height at the start
        alpha; % Side angle
        length; % Length of the duct
    end
    
    methods
        
        function h = getHeight(obj, x)
            % Gets the duct height at position x
            if nargin < 2
                x = 0;
            end
            h = obj.h + tand(obj.alpha) * x;
        end
        
        function w = getWidth(obj)
            % Gets the width
            w = obj.w;
        end
        
        function l = getLength(obj)
            l = obj.length;
        end
        
        function setWidth(obj, w)
            % Sets the duct width
            obj.w = w;
        end
        
        function setHeight(obj, h)
            % Sets the duct height at the start
            obj.h = h;
        end
        
        function setLength(obj, l)
            obj.length = l;
        end
        
        function setAngle(obj, a)
            obj.alpha = a;
        end
        
        function A = getArea(obj, x)
            A = obj.w * obj.h + x * obj.getRateOfAreaChange();
        end
        
        function dA_dx = getRateOfAreaChange(obj, ~)
            dA_dx = obj.w * tand(obj.alpha);
        end
    
    end
    
end

