classdef inputParser < handle
    %INPUTPARSER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        np
        results
    end
    
    methods
        function obj = inputParser()
            % Do nothing
            obj.np = inputParser;
        end
        
        function addRequired(obj, varargin)
            obj.np.addParameter(varargin{:});
        end
        
        function addOptional(obj, varargin)
            obj.np.addOptional(varargin{:});
        end
        
        function addParameter(obj, varargin)
            obj.np.addParameter(varargin{:});
        end
        
        function parse(obj, varargin)
            obj.np.parse(varargin{:});
            obj.results = obj.np.Results;
        end
    end
    
end

