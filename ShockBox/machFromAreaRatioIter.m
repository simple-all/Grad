% machFromAreaRatio
% Inputs:
%	H: Area Ratio, A / A_star
%	gamma: Ratio of Specific Heats
%	isSonic: 1 -> Supersonic Solution, 0 -> Subsonic Solution

function Ma = machFromAreaRatioIter(H, gamma, isSonic)

maxErr = 1e-6;

if (isSonic == 1)
	Ma = 2;
else
	Ma = 0.5;
end

dir = 1;
last = 1;
i = -2;
err = maxErr + 1;
while (abs(err) > maxErr)
	H_guess = (1 / Ma) * ((2 + (gamma - 1) * (Ma^2)) / (gamma + 1))^((gamma + 1) / (2 * (gamma - 1)));
	err = H_guess - H;
	if isSonic == 1
		if err > 0
			dir = -1;
		else
			dir = 1;
		end
	else
		if err > 0
			dir = 1;
		else
			dir = -1;
		end
	end
	
	if dir ~= last
		i = i - 1;
	end
	
	Ma = Ma + (dir * 2^i);
	if isSonic == 1
		if Ma < 1
			Ma = 1;
			dir = 1;
		end
	else
		if Ma > 1
			Ma = 1;
			dir = -1;
		end
	end
	last = dir;
end



end

