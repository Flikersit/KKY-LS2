clc;
clear all;
close all;
%%
K = 3;
Il = 3;
b = 0.06;
Im = 1;
%%
simOut = sim('D:\prednasky\LS2\sem_prace\math_modeling_simulation.slx');
time = simOut.simout.Time; % Время
data1 = simOut.simout.Data(:,1); % Первый столбец (Data:1)
data2 = simOut.simout.Data(:,2);

figure;
plot(time, data1, 'b-', 'LineWidth', 2); % Data1 - синий
hold on;
plot(time, data2, 'r--', 'LineWidth', 2); % Data2 - красный пунктир
hold off;

% Добавляем подписи
xlabel('Time (s)');
ylabel('Angle');
title('Simulation Results: \phi_{1} and \phi_{2}');
legend('\phi_{1}', '\phi_{2}');
grid on;

saveas(gcf, 'output.eps', 'epsc');
