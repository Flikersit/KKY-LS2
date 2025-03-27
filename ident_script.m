clc;
close all;
clear all;
%%
T = readtable("D:\prednasky\LS2\sem_prace\data_ls2.csv");
u = T.Var4;
ui = u - 0.1;
y1 = T.Var5;
y2 = T.Var6;
y1i = y1 - 18.8833333333333;
y2i = y2 - 188.4167;

%% tf1
tf1
tf1c = d2c(tf1, 'zoh');
zp = zpk(tf1c)
[num, den] = tfdata(zp, 'v');
zerosP1c = roots(num);
realParts = real(zerosP1c);
[~, indexOfFastestZero] = min(realParts);
fastestZero = zerosP1c(indexOfFastestZero);
numapprox = poly(zerosP1c([1:indexOfFastestZero-1 indexOfFastestZero+1:end]));
P1cap = tf(numapprox, den)
figure;
bode(P1cap);
hold on;
bode(tf1c);
grid on;
title("Bode plot for P_{1} tf");
saveas(gcf, 'bode_plot_p1_ident.eps', 'epsc'); % EPS
zpk(P1cap)

%% tf2
tf2
tf2c = d2c(tf2, 'zoh');
zp2 = zpk(tf2c)
[num, den] = tfdata(zp2, 'v');
zerosP2c = roots(num);
realParts = real(zerosP2c);
[~, indexOfFastestZero] = min(realParts);
fastestZero = zerosP2c(indexOfFastestZero);
numapprox = poly(zerosP2c([1:indexOfFastestZero-1 indexOfFastestZero+1:end]));
P2cap = tf(numapprox, den)
figure;
bode(P2cap);
hold on;
bode(tf2c);
grid on;
title("Bode plot for P_{2} tf");
saveas(gcf, 'bode_plot_p2_ident.eps', 'epsc'); % EPS
%%
save('myWorkspace.mat')




