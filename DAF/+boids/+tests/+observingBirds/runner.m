close all;
clear;

xlsFile = strrep('+boids\+tests\+observingBirds\observingBirds.xlsx', '\', filesep());
xlsModel=publicsim.models.excelBased.excelModelBuilder(xlsFile);
xlsModel.run();
log=xlsModel.getLogger();

% Create a analysis coordinator
coordinator = publicsim.analysis.Coordinator();

% Get the movement analyzer
birdAnalyzer = coordinator.requestAnalyzer('boids.analysis.Bird', log);

frames = birdAnalyzer.animateBirds(xlsModel.simEarth);