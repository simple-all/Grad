function sigma = stressHW3(A,E)
% This function assembles the stiffness matrix and computes the stress in
% each element of the three-bar truss in AAE 550, HW 3, part II, Fall 2017.
%
% The function returns a three-element vector "sigma"; each element is the computed
% stress in each truss element.  The input is the three-element vector "A";
% each element is the cross-sectional area of each truss element.  Values
% for Young's modulus are input as parameters

% fixed values
P = 120000;                     % applied load [N]

% Lengths of Elements
L(1) = sqrt(3^2+3^2);	% length of element 1 [m]
L(2) = 3;               % length of element 2 [m]
L(3) = sqrt(3^2+4^2);   % length of element 3 [m]

% local stiffness matrices
theta1 = -45;
theta2 = -90;
theta3 = -180+atand(3/4);

K1 = [cosd(theta1) sind(theta1)]'*(E(1)*A(1)/L(1))*[cosd(theta1) sind(theta1)];
K2 = [cosd(theta2) sind(theta2)]'*(E(2)*A(2)/L(2))*[cosd(theta2) sind(theta2)];
K3 = [cosd(theta3) sind(theta3)]'*(E(3)*A(3)/L(3))*[cosd(theta3) sind(theta3)];

% global (total) stiffness matrix:
K = K1 + K2 + K3;

% load vector (note lower case to distinguish from P)
theta4 = -35;
p = P*[cosd(theta4) sind(theta4)]';

% compute displacements (u(1) = x-displacement on figure; u(2) =
% y-displacement on figure)
u = K \ p;

% change in element length under load
DL(1) = sqrt((-L(1)*cosd(theta1)-u(1))^2 + (-L(1)*sind(theta1)-u(2))^2) - L(1);
DL(2) = sqrt((-L(2)*cosd(theta2)-u(1))^2 + (-L(2)*sind(theta2)-u(2))^2) - L(2);
DL(3) = sqrt((-L(3)*cosd(theta3)-u(1))^2 + (-L(3)*sind(theta3)-u(2))^2) - L(3);

% stress in each element
sigma = E .* DL ./ L;
