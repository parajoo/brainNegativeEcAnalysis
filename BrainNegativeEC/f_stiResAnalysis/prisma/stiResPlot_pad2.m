function stiResPlot_pad2(hcAreaE,adAreaE,stiadAreaE,p1s,p2s,titleName,groupid,subtitlesN,region_idx,sgtitleName)
hc  = hcAreaE(:,region_idx);      % 15×8
ad  = adAreaE(:,region_idx);      % 15×8
rad = stiadAreaE(:,region_idx);   % 15×8 （实为 rMCI）

colors = [hex2rgb('b7e4c7')';
    hex2rgb('b5e2fa')';
    hex2rgb('cccccc')'];

figure('Color',[1 1 1]);

for i = 1:length(region_idx)
    subplot(1,length(region_idx),i)

    data = [hc(:,i); ad(:,i); rad(:,i)];
    group = [repmat({'HC'},  size(hc,1), 1);
        repmat({sprintf('%s', groupid)}, size(ad,1), 1);
        repmat({sprintf('r%s', groupid)}, size(rad,1), 1)];

    boxplot(data, group, 'Colors', 'k', 'Symbol', '', 'Widths', 0.4);
    hold on;
    h = findobj(gca, 'Tag', 'Box');
    for j = 1:length(h)
        patch(get(h(j), 'XData'), get(h(j), 'YData'), colors(4-j,:), ...
            'FaceAlpha', 0.8, 'EdgeColor', 'k');
    end
    if i<=2
        ymax = max(data);
        line([1, 2], [ymax+0.01, ymax+0.01], 'Color', 'k', 'LineWidth', 1.2);
        text(1.5, ymax+0.012, getstarsnew(p1s(region_idx(i))), 'HorizontalAlignment', 'center', ...
            'FontSize', 10, 'FontWeight', 'bold');
        line([1, 3], [ymax+0.02, ymax+0.02], 'Color', 'k', 'LineWidth', 1.2);
        text(2, ymax+0.022, getstarsnew(p2s(region_idx(i))), 'HorizontalAlignment', 'center', ...
            'FontSize', 10, 'FontWeight', 'bold');

        xlim([0.5 3.5]);
        ylim([min(data)-0.03, ymax+0.03]);
        xticks([1 2 3]);
        xticklabels({'HC', sprintf('%s', groupid), sprintf('r%s', groupid)});
        title(sprintf('%s%s', titleName, subtitlesN{region_idx(i)}), 'FontWeight', 'bold', 'FontSize', 8);
        hold off;
    else
        ymax = max(data);
        line([1, 2], [ymax+0.0025, ymax+0.0025], 'Color', 'k', 'LineWidth', 1.2);
        text(1.5, ymax+0.004, getstarsnew(p1s(region_idx(i))), 'HorizontalAlignment', 'center', ...
            'FontSize', 10, 'FontWeight', 'bold');
        line([1, 3], [ymax+0.005, ymax+0.005], 'Color', 'k', 'LineWidth', 1.2);
        text(2, ymax+0.0065, getstarsnew(p2s(region_idx(i))), 'HorizontalAlignment', 'center', ...
            'FontSize', 10, 'FontWeight', 'bold');

        xlim([0.5 3.5]);
        ylim([min(data)-0.006, ymax+0.006]);
        xticks([1 2 3]);
        xticklabels({'HC', sprintf('%s', groupid), sprintf('r%s', groupid)});
        title(sprintf('%s - %s', titleName, subtitlesN{region_idx(i)}), 'FontWeight', 'bold', 'FontSize', 8);
        hold off;

    end

end
sgtitle(sgtitleName);