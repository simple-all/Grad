function [phi, g] = evalTruss(x, pMult)
%EVALTRUSS Fitness function for the truss, linear exterior penalty

% Thomas Satterly
% AAE 550, HW 3
% Problem 4

% Default penalty multiplier
if nargin < 2
    pMult = 10;
end

% Input format:
% x(1) = Beam 1 material
% x(2) = Beam 1 cross section area [m^2]
% x(3) = Beam 2 material
% x(4) = Beam 2 cross section area [m^2]
% x(5) = Beam 3 material
% x(6) = Beam 3 cross section area [m^2]

A = x(2:2:6); % Cross section area
materials = x(1:2:5); % Material selection

% Preallocate arrays
E = zeros(1, numel(materials));
rho = zeros(1, numel(materials));
sigma_y = zeros(1, numel(materials));

% Get material properties for each beam
for i = 1:numel(materials)
    [E(i), rho(i), sigma_y(i)] = getMaterial(materials(i));
end

% Get the stress on each beam
sigmas = aae550.hw3.p4.stressHW3(A,E);

% Check constraints
g = zeros(1, numel(sigmas));
for i = 1:numel(sigmas)
    for j = -1:2:1
        g(((i - 1) * 2) + (j + 1) / 2 + 1) = (sigmas(i) / (j * sigma_y(i))) - 1;
    end
end

% Calculate penalty
P = 0;
for i = 1:numel(g)
    % Linear exterior penalty
    P = P + max(0, g(i));
end

% Get mass
L(1) = sqrt(3^2 + 3^2); % [m]
L(2) = 3; % [m]
L(3) = sqrt(3^2 + 4^2); % [m]
mass = 0;
for i = 1:numel(materials)
    mass = mass + L(i) * rho(i) * A(i);
end

% Fitness function
phi = mass + pMult * P;

    function [E, rho, sigma_y] = getMaterial(x)
        % Gets the material properties
        switch x
            case 1 % Aluminum
                E = 68.9e9; % [Pa] Young's Modulus
                rho = 2700; % [kg/m^3] Density
                sigma_y = 55.2e6; % [Pa] Yeild Stress
            case 2 % Titanium
                E = 116e9; % [Pa] Young's Modulus
                rho = 4500; % [kg/m^3] Density
                sigma_y = 140e6; % [Pa] Yeild Stress
            case 3 % Steel
                E = 205e9; % [Pa] Young's Modulus
                rho = 7872; % [kg/m^3] Density
                sigma_y = 285e6; % [Pa] Yeild Stress
            case 4 % Nickel
                E = 207e9; % [Pa] Young's Modulus
                rho = 8800; % [kg/m^3] Density
                sigma_y = 59.0e6; % [Pa] Yeild Stress
            otherwise
                error('Unrecognized material!');
        end
    end

end

