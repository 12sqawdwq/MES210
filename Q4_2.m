clc;
clear;
close all;

%% ====================================
% Numerator and denominator
%% ====================================

num = [1 4 3];
den = [1 1 7 2];

%% ====================================
% Compute zeros and poles
%% ====================================

z = roots(num);
p = roots(den);

%% ====================================
% Enhanced pole-zero map
%% ====================================

figure;
hold on;

% Damping-ratio rays and natural-frequency arcs, drawn manually so the
% figure remains available without Control System Toolbox.
zeta_values = [0.08 0.16 0.25 0.36 0.48 0.62 0.78 0.92];
wn_values = 1:4;
xlim_values = [-3.4 2.2];
ylim_values = [-5.2 5.2];

for i = 1:length(zeta_values)
    zeta = zeta_values(i);
    theta = acos(zeta);
    r = linspace(0, 5, 200);
    x = -r*cos(theta);
    y = r*sin(theta);
    plot(x, y, '-', 'Color', [0.88 0.88 0.88], 'LineWidth', 0.8, 'HandleVisibility', 'off');
    plot(x, -y, '-', 'Color', [0.88 0.88 0.88], 'LineWidth', 0.8, 'HandleVisibility', 'off');

    label_r = 4.35;
    text(-label_r*cos(theta), label_r*sin(theta), sprintf('%.2f', zeta), ...
        'Color', [0.75 0.75 0.75], 'FontSize', 8, ...
        'HorizontalAlignment', 'center', 'HandleVisibility', 'off');
end

phi = linspace(pi/2, 3*pi/2, 250);
for i = 1:length(wn_values)
    wn = wn_values(i);
    plot(wn*cos(phi), wn*sin(phi), '-', 'Color', [0.90 0.90 0.90], ...
        'LineWidth', 0.8, 'HandleVisibility', 'off');
    text(0.03, wn, sprintf('%d', wn), 'Color', [0.78 0.78 0.78], ...
        'FontSize', 8, 'HandleVisibility', 'off');
    text(0.03, -wn, sprintf('%d', wn), 'Color', [0.78 0.78 0.78], ...
        'FontSize', 8, 'HandleVisibility', 'off');
end

plot([xlim_values(1) xlim_values(2)], [0 0], ':', 'Color', [0.70 0.70 0.70], ...
    'HandleVisibility', 'off');
plot([0 0], [ylim_values(1) ylim_values(2)], ':', 'Color', [0.70 0.70 0.70], ...
    'HandleVisibility', 'off');

zero_handle = plot(real(z), imag(z), 'ob', 'MarkerSize', 9, ...
    'LineWidth', 2, 'DisplayName', 'Zeros');
pole_handle = plot(real(p), imag(p), 'xr', 'MarkerSize', 10, ...
    'LineWidth', 2, 'DisplayName', 'Poles');

% Annotation boxes for zeros.
for i = 1:length(z)
    info = sprintf('Zero %.0f\nDamping: 1\nOvershoot: 0%%\nFrequency: %.3g rad/s', ...
        real(z(i)), abs(real(z(i))));

    if real(z(i)) < -2
        text_pos = [-3.25, -1.80];
    else
        text_pos = [-2.05, -3.35];
    end

    plot([real(z(i)) text_pos(1)+0.12], [imag(z(i)) text_pos(2)+0.35], ...
        '-', 'Color', [0.55 0.55 0.55], 'LineWidth', 0.8, 'HandleVisibility', 'off');

    text(text_pos(1), text_pos(2), info, ...
        'FontSize', 7.5, 'BackgroundColor', 'w', 'EdgeColor', [0.65 0.65 0.65], ...
        'Margin', 4, 'Interpreter', 'none', 'HandleVisibility', 'off');
end

% Annotation boxes for poles.
for i = 1:length(p)
    sigma = real(p(i));
    omega_d = imag(p(i));
    wn = abs(p(i));
    zeta = -sigma / wn;

    if zeta > 0 && zeta < 1
        overshoot = exp(-zeta*pi/sqrt(1-zeta^2)) * 100;
    else
        overshoot = 0;
    end

    if abs(omega_d) < 1e-10
        pole_label = sprintf('Pole %.3f', sigma);
    elseif omega_d > 0
        pole_label = sprintf('Pole %.3f + %.3fi', sigma, omega_d);
    else
        pole_label = sprintf('Pole %.3f - %.3fi', sigma, abs(omega_d));
    end

    info = sprintf('%s\nDamping: %.3f\nOvershoot: %.1f%%\nFrequency: %.3g rad/s', ...
        pole_label, zeta, overshoot, wn);

    if omega_d > 0
        text_pos = [0.65 3.25];
    elseif omega_d < 0
        text_pos = [0.65 -4.55];
    else
        text_pos = [0.75 -0.95];
    end

    plot([real(p(i)) text_pos(1)+0.08], [imag(p(i)) text_pos(2)+0.35], ...
        '-', 'Color', [0.45 0.70 1.00], 'LineWidth', 0.8, 'HandleVisibility', 'off');

    text(text_pos(1), text_pos(2), info, ...
        'FontSize', 7.5, 'BackgroundColor', 'w', 'EdgeColor', [0.45 0.70 1.00], ...
        'Margin', 4, 'Interpreter', 'none', 'HandleVisibility', 'off');
end

grid on;
box on;
xlim(xlim_values);
ylim(ylim_values);

xlabel('Real Axis (s^{-1})');
ylabel('Imaginary Axis (s^{-1})');
title('Experiment 4.2: Pole-Zero Map of H(s)');
legend([zero_handle pole_handle], 'Location', 'southoutside', 'Orientation', 'horizontal');

%% ====================================
% Display values
%% ====================================

disp('Zeros:');
disp(z);

disp('Poles:');
disp(p);

for i = 1:length(p)
    sigma = real(p(i));
    wn = abs(p(i));
    zeta = -sigma / wn;
    fprintf('Pole %d: damping ratio = %.4f, natural frequency = %.4f rad/s\n', ...
        i, zeta, wn);
end

if all(real(p) < 0)
    disp('Stability: stable because all poles lie in the left half-plane.');
else
    disp('Stability: unstable because at least one pole is not in the left half-plane.');
end
