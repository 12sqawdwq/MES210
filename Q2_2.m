clc;
clear;
close all;

%% ====================================
% Time vector
%% ====================================

t = 0:0.01:10;

%% ====================================
% Input signal
%% ====================================

x = 3*cos(2*t) + 2*cos(15*t);

%% ====================================
% Frequency response function
%% ====================================

H = @(w) 1 ./ ((1i*w).^2 + 2*1i*w + 5);

%% ====================================
% Evaluate at w = 2
%% ====================================

H2 = H(2);

A2 = abs(H2);

phi2 = angle(H2);

%% ====================================
% Evaluate at w = 15
%% ====================================

H15 = H(15);

A15 = abs(H15);

phi15 = angle(H15);

%% ====================================
% Output signal
%% ====================================

y = 3*A2*cos(2*t + phi2) + ...
    2*A15*cos(15*t + phi15);

%% ====================================
% Plotting
%% ====================================

figure;

%% Input
subplot(2,1,1);

plot(t, x, 'LineWidth',1.5);

grid on;

xlabel('Time t');

ylabel('x(t)');

title('Input Signal');

%% Output
subplot(2,1,2);

plot(t, y, 'LineWidth',1.5);

grid on;

xlabel('Time t');

ylabel('y(t)');

title('Output Signal');

%% ====================================
% Display values
%% ====================================

fprintf('At w = 2 rad/s:\n');
fprintf('|H(j2)| = %.4f\n', A2);
fprintf('Phase = %.4f rad\n\n', phi2);

fprintf('At w = 15 rad/s:\n');
fprintf('|H(j15)| = %.4f\n', A15);
fprintf('Phase = %.4f rad\n', phi15);

%% ====================================
% Supplementary magnitude response with input frequencies marked
%% ====================================

w = 0:0.01:20;
Hw = H(w);

figure;
plot(w, abs(Hw), 'LineWidth', 1.5);
hold on;
plot(2, A2, 'ro', 'MarkerSize', 8, 'LineWidth', 1.5);
plot(15, A15, 'ms', 'MarkerSize', 8, 'LineWidth', 1.5);
grid on;
xlabel('\omega (rad/s)');
ylabel('|H(j\omega)|');
title('Magnitude Response with Input Frequencies Marked');
legend('|H(j\omega)|', '\omega=2 rad/s', '\omega=15 rad/s');
