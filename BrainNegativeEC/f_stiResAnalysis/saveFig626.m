
function saveFig626(savePath,figname)
    if ~exist(savePath, 'dir')
        mkdir(savePath);
    end
    figHandles = findall(0, 'Type', 'figure');
    for i = 1:length(figHandles)
        fig = figHandles(i);
        figName = get(fig, 'FileName');
        if isempty(figName)
            figName = sprintf('%s%d', figname,fig.Number);
        end
        figName = regexprep(figName, '[\/:*?"<>|]', '_');
        filename = fullfile(savePath, [figName, '.fig']);
        saveas(fig, filename);
    end
end