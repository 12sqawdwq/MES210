function save_all_figures(scriptName, outputDir)
%SAVE_ALL_FIGURES Save all currently open MATLAB figures for one script.

if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

figs = findall(0, 'Type', 'figure');
figs = flipud(figs(:));

for i = 1:numel(figs)
    fig = figs(i);
    figName = sprintf('%s_fig%d', scriptName, i);
    pngPath = fullfile(outputDir, [figName '.png']);
    figPath = fullfile(outputDir, [figName '.fig']);

    set(fig, 'Color', 'w');
    try
        exportgraphics(fig, pngPath, 'Resolution', 200);
    catch
        saveas(fig, pngPath);
    end
    savefig(fig, figPath);
end
end
