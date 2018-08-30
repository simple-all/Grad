function [cycles, isCorrect] = runner()

% Create the cell block
cellBlock = prison.CellBlock();

% Create inmates;
numInmates = 27;
for i = 1:numInmates - 1
    newInmate = prison.Inmate(prison.InmateFuncs.DoOnlyOnce());
    cellBlock.AddInmate(newInmate);
end

newInmate = prison.Inmate(prison.InmateFuncs.RecordKeeper(numInmates - 1));
cellBlock.AddInmate(newInmate);

warden = prison.Warden(cellBlock);

states = [0 0];
isDone = 0;
cycles = 0;
while ~isDone
    cycles = cycles + 1;
    next = warden.getNextInmate();
    [isDone, states] =next.interact(states);
end

isCorrect = warden.isDone();

end