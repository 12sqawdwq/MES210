clc;
clear;
close all;

%% ===================================
% Parameters
%% ===================================

T = 8;

tau_values = [4 2 1];

k = -20:20;

%% ===================================
% Figure
%% ===================================

figure;

%% ===================================
% Subplot 1: Time-domain waveforms
%% ===================================

subplot(2,2,1);

hold on;

t = -4:0.001:4;

for i = 1:length(tau_values)

    tau = tau_values(i);

    x = double(abs(t) <= tau/2);

    plot(t, x, 'LineWidth',1.5);

end

grid on;

xlabel('Time t');

ylabel('x(t)');

title('Time-Domain Rectangular Pulses');

legend('\tau=4','\tau=2','\tau=1');

%% ===================================
% Frequency spectra
%% ===================================

for i = 1:length(tau_values)

    tau = tau_values(i);

    % Fourier series coefficients
    ck = (tau/T) * sinc(k*tau/T);

    subplot(2,2,i+1);

    stem(k, abs(ck), 'filled');

    grid on;

    xlabel('k');

    ylabel('|c_k|');

    title(['Magnitude Spectrum (\tau=', num2str(tau), ')']);

end