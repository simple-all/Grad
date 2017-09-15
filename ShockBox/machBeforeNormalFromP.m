function M = machBeforeNormalFromP(PRat, gamma)
% Calculates the mach before the normal shock that provides a stagnation
% pressure ratio

% Assume M = 1.5 to start
M = 1.5;
maxErr = 1e-8;

err = 1;
dir = 1;
last = 1;
i = -1;
while (err > maxErr)
	PRat_Guess = calcPRat(M, gamma);
	if (PRat_Guess > PRat)
		% Increase mach number
		dir = 1;
	else
		dir = -1;
	end
	
	err = abs(PRat - PRat_Guess);
	
	if (dir ~= last)
		i = i - 1;
	end
	last = dir;
	M = M + (dir * 2^i);

	if (M < 1)
		M = 1;
	end
end



end

