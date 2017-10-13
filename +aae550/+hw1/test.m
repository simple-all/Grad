import aae550.hw1.*;
close all;
clear;

k1 = 3000; 
k2 = 1000;
k3 = 2500;
k4 = 1500;
P1 = 500;
P2 = 1000;

K = [k1 + k2, -k2; -k2, k2 + k3 + k4];
P = [P1; P2];


dx = 0.00001;
x2 = 1;
iter = 0;
for x1 = 1:0.01:10
    iter = iter + 1;
    x = [x1; x2];
    df_1(iter) = (f(x + [dx; 0], K, P) - f(x, K, P)) / dx;
    df_2(iter) = (f(x + [0; dx], K, P) - f(x, K, P)) / dx;
    df(:, iter) = gradF(x, K, P);
end
x1 = 1:0.01:10;
figure;
hold on;
plot(x1, df_1);
plot(x1, df(1, :));

figure;
hold on;
plot(x1, df_2);
plot(x1, df(2, :));
