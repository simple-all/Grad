classdef BurnerSegment < aeroBox.flowFields.BurnerFlow
    %BURNERSEGMENT Burner with rectangular cross section, linear varying area
    % Created by Thomas Satterly
    properties
    end
    
    methods
        function obj = BurnerSegment()
            % Create with rectangular type
            obj@aeroBox.flowFields.BurnerFlow();
            obj.setGeometry(aeroBox.geometric.Rectangular());
        end
    end
    
end

