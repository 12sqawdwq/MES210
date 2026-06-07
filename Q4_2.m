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
% Plot pole-zero map
%% ====================================

figure;

if exist('tf', 'file') == 2 && exist('pzmap', 'file') == 2
    sys = tf(num, den);
    pzmap(sys);
    hold on;
else
    plot(real(z), imag(z), 'ob', ...
        'MarkerSize',10,'LineWidth',2);
    hold on;
    plot(real(p), imag(p), 'xr', ...
        'MarkerSize',10,'LineWidth',2);
end

grid on;

xlabel('Real Axis');
ylabel('Imaginary Axis');

title('Pole-Zero Map');

legend('Zeros','Poles');

%% ====================================
% Display values
%% ====================================

disp('Zeros:');
disp(z);

disp('Poles:');
disp(p);

if all(real(p) < 0)
    disp('Stability: stable because all poles lie in the left half-plane.');
else
    disp('Stability: unstable because at least one pole is not in the left half-plane.');
end
