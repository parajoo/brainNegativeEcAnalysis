function plotMs(hcfc,adfc,stiadfc,titleName,groupid,idxAll,region_pad,sgtitleName)
colors = [hex2rgb('b7e4c7')';
    hex2rgb('b5e2fa')';
    hex2rgb('cccccc')'];
for jjj = 1:15
        hcfcNew(:,:,jjj) = hcfc(:,:,jjj) - eye(90,90);
        adfcNew(:,:,jjj) = adfc(:,:,jjj) - eye(90,90);
        stiadfcNew(:,:,jjj) = stiadfc(:,:,jjj) - eye(90,90);
end
hcArea8 = zeros(15,length(region_pad));
    adArea8 = zeros(15,length(region_pad));
    stiadArea8 = zeros(15,length(region_pad));
    phcad8 = zeros(length(region_pad),1);
    phcstiad8 = zeros(length(region_pad),1);
for i=1:length(region_pad)
        hcmsi = mean(squeeze(mean(hcfcNew(idxAll.(region_pad{i}),:,:),2)),1)';
        admsi = mean(squeeze(mean(adfcNew(idxAll.(region_pad{i}),:,:),2)),1)';
        stiadmsi = mean(squeeze(mean(stiadfcNew(idxAll.(region_pad{i}),:,:),2)),1)';
        hcArea8(:,i) = hcmsi;
        adArea8(:,i) = admsi;
        stiadArea8(:,i) = stiadmsi;
        [~,phcad8(i)] = ttest2(hcmsi,admsi);
        [~,phcstiad8(i)] = ttest2(hcmsi,stiadmsi);
end
hc=hcArea8;
ad=adArea8;
rad=stiadArea8;
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
            line([1, 2], [ymax+0.0025, ymax+0.0025], 'Color', 'k', 'LineWidth', 1.2);
            text(1.5, ymax+0.004, getstarsnew(phcad8(i)), 'HorizontalAlignment', 'center', ...
                'FontSize', 10, 'FontWeight', 'bold');
            line([1, 3], [ymax+0.005, ymax+0.005], 'Color', 'k', 'LineWidth', 1.2);
            text(2, ymax+0.0065, getstarsnew(phcstiad8(i)), 'HorizontalAlignment', 'center', ...
                'FontSize', 10, 'FontWeight', 'bold');
    
            xlim([0.5 3.5]);
            ylim([min(data)-0.006, ymax+0.006]);
            xticks([1 2 3]);
            xticklabels({'HC', sprintf('%s', groupid), sprintf('r%s', groupid)});
            title(sprintf('%s%s', titleName, region_pad{i}), 'FontWeight', 'bold', 'FontSize', 8);
            hold off;
    end
        sgtitle(sgtitleName);
end