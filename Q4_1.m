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

%% ====================================
% Supplementary geometric distance illustration
%% ====================================

f0 = 10;
omega0 = 2*pi*f0;
jw0 = 1i*omega0;

d_z1 = abs(jw0 - z1);
d_z2 = abs(jw0 - z2);
d_p1 = abs(jw0 - p1);
d_p2 = abs(jw0 - p2);
H0_geo = (d_z1*d_z2)/(d_p1*d_p2);

figure;
hold on;

plot(real(z1), imag(z1), 'ob', 'MarkerSize', 10, 'LineWidth', 2);
plot(real(p1), 0, 'xr', 'MarkerSize', 10, 'LineWidth', 2);
plot(real(p2), 0, 'xr', 'MarkerSize', 10, 'LineWidth', 2);
plot(real(jw0), imag(jw0), 'ks', 'MarkerSize', 8, 'LineWidth', 1.5);

plot([real(jw0) real(z1)], [imag(jw0) imag(z1)], 'b-', 'LineWidth', 1.3);
plot([real(jw0) real(p1)], [imag(jw0) 0], 'r-', 'LineWidth', 1.3);
plot([real(jw0) real(p2)], [imag(jw0) 0], 'm-', 'LineWidth', 1.3);

text(4, omega0, sprintf('jw0, f0=%d Hz', f0), ...
    'FontSize', 9, 'Interpreter', 'none');
text(-18, omega0/2, sprintf('|jw0-z| = %.2f\n(double zero)', d_z1), ...
    'FontSize', 8, 'BackgroundColor', 'w', 'EdgeColor', [0.4 0.6 1.0], ...
    'Margin', 4, 'Interpreter', 'none');
text(-72, omega0/2, sprintf('|jw0-p1| = %.2f', d_p1), ...
    'FontSize', 8, 'BackgroundColor', 'w', 'EdgeColor', [1.0 0.4 0.4], ...
    'Margin', 4, 'Interpreter', 'none');
text(-132, omega0/2, sprintf('|jw0-p2| = %.2f', d_p2), ...
    'FontSize', 8, 'BackgroundColor', 'w', 'EdgeColor', [1.0 0.4 0.8], ...
    'Margin', 4, 'Interpreter', 'none');

formula_text = sprintf('|H(jw0)| = (%.2f^2)/(%.2f x %.2f) = %.4f', ...
    d_z1, d_p1, d_p2, H0_geo);
text(-138, 76, formula_text, 'FontSize', 9, ...
    'BackgroundColor', 'w', 'EdgeColor', [0.6 0.6 0.6], ...
    'Margin', 5, 'Interpreter', 'none');

grid on;
box on;
xlabel('Real Axis');
ylabel('Imaginary Axis');
title('Geometric Distance Illustration at j\omega_0');
legend('Double zero at 0', 'Pole p_1=-80', 'Pole p_2=-120', 'Point j\omega_0', ...
    'Zero distance', 'Pole distance to p_1', 'Pole distance to p_2', ...
    'Location', 'southoutside', 'Orientation', 'horizontal', ...
    'NumColumns', 4, 'FontSize', 8);
axis([-150 20 -10 85]);
