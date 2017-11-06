close all;
clear;

xlsFile = '+boids\+tests\+networkedParentChild\networkedParentChild.xlsx';
xlsModel=publicsim.models.excelBased.excelModelBuilder(xlsFile);
xlsModel.run();
log=xlsModel.getLogger();

% Create a analysis coordinator
coordinator = publicsim.analysis.Coordinator();

% Get the movement analyzer
birdAnalyzer = coordinator.requestAnalyzer('boids.analysis.Bird', log);

frames = birdAnalyzer.animateBirds(xlsModel.simEarth);

figure;
% Plot the network
xlsModel.simNetwork.vizualizeGraph(xlsModel.simNetwork);