% this file provides input variables to the genetic algorithm
% upper and lower bounds, and number of bits chosen for "egg-crate" problem
% Modified on 11/10/09 by Bill Crossley.

close all;
clear all;

options = aae550.hw3.p3.goptions([]);

vlb = [1 1e-4 1 1e-4 1 1e-4];	%Lower bound of each gene - all variables
vub = [4 1e-3 4 1e-3 4 1e-3];	%Upper bound of each gene - all variables
bits =[2 40 2 40 2 40];	%number of bits describing each gene - all variables

l = sum(bits);

nPop = 4 * l; % Basic guidline
pMutation = (l + 1) / (2 * nPop * l);

options(11) = nPop; % Set the population size
options(13) = pMutation; % Set the mutation probability
options(14) = 1e6;
%	OPTIONS(11)-Population size (fixed)
%	OPTIONS(12)-Probability of crossover
%	OPTIONS(13)-Probability of mutation
%	OPTIONS(14)-Maximum number of generations, always used as safeguard
pMult = 5e2; % Penalty multiplier
[x,fbest,stats,nfit,fgen,lgen,lfit]= aae550.hw3.p3.GA550(@(x) aae550.hw3.p4.evalTruss(x, pMult),[ ],options,vlb,vub,bits);


disp(x)
[phi, g] = aae550.hw3.p4.evalTruss(x)
assert(all(g <= 0), 'Constraints violated!');