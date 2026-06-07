clc;
clear;
close all;

%% Parameters

L = 0.6;
C = 0.2;
R = 2;

num = [1];
den = [L*C R*C 1];

%% Frequency response using freqs()

w = 0:0.01:20;
H = freqs(num, den, w);

magH = abs(H);
phaseH = angle(H) * 180/pi;

figure;

subplot(2,1,1);
plot(w, magH, 'LineWidth', 1.5);
grid on;
xlabel('\omega (rad/s)');
ylabel('|H(j\omega)|');
title('Magnitude Response of RLC Low-Pass Filter');

subplot(2,1,2);
plot(w, phaseH, 'LineWidth', 1.5);
grid on;
xlabel('\omega (rad/s)');
ylabel('Phase (degrees)');
title('Phase Response of RLC Low-Pass Filter');

%% Zero-state response

t = 0:0.01:10;
x = sin(t) + sin(20*t);

if exist('tf', 'file') == 2 && exist('lsim', 'file') == 2
    sys = tf(num, den);
    y = lsim(sys, x, t);
else
    % Equivalent numerical state-space simulation for
    % 0.12*y'' + 0.4*y' + y = x under zero initial conditions.
    ode = @(tt, state) [state(2); ...
        (interp1(t, x, tt, 'linear', 'extrap') ...
        - R*C*state(2) - state(1)) / (L*C)];
    [~, state] = ode45(ode, t, [0 0]);
    y = state(:,1);
end

figure;

plot(t, x, 'LineWidth', 1.2);
hold on;
plot(t, y, 'LineWidth', 1.5);

grid on;
xlabel('Time t (s)');
ylabel('Amplitude');
title('Input Signal and Zero-State Output');
legend('Input x(t)', 'Output y_{zs}(t)');

[~, cutoff_idx] = min(abs(magH - 1/sqrt(2)));
fprintf('Estimated -3 dB cutoff frequency: %.2f rad/s\n', w(cutoff_idx));
