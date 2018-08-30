clear;
clc;

ch4 = chemistry.Molecule('Methane', 'CH4');
c2h6 = chemistry.Molecule('Ethane', 'C2H6');
c3h8 = chemistry.Molecule('Propane', 'C3H8');
n2 = chemistry.Molecule('Nitrogen', 'N2');
o2 = chemistry.Molecule('Oxygen', 'O2');
co2 = chemistry.Molecule('Carbon Dioxide', 'CO2');

% Define natural gas
ng = chemistry.Mixture('moles');
ng.addComponent(ch4, 0.939);
ng.addComponent(c2h6, 0.042);
ng.addComponent(c3h8, 0.003);
ng.addComponent(co2, 0.005);
ng.addComponent(n2, 0.011);
ng.finish();

% Define air
air = chemistry.Mixture('moles');
air.addComponent(o2, 1);
air.addComponent(n2, 3.76/ 2 );
air.finish();

% Define reaction
rxn = chemistry.Reaction();
rxn.setFuel(ng);
rxn.setOxidizer(air);
rxn.setEquivalenceRatio(0.7);
premixed = rxn.getComposition();
premixed.printComposition();


