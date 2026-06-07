clc;
clear;
close all;

setenv('MES210_SKIP_SOUND', '1');

if ~exist(fullfile(pwd, 'figures'), 'dir')
    mkdir(fullfile(pwd, 'figures'));
end

if exist(fullfile(pwd, 'figures', 'matlab_run_log.txt'), 'file')
    delete(fullfile(pwd, 'figures', 'matlab_run_log.txt'));
end

diary(fullfile(pwd, 'figures', 'matlab_run_log.txt'));
fprintf('MES210 batch verification started at %s\n\n', datestr(now));

fprintf('Running Q1_1.m ...\n');
Q1_1; save_all_figures('Q1_1', fullfile(pwd, 'figures')); fprintf('Finished Q1_1.m\n\n');

fprintf('Running Q1_2.m ...\n');
Q1_2; save_all_figures('Q1_2', fullfile(pwd, 'figures')); fprintf('Finished Q1_2.m\n\n');

fprintf('Running Q1_3.m ...\n');
Q1_3; save_all_figures('Q1_3', fullfile(pwd, 'figures')); fprintf('Finished Q1_3.m\n\n');

fprintf('Running Q1_4.m ...\n');
Q1_4; save_all_figures('Q1_4', fullfile(pwd, 'figures')); fprintf('Finished Q1_4.m\n\n');

fprintf('Running Q2_1.m ...\n');
Q2_1; save_all_figures('Q2_1', fullfile(pwd, 'figures')); fprintf('Finished Q2_1.m\n\n');

fprintf('Running Q2_2.m ...\n');
Q2_2; save_all_figures('Q2_2', fullfile(pwd, 'figures')); fprintf('Finished Q2_2.m\n\n');

fprintf('Running Q3_1.m ...\n');
Q3_1; save_all_figures('Q3_1', fullfile(pwd, 'figures')); fprintf('Finished Q3_1.m\n\n');

fprintf('Running Q3_2.m ...\n');
Q3_2; save_all_figures('Q3_2', fullfile(pwd, 'figures')); fprintf('Finished Q3_2.m\n\n');

fprintf('Running Q4_1.m ...\n');
Q4_1; save_all_figures('Q4_1', fullfile(pwd, 'figures')); fprintf('Finished Q4_1.m\n\n');

fprintf('Running Q4_2.m ...\n');
Q4_2; save_all_figures('Q4_2', fullfile(pwd, 'figures')); fprintf('Finished Q4_2.m\n\n');

fprintf('MES210 batch verification finished at %s\n', datestr(now));
diary off;
close all;
