clc;
clear;
close all;

%% ====================================
% Poles and zeros
%% ====================================

p1 = -80;
p2 = -120;

z1 = 0;
z2 = 0;

%% ====================================
% Frequency range
%% ====================================

f = 0:1:1000;

omega = 2*pi*f;

%% ====================================
% Geometric evaluation
%% ====================================

num = abs(1i*omega-z1) .* ...
      abs(1i*omega-z2);

den = abs(1i*omega-p1) .* ...
      abs(1i*omega-p2);

H_geo = num ./ den;

%% ====================================
% freqs() verification
%% ====================================

num_tf = [1 0 0];

den_tf = conv([1 80],[1 120]);

H_freqs = freqs(num_tf, den_tf, omega);

%% ====================================
% Combined Figure
%% ====================================

figure;

%% ====================================
% Subplot 1: Pole-Zero Plot
%% ====================================

subplot(1,2,1);

plot(real(z1), imag(z1), 'ob', ...
    'MarkerSize',10,'LineWidth',2);

hold on;

plot(real(p1), 0, 'xr', ...
    'MarkerSize',10,'LineWidth',2);

plot(real(p2), 0, 'xr', ...
    'MarkerSize',10,'LineWidth',2);

grid on;

xlabel('Real Axis');
ylabel('Imaginary Axis');

title('Pole-Zero Plot');

legend('Zeros','Poles');

axis([-150 50 -50 50]);

%% ====================================
% Subplot 2: Frequency Response
%% ====================================

subplot(1,2,2);

plot(f, H_geo, 'LineWidth',1.5);

hold on;

plot(f, abs(H_freqs), '--', ...
    'LineWidth',1.5);

grid on;

xlabel('Frequency (Hz)');
ylabel('|H(j\omega)|');

title('Magnitude Response Comparison');

legend('Geometric Method','freqs()');