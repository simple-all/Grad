classdef Reaction < handle
    %REACTION Helps with stoichiometric reaction calculations. Only
    %considers hydrogen-oxygen reactions for now
    
    properties (SetAccess = private)
        fuel; % Mixture object
        oxidizer; % Mixture object
        phi; % Equivalence ratio
    end
    
    methods
        function obj = Reaction()
        end
        
        function setFuel(obj, fuel)
            obj.fuel = fuel;
        end
        
        function setOxidizer(obj, oxid)
            obj.oxidizer = oxid;
        end
        
        function FAR = calcStoichFAR(obj)
            molesOxid = 1; % Assume one fuel of oxidizer is fixed
            numH = obj.fuel.getElementCount('H'); % Number of hydrogen atoms per mole of fuel
            numC = obj.fuel.getElementCount('C'); % Number of carbon atoms per mole of fuel
            numO = obj.oxidizer.getElementCount('O') * molesOxid; % Number of oxygen atoms per mole of oxidizer
            
            % Assume only products we care about are H2O and CO2
            % Solve the system of linear equations
            % Oxygen balance: H2O + 2 * CO2 = numO
            % Hydrogen balance: molesFuel * numH - 2 * H2O = 0
            % Carbon balance: molesFuel * numC - CO2 = 0
            % [molesFuel H20 CO2]
            A = [0 1 2;
                numH -2 0;
                numC 0 -1];
            B = [numO;
                0;
                0];
            
            X = linsolve(A, B);
            molesFuel = X(1);
                
            FAR = (molesFuel * obj.fuel.mw) / (molesOxid * obj.oxidizer.mw);
        end
        
        function AFR = calcStoichAFR(obj)
            AFR = 1 / obj.calcStoichFAR();
        end
        
        function setEquivalenceRatio(obj, phi)
            obj.phi = phi;
        end
        
        function [mix, append] = getComposition(obj)
            FAR_stoich = obj.calcStoichFAR;
            FAR_act = obj.phi * FAR_stoich;
            
            molesOxid = 1;
            molesFuel = (FAR_act * obj.oxidizer.mw * molesOxid) / obj.fuel.mw;
            totalMoles = molesOxid + molesFuel;
            totalMass = molesOxid * obj.oxidizer.mw + molesFuel * obj.fuel.mw;
            
            append = struct();
            append.fuelMoleFraction = molesFuel / totalMoles;
            append.oxidMoleFraction = molesOxid / totalMoles;
            append.fuelMassFraction = molesFuel * obj.fuel.mw / totalMass;
            append.oxidMassFraction = molesOxid * obj.oxidizer.mw / totalMass;
            
            mix = chemistry.Mixture('moles');
            for i = 1:obj.fuel.numComponents
                moles = obj.fuel.components(i).moleFraction * molesFuel;
                if moles ~= 0
                    mix.addComponent(obj.fuel.components(i).molecule, moles);
                end
            end
            
            for i = 1:obj.oxidizer.numComponents
                moles = obj.oxidizer.components(i).moleFraction * molesOxid;
                if moles ~= 0
                    mix.addComponent(obj.oxidizer.components(i).molecule, moles);
                end
            end
            mix.finish();
        end
        
        function elements = getAllElements(obj)
            elements = obj.fuel.getAllElements();
            newElements = obj.oxidizer.getAllElements();
            for i = 1:numel(newElements)
                for j = 1:numel(elements)
                    match = 0;
                    if elements(j).atomicNumber == newElements(i).atomicNumber
                        match = 1;
                        continue;
                    end
                end
                if ~match
                    elements(end + 1) = newElements(i);
                end
            end
        end
    end
    
end

