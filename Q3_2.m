clc;
clear;
close all;

%% ===============================
% Parameters
%% ===============================

fs = 1000;              % Sampling frequency
dt = 1/fs;              % Sampling interval
t = 0:dt:22;            % Time vector

N = length(t);          % Number of samples

%% ===============================
% Signals
%% ===============================

% Baseband signal
g = 4*cos(8*t) + 3*cos(16*t);

% Carrier signal
c = cos(120*t);

% AM-DSB-SC modulated signal
f = g .* c;

% Coherent demodulated signal before filtering
g0 = f .* c;

%% ===============================
% Ideal low-pass filtering in frequency domain
%% ===============================

% FFT of g0
G0 = fft(g0);

% Shift zero frequency to center
G0_shift = fftshift(G0);

% Frequency axis in Hz
freq = (-N/2:N/2-1) * (fs/N);

% Convert frequency axis to rad/s
omega = 2*pi*freq;

% Ideal low-pass filter
H = double(abs(omega) < 25);

% Apply filter
G1_shift = G0_shift .* H;

% Shift back and inverse FFT
G1 = ifftshift(G1_shift);

g1 = real(ifft(G1));

%% ===============================
% Time-domain waveforms
%% ===============================

figure;

subplot(4,1,1);
plot(t, g, 'LineWidth', 1.2);
grid on;
xlabel('Time t (s)');
ylabel('g(t)');
title('Baseband Signal g(t)');
xlim([0 5]);

subplot(4,1,2);
plot(t, f, 'LineWidth', 1.2);
grid on;
xlabel('Time t (s)');
ylabel('f(t)');
title('Modulated Signal f(t)');
xlim([0 5]);

subplot(4,1,3);
plot(t, g0, 'LineWidth', 1.2);
grid on;
xlabel('Time t (s)');
ylabel('g_0(t)');
title('Demodulated Signal before Filtering');
xlim([0 5]);

subplot(4,1,4);
plot(t, g1, 'LineWidth', 1.2);
grid on;
xlabel('Time t (s)');
ylabel('g_1(t)');
title('Recovered Signal after Low-Pass Filtering');
xlim([0 5]);

%% ===============================
% Frequency spectra
%% ===============================

G = fftshift(fft(g));
F = fftshift(fft(f));
G0_plot = fftshift(fft(g0));
G1_plot = fftshift(fft(g1));

% Normalize spectra
G_mag = abs(G)/N;
F_mag = abs(F)/N;
G0_mag = abs(G0_plot)/N;
G1_mag = abs(G1_plot)/N;

figure;

subplot(4,1,1);
plot(omega, G_mag, 'LineWidth', 1.2);
grid on;
xlabel('\omega (rad/s)');
ylabel('|G(j\omega)|');
title('Spectrum of g(t)');
xlim([-200 200]);

subplot(4,1,2);
plot(omega, F_mag, 'LineWidth', 1.2);
grid on;
xlabel('\omega (rad/s)');
ylabel('|F(j\omega)|');
title('Spectrum of f(t)');
xlim([-200 200]);

subplot(4,1,3);
plot(omega, G0_mag, 'LineWidth', 1.2);
grid on;
xlabel('\omega (rad/s)');
ylabel('|G_0(j\omega)|');
title('Spectrum of g_0(t)');
xlim([-300 300]);

subplot(4,1,4);
plot(omega, G1_mag, 'LineWidth', 1.2);
grid on;
xlabel('\omega (rad/s)');
ylabel('|G_1(j\omega)|');
title('Spectrum of g_1(t)');
xlim([-200 200]);

%% ===============================
% Supplementary amplitude restoration check
%% ===============================

g1_restored = 2*g1;

figure;
plot(t, g, 'LineWidth', 1.2);
hold on;
plot(t, g1, '--', 'LineWidth', 1.2);
plot(t, g1_restored, ':', 'LineWidth', 1.8);
grid on;
xlabel('Time t (s)');
ylabel('Amplitude');
title('Original g(t), Recovered g_1(t), and Amplitude-Restored 2g_1(t)');
legend('Original g(t)', 'Recovered g_1(t)', 'Amplitude-restored 2g_1(t)');
xlim([0 5]);

mse_unscaled = mean((g - g1).^2);
mse_restored = mean((g - g1_restored).^2);
fprintf('MSE between g(t) and g_1(t): %.6f\n', mse_unscaled);
fprintf('MSE between g(t) and 2g_1(t): %.6f\n', mse_restored);
