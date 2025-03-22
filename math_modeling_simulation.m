clc;
clear all;
close all;
%% Parameters 
K = 3;
Il = 3;
b = 0.06;
Im = 1;
%% Simulation
simOut = sim('D:\prednasky\LS2\sem_prace\math_modeling_simulation.slx');
time = simOut.simout.Time;
data1 = simOut.simout.Data(:,1); 
data2 = simOut.simout.Data(:,2);

figure;
plot(time, data1, 'b-', 'LineWidth', 2); % Data1
hold on;
plot(time, data2, 'r--', 'LineWidth', 2); % Data2
hold off;

xlabel('Time (s)');
ylabel('Angle');
title('Simulation Results: \phi_{1} and \phi_{2}');
legend('\phi_{1}', '\phi_{2}');
grid on;

saveas(gcf, 'output_sinus.eps', 'epsc');

%% State-space model and its converting to the transfer function

A = [[0 1 -1]
    [-K/Im -b/Im b/Im]
    [K/Il b/Il -b/Il]];

B = [[0 0]
     [1/Im 0]
     [0 1/Il]];
 
C = [[1 0 0]
     [0 1 0]
     [0 0 1]];
 
D = [[0 0]
     [0 0]
     [0 0]];

model = ss(A, B, C, D);
tfs = tf(model);
p1 = tfs(2, 1)
p2 = tfs(3, 1)
%% bode graf for system P_{1}

figure;
bode(p1);
grid on;
title("Bode plot for P_{1} tf");
saveas(gcf, 'bode_plot_p1.eps', 'epsc'); % EPS

%% bode graf for system P_{2}

figure;
bode(p2);
grid on;
title("Bode plot for P_{2} tf");
saveas(gcf, 'bode_plot_p2.eps', 'epsc')

%% step response for system P_{1}
figure;
step(p1); 
xlim([0 50]);
grid on;
title('Step Response of the System P_{1}');
xlabel('Time(s)');
ylabel('Value');
print('step_response_p1', '-depsc', '-r300')

%% step response for system P_{2}
figure;
step(p2); 
xlim([0 50]);
grid on;
title('Step Response of the System P_{2}');
xlabel('Time(s)');
ylabel('Value');
saveas(gcf, 'step_response_p2.eps', 'epsc');

%% Nyquist diagramm for system P_{1}

figure;
nyquist(p1);
title("Nyquist plot for P_{1} tf");
saveas(gcf, 'nyquist_plot_p1.eps', 'epsc')

%% Nyquist diagramm for system P_{2}

figure;
nyquist(p2);
title("Nyquist plot for P_{2} tf");
saveas(gcf, 'nyquist_plot_p2.eps', 'epsc')

%% Antiresonance for P_{1} system
omega = 1;
A = 1;
T = 100;
dt = 0.01;
t = 0:dt:T;
u = A * sin(omega*t);
[y, t_out] = lsim(p1, u, t);
plot(t_out, y, 'b', t, u, 'r--')
legend('Output signal', 'Input signal')
xlabel('Time (s)')
ylabel('Amplitude')
title('Antiresonance')
grid on
saveas(gcf, 'antirezonance_plot_p1.eps', 'epsc')

%% Resonance for P_{1} system
omega = 2;
A = 1;
T = 100;
dt = 0.01;
t = 0:dt:T;
u = A * sin(omega*t);
[y, t_out] = lsim(p1, u, t);
plot(t_out, y, 'b', t, u, 'r--')
legend('Output signal', 'Input signal')
xlabel('Time (s)')
ylabel('Amplitude')
title('Resonance')
grid on
saveas(gcf, 'Rezonance_plot_p1.eps', 'epsc')
