ceaRunner = nasa.CEARunner();

n = chemistry.Molecule('Nitrogen', 'N');
h = chemistry.Molecule('Hydrogen', 'H');
c = chemistry.Molecule('Carbon', 'C');
o = chemistry.Molecule('Oxygen', 'O');

% Define natural gas
HTPB = chemistry.Mixture('moles');
HTPB.addComponent(c, 7.075);
HTPB.addComponent(h, 10.65);
HTPB.addComponent(n, 0.063);
HTPB.addComponent(o, 0.223);
HTPB.finish();








data = ceaRunner.run('problem', 'rocket', 'equilibrium', ...
    'p,psi', 42.1451, 'o/f', 12.8, 'pip', 3.5, 'reac', ...
    'fuel','HTPB', ...
    'C', HTPB.getComponentProperty('Carbon', 'moleFraction'), ...
    'H', HTPB.getComponentProperty('Hydrogen', 'moleFraction'), ...
    'N', HTPB.getComponentProperty('Nitrogen', 'moleFraction'), ...
    'O', HTPB.getComponentProperty('Oxygen', 'moleFraction'), ...
    't,K', 298.15, ...
    'h,kJ/kg', -0.69645751e2, ...
    'ox', 'Air', 'wt', 100, 't,K', 298.15, 'outp', 'trans', 'end');