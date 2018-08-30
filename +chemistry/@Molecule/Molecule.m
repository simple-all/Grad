classdef Molecule < handle
    %MOLECULE Molecule property calculator
    
    properties (SetAccess = private)
        name; % Name
        formula; % Molecular formula
        elements = struct('element', struct(), 'count', []); % Struct of all elements
        mw; % Molecular weight (g/mol)
        numElements = 0;
    end
    
    methods
        function obj = Molecule(varargin)
            switch nargin
                case 1
                    obj.name = varargin{1}.name;
                    obj.formula = varargin{1}.symbol;
                case 2
                    obj.name = varargin{1};
                    obj.formula = varargin{2};
                otherwise
                    error('Unsupported input!');
            end
            obj.buildFromFormula();
        end
        
        function elements = getAllElements(obj)
            for i = 1:obj.numElements
                elements(i) = obj.elements(i).element;
            end
        end
        
        function count = getElementCount(obj, symbol)
            count = 0;
            for i = 1:obj.numElements
                if strcmp(obj.elements(i).element.symbol, symbol)
                    % Match found
                    count = obj.elements(i).count;
                    return;
                end
            end
        end
        
        function buildFromFormula(obj)
            % Get the components of the molecule
            components = regexp(obj.formula, '[A-Z][a-z0-9]*', 'match');
            assert(strcmp(obj.formula, [components{:}]), ...
                sprintf('Component parsing failure of ''%s''! Check capitalization\n', obj.formula));
            assert(~isempty(components), 'Invalid chemical formula ''%s''!\n', obj.formula);
            for i = 1:numel(components)
                symbol = regexp(components{i}, '[A-Za-z]+', 'match');
                assert(numel(symbol) == 1, 'Invalid chemical symbol!');
                symbol = symbol{1};
                count = regexp(components{i}, '[0-9]*', 'match');
                if ~isempty(count)
                    assert(strcmp(components{i}, [symbol count{1}]), 'Element parsing failure of ''%s''!\n', components{i});
                else
                    assert(strcmp(components{i}, symbol), 'Element parsing failure of ''%s''!\n', components{i});
                end
                if isempty(count)
                    count = 1;
                else
                    count = str2double(count{1});
                end
                
                % Check if this element already exists in the current
                % element list
                hasMatch = 0;
                for j = 1:obj.numElements
                    if strcmp(obj.elements(j).element.symbol, symbol)
                        % Match found
                        obj.elements(j).count = obj.elements(j).count + count;
                        hasMatch = 1;
                    end
                end
                if hasMatch
                    continue;
                end
                
                newElement = obj.elementDB(symbol);
                assert(~isempty(newElement), sprintf('Unrecognized element ''%s''!\n', symbol));
                obj.numElements = obj.numElements + 1;
                obj.elements(obj.numElements).element = newElement;
                obj.elements(obj.numElements).count = count;
            end
            
            % Calculate the molecular weight
            obj.mw = obj.calcMolecularWeight();
        end
        
        function molecularWeight = calcMolecularWeight(obj)
            % Calculate the molecular weight
            molecularWeight = 0;
            for i = 1:numel(obj.elements)
                molecularWeight = molecularWeight + obj.elements(i).count * obj.elements(i).element.atomicMass;
            end
        end
    end
    
    methods (Static)
        function rebuildElementDB(fidRaw)
            path = mfilename('fullpath');
            path = path(1:end - numel('Molecule'));
            if ~exist('fid', 'var')
                % Use file in class folder
                fidRaw = fopen([path, 'elementDBRaw.txt'], 'r');
            end
            
            i = 1;
            while ~feof(fidRaw)
                line = fgets(fidRaw);
                tmp = strsplit(line);
                % Format: {Atomic Mass, Name, Symbol, Atomic Number}
                atomicMass = str2double(tmp{1});
                name = tmp{2};
                symbol = tmp{3};
                atomicNumber = str2double(tmp{4});
                assert(~isempty(atomicMass) && ~isempty(name) && ~isempty(symbol) && ~isempty(atomicNumber), 'Bad element!');
                db(i).atomicMass = atomicMass;
                db(i).name = name;
                db(i).symbol =  symbol;
                db(i).atomicNumber = atomicNumber;
                i = i + 1;
            end
            
            fclose(fidRaw);
            save([path, 'elementDB.mat'], 'db');
        end
    end
    
    methods (Static)
        element = elementDB(symbol);
    end
    
end

