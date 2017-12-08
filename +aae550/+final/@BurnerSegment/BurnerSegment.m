classdef BurnerSegment < aeroBox.flowFields.BurnerFlow
    %BURNERSEGMENT Burner with rectangular cross section, linear varying area
    % Created by Thomas Satterly
    properties
    end
    
    methods
        function obj = BurnerSegment(varargin)
            % Create with rectangular type
            obj@aeroBox.flowFields.BurnerFlow(varargin{:});
            obj.setGeometry(aeroBox.geometric.Rectangular());
        end
        
        function [x y] = getPlotArrays(obj)
            x = [0, obj.geometry.getLength()];
            y = [obj.geometry.getHeight(0), obj.geometry.getHeight(obj.geometry.getLength())];
        end
        
    end
    
end

