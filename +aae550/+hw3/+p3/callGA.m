% Thomas Satterly
% AAE 550, HW 3
% Problem 3

close all;
clear all;

options = aae550.hw3.p3.goptions([]);

vlb = [-5.12 -5.12]; % Lower bounds on genes
vub = [5.12 5.12]; % Upper bounds on genes
bits =[10 10]; % Number of bits per gene

l = sum(bits); % Length of the chromosome

% Basic guidelines for population and mutation rate
nPop = 4 * l;
pMutation = (l + 1) / (2 * nPop * l);

options(11) = nPop; % Set the population size
options(13) = pMutation; % Set the mutation probability

[x,fbest,stats,nfit,fgen,lgen,lfit]= aae550.hw3.p3.GA550(@(x) aae550.hw3.Rastrigin(x),[ ],options,vlb,vub,bits);

disp(x)