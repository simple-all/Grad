function element = elementDB(symbol)
path = mfilename('fullpath');
path = path(1:end - numel('elementDB'));
load([path, 'elementDB.mat']);

index = find(strcmp(symbol, {db.symbol}));
element = db(index);
end
