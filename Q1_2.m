clc;
clear;
close all;

%% Time vector
t = -3:0.001:3;

%% Original signal f(t)

f = (t+1).*(t>=-1 & t<=0) + ...
    (1-t).*(t>0 & t<=1);

%% ==============================
% Figure with subplots
%% ==============================

figure;

%% (1) Original signal
subplot(3,2,1);

plot(t, f, 'LineWidth',1.5);

grid on;

xlabel('t');
ylabel('f(t)');

title('Original Signal f(t)');

axis([-3 3 -0.5 1.5]);

%% (2) f(t-2)
t_shift = t - 2;

f_shift = (t_shift+1).*(t_shift>=-1 & t_shift<=0) + ...
          (1-t_shift).*(t_shift>0 & t_shift<=1);

subplot(3,2,2);

plot(t, f_shift, 'LineWidth',1.5);

grid on;

xlabel('t');
ylabel('f(t-2)');

title('Shifted Signal f(t-2)');

axis([-3 3 -0.5 1.5]);

%% (3) f(3t)
t_compress = 3*t;

f_compress = (t_compress+1).*(t_compress>=-1 & t_compress<=0) + ...
             (1-t_compress).*(t_compress>0 & t_compress<=1);

subplot(3,2,3);

plot(t, f_compress, 'LineWidth',1.5);

grid on;

xlabel('t');
ylabel('f(3t)');

title('Compressed Signal f(3t)');

axis([-3 3 -0.5 1.5]);

%% (4) f(-t)
t_reverse = -t;

f_reverse = (t_reverse+1).*(t_reverse>=-1 & t_reverse<=0) + ...
            (1-t_reverse).*(t_reverse>0 & t_reverse<=1);

subplot(3,2,4);

plot(t, f_reverse, 'LineWidth',1.5);

grid on;

xlabel('t');
ylabel('f(-t)');

title('Reversed Signal f(-t)');

axis([-3 3 -0.5 1.5]);

%% (5) f(-3t-2)
t_mix = -3*t - 2;

f_mix = (t_mix+1).*(t_mix>=-1 & t_mix<=0) + ...
        (1-t_mix).*(t_mix>0 & t_mix<=1);

subplot(3,2,5);

plot(t, f_mix, 'LineWidth',1.5);

grid on;

xlabel('t');
ylabel('f(-3t-2)');

title('Composite Signal f(-3t-2)');

axis([-3 3 -0.5 1.5]);