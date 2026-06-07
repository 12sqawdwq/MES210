clc; clear; close all;

%% (1) Single-sided exponential decay: x1(t)=3e^(-2t)u(t)
t = -2:0.001:5;
u = double(t >= 0);
x1 = 3 * exp(-2*t) .* u;

figure;
plot(t, x1, 'LineWidth', 1.5);
grid on;
xlabel('t');
ylabel('x_1(t)');
title('Single-sided Exponential Decay: x_1(t)=3e^{-2t}u(t)');

%% (2) Sinusoidal signal: x2(t)=1.5sin(4πt−π/3)
t = -1:0.001:2;
x2 = 1.5 * sin(4*pi*t - pi/3);

figure;
plot(t, x2, 'LineWidth', 1.5);
grid on;
xlabel('t');
ylabel('x_2(t)');
title('Sinusoidal Signal: x_2(t)=1.5sin(4\pit-\pi/3)');

%% (3) Rectangular pulse signal
t = -2:0.001:4;
x3 = 1.5 * double(t >= 0 & t <= 2);

figure;
plot(t, x3, 'LineWidth', 1.5);
grid on;
xlabel('t');
ylabel('x_3(t)');
title('Rectangular Pulse Signal');
axis([-1 3 -0.5 2]);

%% (4) Tremolo Effect Demonstration
fs = 8192;              % sampling frequency
t = 0:1/fs:3;           % 3 seconds
carrier = sin(2*pi*880*t);
modulator = 1 + 0.7*sin(2*pi*5*t);
x4 = carrier .* modulator;

% Plot first 0.5 seconds
figure;
idx = t <= 0.5;
plot(t(idx), x4(idx), 'LineWidth', 1);
grid on;
xlabel('t (s)');
ylabel('x_4(t)');
title('Tremolo Signal: First 0.5 Seconds');

% Play the whole 3-second audio unless batch verification disables audio.
if ~strcmp(getenv('MES210_SKIP_SOUND'), '1')
    sound(x4, fs);
end
