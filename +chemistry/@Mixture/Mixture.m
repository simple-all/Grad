classdef Mixture < handle
    %MIXTURE Mixtures of elements
    
    properties (SetAccess = private)
        components = struct('molecule', struct(), 'massFraction', [], 'moleFraction', []);
        inputModes = {'mass', 'moles'};
        numComponents = 0;
        mode;
        mw; % Molecular weight
    end
    
    properties (Access = private)
        didFinish = 0;
    end
    
    methods
        function obj = Mixture(inputMode)
            assert(any(strcmp(obj.inputModes, inputMode)), 'Unreconized input mode!');
            obj.mode = find(strcmp(obj.inputModes, inputMode));
        end
        
        function addComponent(obj, newComponent, value)
            % Add a new component to the mixture

            if isa(newComponent, 'struct')
                toAdd = chemistry.Molecule(newComponent);
            else
                toAdd = newComponent;
            end
            
            for i = 1:obj.numComponents
                if strcmp(toAdd.formula, obj.components(i).molecule.formula)
                    switch obj.inputModes{obj.mode}
                        case 'mass'
                            obj.components(i).massFraction = obj.components(i).massFraction + value;
                        case 'moles'
                            obj.components(i).moleFraction = obj.components(i).moleFraction + value;
                    end
                    return;
                end
            end
            
            obj.numComponents = obj.numComponents + 1;
            obj.components(obj.numComponents).molecule = toAdd;
            switch obj.inputModes{obj.mode}
                case 'mass'
                    obj.components(obj.numComponents).massFraction = value;
                case 'moles'
                    obj.components(obj.numComponents).moleFraction = value;
            end
        end
        
        function val = getComponentProperty(obj, componentName, propName)
            index = [];
            val = [];
            for i = 1:obj.numComponents
                if any(strcmp({obj.components(i).molecule.name, ...
                        obj.components(i).molecule.formula}, componentName))
                    index = i;
                    break;
                end
            end
            if isempty(index)
                error('Could not find component with name or formula %s', componentName);
            end
            
            if isfield(obj.components(index), propName)
                val = obj.components(index).(propName);
            else
                error('Property %s does not exist for component %s!', propName, componentName);
            end
        end
        
        function finish(obj)
            % Signal that we're done adding components, figure out all the
            % properties
            assert(~obj.didFinish, 'Already finished this molecule!');
            obj.didFinish = 1;
            switch obj.inputModes{obj.mode}
                case 'mass'
                    % Normalize mass fraction
                    totalMass = sum([obj.components.massFraction]);
                    
                    for i = 1:numel(obj.components)
                        obj.components(i).massFraction = obj.components(i).massFraction / totalMass;
                    end
                    
                    % Rough calculate mole fraction
                    obj.components(1).moleFraction = 1;
                    for i = 2:numel(obj.components)
                        obj.components(i).moleFraction = ...
                            ((obj.components(i).molecule.mw / obj.components(i).massFraction) / ...
                            (obj.components(1).molecule.mw / obj.components(1).massFraction)) * ...
                            obj.components(1).moleFraction;
                    end
                    
                    % Normalize mole fraction
                    totalMoles = sum([obj.components.moleFraction]);
                    
                    for i = 1:numel(obj.components)
                        obj.components(i).moleFraction = obj.components(i).moleFraction / totalMoles;
                    end
                    
                    % Calculate molecular weight
                    obj.mw = 0;
                    for i = 1:numel(obj.components)
                        obj.mw = obj.mw + obj.components(i).moleFraction * obj.components(i).molecule.mw;
                    end
                case 'moles'
                    % Normalize mole fraction
                    totalMoles = sum([obj.components.moleFraction]);
                    
                    for i = 1:numel(obj.components)
                        obj.components(i).moleFraction = obj.components(i).moleFraction / totalMoles;
                    end
                    
                    % Calculate molecular weight
                    obj.mw = 0;
                    for i = 1:numel(obj.components)
                        obj.mw = obj.mw + obj.components(i).moleFraction * obj.components(i).molecule.mw;
                    end
                    
                    % Calculate mass fractions
                    for i = 1:numel(obj.components)
                        obj.components(i).massFraction = (obj.components(i).moleFraction * obj.components(i).molecule.mw) / obj.mw;
                    end
            end
        end
        
        function count = getElementCount(obj, symbol)
            count = 0;
            for i = 1:obj.numComponents
                count = count + obj.components(i).molecule.getElementCount(symbol) * obj.components(i).moleFraction;
            end
        end
        
        function elements = getAllElements(obj)
            numElements = 0;
            for i = 1:obj.numComponents
                thisElements = obj.components(i).molecule.getAllElements();
                match = 0;
                for j = 1:numel(thisElements)
                    for k = 1:numElements
                        if elements(k).atomicNumber == thisElements(j).atomicNumber
                            match = 1;
                            continue;
                        end
                    end
                    if ~match
                        numElements = numElements + 1;
                        elements(numElements) = thisElements(j);
                    end
                end
            end
        end
        
        function printComposition(obj, tolerance)
            if ~exist('tolerance', 'var')
                tolerance = 0;
            end
            for i = 1:obj.numComponents
                if obj.components(i).moleFraction <= 0
                    continue;
                end
                fprintf('Species: %s,\tFormula: %s\n', obj.components(i).molecule.name, obj.components(i).molecule.formula);
                fprintf('\tMass Fraction: %0.6f\n', obj.components(i).massFraction);
                fprintf('\tMole Fraction: %0.6f\n', obj.components(i).moleFraction);
            end
        end
        
    end
    
end

