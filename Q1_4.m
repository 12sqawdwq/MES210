clc;
clear;
close all;

%% ====================================
% Different sampling intervals
%% ====================================

p_values = [0.2 0.1 0.05 0.02];

figure;

hold on;

%% ====================================
% Numerical convolution for each p
%% ====================================

for i = 1:length(p_values)

    p = p_values(i);

    % Time vector
    t = -2:p:2;

    % Signal f1(t)
    f1 = 1.5 * double(t >= -1 & t <= 1);

    % Signal f2(t)
    f2 = 2 * double(t >= -1 & t <= 1);

    % Numerical convolution
    y = conv(f1, f2) * p;

    % Output time vector
    ty = (min(t)+min(t)):p:(max(t)+max(t));

    % Plot
    plot(ty, y, 'LineWidth',1.5);

end

%% ====================================
% Figure settings
%% ====================================

grid on;

xlabel('Time t');
ylabel('y(t)');

title('Numerical Convolution with Different Sampling Intervals');

legend('p=0.2','p=0.1','p=0.05','p=0.02');

%% ====================================
% Reference solution
%% ====================================

p_ref = 0.001;

t_ref = -2:p_ref:2;

f1_ref = 1.5 * double(t_ref >= -1 & t_ref <= 1);

f2_ref = 2 * double(t_ref >= -1 & t_ref <= 1);

y_ref = conv(f1_ref, f2_ref) * p_ref;

ty_ref = (min(t_ref)+min(t_ref)):p_ref:(max(t_ref)+max(t_ref));

%% ====================================
% Error analysis
%% ====================================

fprintf('Error Analysis:\n\n');

for i = 1:length(p_values)

    p = p_values(i);

    t = -2:p:2;

    f1 = 1.5 * double(t >= -1 & t <= 1);

    f2 = 2 * double(t >= -1 & t <= 1);

    y = conv(f1, f2) * p;

    ty = (min(t)+min(t)):p:(max(t)+max(t));

    % Interpolation to reference grid
    y_interp = interp1(ty, y, ty_ref, 'linear', 0);

    % MSE
    mse = mean((y_interp - y_ref).^2);

    % Max absolute error
    max_err = max(abs(y_interp - y_ref));

    fprintf('p = %.3f\n', p);
    fprintf('MSE = %.6f\n', mse);
    fprintf('Max Error = %.6f\n\n', max_err);

end

%% ====================================
% Supplementary reference comparison for p = 0.05
%% ====================================

p = 0.05;

t = -2:p:2;

f1 = 1.5 * double(t >= -1 & t <= 1);

f2 = 2 * double(t >= -1 & t <= 1);

y = conv(f1, f2) * p;

ty = (min(t)+min(t)):p:(max(t)+max(t));

y_ref_on_p = interp1(ty_ref, y_ref, ty, 'linear', 0);

figure;

subplot(2,1,1);
plot(ty_ref, y_ref, 'k-', 'LineWidth', 1.5);
hold on;
plot(ty, y, 'ro', 'MarkerSize', 3);
grid on;
xlabel('Time t');
ylabel('y(t)');
title('Reference Convolution and Numerical Result for p=0.05');
legend('Reference p=0.001', 'Numerical p=0.05');

subplot(2,1,2);
plot(ty, y - y_ref_on_p, 'LineWidth', 1.5);
grid on;
xlabel('Time t');
ylabel('Error');
title('Pointwise Error for p=0.05');
