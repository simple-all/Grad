clear;
clc;
close all;

batchSize = 1e4;

cycles = nan(1, batchSize);
correct = nan(1, batchSize);
parfor i = 1:batchSize
    [add, cr] = prison.runner();
    cycles(i) = add;
    correct(i) = cr;
end

histogram(cycles);
fprintf('Mean is %0.2f cycles\n', mean(cycles));
fprintf('Failed %d\n', sum(~correct));