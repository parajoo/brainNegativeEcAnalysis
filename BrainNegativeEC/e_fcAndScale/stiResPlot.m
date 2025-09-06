function stiResPlot(hcAreaE,adAreaE,stiadAreaE,p1,p2,titleName,groupid)
    hc  = hcAreaE;
    ad = adAreaE;
    rad  = stiadAreaE;  % 实为 rMCI
    colors = [hex2rgb('b7e4c7')';
          hex2rgb('b5e2fa')';
          hex2rgb('cccccc')'];
    figure('Color',[1 1 1])
    data = [hc; ad; rad];
    group = [repmat({'HC'},  length(hc), 1);
             repmat({sprintf('%s',groupid)}, length(ad), 1);
             repmat({sprintf('r%s',groupid)},  length(rad), 1)];

    boxplot(data, group, 'Colors', 'k', 'Symbol', '', 'Widths', 0.4);
    hold on;

    % 着色箱线图
    h = findobj(gca, 'Tag', 'Box');
    for j = 1:length(h)
        patch(get(h(j), 'XData'), get(h(j), 'YData'), colors(4-j,:), ...
              'FaceAlpha', 0.8, 'EdgeColor', 'k');
    end

    ymax = max([hc; ad; rad]);
    line([1, 2], [ymax+0.005, ymax+0.005], 'Color', 'k', 'LineWidth', 1.2);
    text(1.5, ymax+0.007, getstarsnew(p1), 'HorizontalAlignment', 'center', ...
        'FontSize', 12, 'FontWeight', 'bold');
     line([1, 3], [ymax+0.01, ymax+0.01], 'Color', 'k', 'LineWidth', 1.2);
    text(2, ymax+0.012, getstarsnew(p2), 'HorizontalAlignment', 'center', ...
        'FontSize', 12, 'FontWeight', 'bold');

    xlim([0.5 3.5]);
    ylim([min([hc; ad; rad])-0.03,ymax+0.03]);
    xticks([1 2 3]);
    xticklabels({'HC', sprintf('%s',groupid), sprintf('r%s',groupid)});
    title(sprintf('%s',titleName));
    hold off;
end