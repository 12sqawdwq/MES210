clc;
clear;
close all;

%% System model
% y''(t)+3y'(t)+2y(t)=x'(t)+2x(t)
% H(s)=(s+2)/(s^2+3s+2)

num = [1 2];
den = [1 3 2];

t = 0:0.001:5;
x = exp(-2*t);

%% Impulse response and zero-state response
% Use the required Control System Toolbox commands when available. If the
% toolbox is unavailable, use the equivalent analytical response so that the
% script remains verifiable in base MATLAB.

if exist('tf', 'file') == 2 && exist('impulse', 'file') == 2 && exist('lsim', 'file') == 2
    sys = tf(num, den);
    [h, th] = impulse(sys, t);
    yzs = lsim(sys, x, t);
else
    th = t;
    h = exp(-t);                 % H(s)=1/(s+1) after pole-zero cancellation
    yzs = exp(-t) - exp(-2*t);   % convolution of h(t) and x(t)
end

figure;

subplot(2,1,1);
plot(th, h, 'LineWidth',1.5);
grid on;
xlabel('Time t (s)');
ylabel('h(t)');
title('Impulse Response h(t)');
axis([0 5 0 1.1]);

subplot(2,1,2);
plot(t, yzs, 'LineWidth',1.5);
grid on;
xlabel('Time t (s)');
ylabel('y_{zs}(t)');
title('Zero-State Response y_{zs}(t)');
axis([0 5 0 0.3]);

fprintf('Transfer function numerator coefficients: [%g %g]\n', num);
fprintf('Transfer function denominator coefficients: [%g %g %g]\n', den);
