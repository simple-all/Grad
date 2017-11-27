classdef CEARunner < handle
    %CEARUNNER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = CEARunner()
            % Add path if neccessary
            myPath = mfilename('fullpath');
            CEAPath = [myPath(1:(strfind(myPath, '+nasa') - 1)), 'nasaData'];
            currPath = regexp(path, pathsep ,'split');
            if ispc
                onPath = any(strcmpi(CEAPath, currPath));
            else
                onPath = any(strcmp(CEAPathm, currPath));
            end
            
            if ~onPath
                addpath(CEAPath);
            end
        end
        
        function data = run(obj, varargin)
            data = obj.CEA(varargin{:});
        end
    end
    
    methods (Static)
        data = CEA(varargin);
    end
end

