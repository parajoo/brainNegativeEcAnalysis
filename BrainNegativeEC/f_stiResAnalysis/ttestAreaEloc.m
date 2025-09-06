function ttestAreaEloc(hcEloc,adEloc,stiadEloc,region_pad,idxAll,groupid,titleName,sgtitleName)
    hcArea8 = zeros(15,length(region_pad));
    adArea8 = zeros(15,length(region_pad));
    stiadArea8 = zeros(15,length(region_pad));
    phcad8 = zeros(length(region_pad),1);
    phcstiad8 = zeros(length(region_pad),1);
    for i=1:length(region_pad)
        hceloci = mean(mean(hcEloc(idxAll.(region_pad{i}),:,2:9),3),1)';
        adeloci = mean(mean(adEloc(idxAll.(region_pad{i}),:,2:9),3),1)';
        stiadeloci = mean(mean(stiadEloc(idxAll.(region_pad{i}),:,2:9),3),1)';
        hcArea8(:,i) = hceloci;
        adArea8(:,i) = adeloci;
        stiadArea8(:,i) = stiadeloci;
        [~,phcad8(i)] = ttest2(hceloci,adeloci);
        [~,phcstiad8(i)] = ttest2(hceloci,stiadeloci);
    end
    %% plot
hc  = hcArea8;
ad  = adArea8;      % 15×8
rad = stiadArea8;   % 15×8 （实为 rMCI）

colors = [hex2rgb('b7e4c7')';
    hex2rgb('b5e2fa')';
    hex2rgb('cccccc')'];

figure('Color',[1 1 1]);

for i = 1:length(region_pad)
    subplot(1,length(region_pad),i)

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
        ymax = max(data);
        line([1, 2], [ymax+0.01, ymax+0.01], 'Color', 'k', 'LineWidth', 1.2);
        text(1.5, ymax+0.012, getstarsnew(phcad8(i)), 'HorizontalAlignment', 'center', ...
            'FontSize', 10, 'FontWeight', 'bold');
        line([1, 3], [ymax+0.02, ymax+0.02], 'Color', 'k', 'LineWidth', 1.2);
        text(2, ymax+0.022, getstarsnew(phcstiad8(i)), 'HorizontalAlignment', 'center', ...
            'FontSize', 10, 'FontWeight', 'bold');

        xlim([0.5 3.5]);
        ylim([min(data)-0.03, ymax+0.03]);
        xticks([1 2 3]);
        xticklabels({'HC', sprintf('%s', groupid), sprintf('r%s', groupid)});
        title(sprintf('%s%s', titleName, region_pad{i}), 'FontWeight', 'bold', 'FontSize', 8);
        hold off;

end
    sgtitle(sgtitleName);
end