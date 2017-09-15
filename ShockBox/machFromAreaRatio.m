% machFromAreaRatio
% Inputs:
%	H: Area Ratio, A / A_star
%	gamma: Ratio of Specific Heats
%	isSonic: 1 -> Supersonic Solution, 0 -> Subsonic Solution

function Ma = machFromAreaRatio(H, gamma, isSonic)

maxErr = 1e-6;

if (isSonic == 1)
	Ma_guess = 2;
else
	Ma_guess = 0.0001;
end

err = maxErr + 1;
while (err > maxErr)
	Ma_next = Ma_guess - (f(Ma_guess) / fprime(Ma_guess));
	err = abs(Ma_next - Ma_guess);
	Ma_guess = Ma_next;
end

Ma = Ma_guess;

	function val = f(Ma)
		val = H - (1 / Ma) * ((2 + (gamma - 1) * (Ma^2)) / (gamma + 1))^((gamma + 1) / (2 * (gamma - 1)));
	end

	function val = fprime(Ma)
		val = (1 / Ma^2) * ((2 + (gamma - 1) * (Ma^2)) / (gamma + 1))^((gamma + 1) / (2 * (gamma - 1)));
		val = val - ((2 + (gamma - 1) * (Ma^2)) / (gamma + 1))^(((gamma + 1) / (2 * (gamma - 1))) - 1);
	end

end