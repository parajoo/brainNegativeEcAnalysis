%% plot the network property of simHC simAD and stiAD
%function [idx_mmse_all,p_values,stiAD_mean] = stiAdanalysis_stimulus_results_basalganlia_idxall(name)
%% 1.input results of adding stimulus
    %clear all
    %close all
    clear all
    close all
    load pStiAdNeElocRes.mat
    name = 'p_adneCandD';
    sect = name;
    figure_name = name;
    load('ad635_data.mat','ad635_simfc','ad635_simpms')
    load (sprintf('%s.mat',sect),'hc874_simfc','stimulus')
    load('hc874_data.mat','hc874_simpms')
    load (sprintf('%s_results.mat',sect));
    hcfc = hc874_simfc;
    adfc = ad635_simfc;
    load ('idx_net6_lobe7.mat')
    %% ad - indicatosa -250826
    % cog-relative
    idxAll.tplEloc = temporal;
    idxAll.ptlEloc = parietal;
    idxAll.occEloc = occipital;
    idxAll.HaEloc = haroad;
    idxAll.haMs = haroad;
    idxAll.ftlMs = frontal;
    idxAll.bgMs = basal_ganglia;
    idxAll.dmnMs = DMN;
    region_pad = {'tplEloc','ptlEloc','occEloc','HaEloc','haMs','ftlMs','bgMs','dmnMs'};
    region_idx = [1,2,3,4,5];
    % cog-unrelative
%     idxAll.ftlEloc = frontal;
%     idxAll.bgEloc = basal_ganglia;
%     idxAll.dmnEloc = DMN;
%     idxAll.visEloc = VIS;
%     idxAll.bgMs = basal_ganglia;
%     idxAll.ftlMs = frontal;
%     idxAll.atnMs = ATN;
%     idxAll.dmnMs = DMN;
%     region_pad = {'ftlEloc','bgEloc','dmnEloc','visEloc','bgMs','ftlMs','atnMs','dmnMs'};
%     region_idx = 1:8;
    kldAdAll = [results.kld_pms];
    p_values = ones(length(kldAdAll),1);
    thRange = 2:9;
    idxRes = 429;
    for i = 1:length(idxRes)
        stiadfc = results(idxRes(i)).simFC;
        stipms = results(idxRes(i)).pms_ad_sim;
        %[~,hcEloc,~,adEloc,~,stiadEloc] = calFcCCandEloc(hc874_simfc,ad635_simfc,stiadfc,1);
        [hcArea8,adArea8,stiadArea8,phcad8,phcstiad8] = getAreaElocOrMs(hcEloc,adEloc,stiadEloc,hcfc,adfc,stiadfc,region_pad,idxAll);
        %stiResPlot_pad(hcArea8,adArea8,stiadArea8,phcad8,phcstiad8,sprintf('%d',idxRes(i)),'AD',region_pad);
        stiResPlot_pad(hcArea8,adArea8,stiadArea8,phcad8,phcstiad8,'','AD',region_pad,region_idx,'regulation AD-neCandD');
        %function_plotPms4('PMS',hc874_simpms,ad635_simpms,stipms,'AD')
    end
    

% function [hcArea,adArea,stiadArea,phcad,phcstiad]=getAreaElocOrMs4(hcEloc,adEloc,stiadEloc,hcfc,adfc,stiadfc,region_pad,idxAll)
%     hcArea = zeros(15,length(region_pad));
%     adArea = zeros(15,length(region_pad));
%     stiadArea = zeros(15,length(region_pad));
%     phcad = zeros(length(region_pad),1);
%     phcstiad = zeros(length(region_pad),1);
%     for jjj = 1:15
%         hcfcNew(:,:,jjj) = hcfc(:,:,jjj) - eye(90,90);
%         adfcNew(:,:,jjj) = adfc(:,:,jjj) - eye(90,90);
%         stiadfcNew(:,:,jjj) = stiadfc(:,:,jjj) - eye(90,90);
%     end
%     for i=1:3
%         hceloci = mean(mean(hcEloc(idxAll.(region_pad{i}),:,2:9),3),1)';
%         adeloci = mean(mean(adEloc(idxAll.(region_pad{i}),:,2:9),3),1)';
%         stiadeloci = mean(mean(stiadEloc(idxAll.(region_pad{i}),:,2:9),3),1)';
%         hcArea(:,i) = hceloci;
%         adArea(:,i) = adeloci;
%         stiadArea(:,i) = stiadeloci;
%         [~,phcad(i)] = ttest2(hceloci,adeloci);
%         [~,phcstiad(i)] = ttest2(hceloci,stiadeloci);
%     end
%     for i=4:4
%         hcmsi = mean(squeeze(mean(hcfcNew(idxAll.(region_pad{i}),:,:),2)),1)';
%        admsi = mean(squeeze(mean(adfcNew(idxAll.(region_pad{i}),:,:),2)),1)';
%         stiadmsi = mean(squeeze(mean(stiadfcNew(idxAll.(region_pad{i}),:,:),2)),1)';
%         hcArea(:,i) = hcmsi;
%         adArea(:,i) = admsi;
%         stiadArea(:,i) = stiadmsi;
%         [~,phcad(i)] = ttest2(hcmsi,admsi);
%         [~,phcstiad(i)] = ttest2(hcmsi,stiadmsi);
%     end
% end
% function stiResPlot_pad4(hcAreaE,adAreaE,stiadAreaE,p1s,p2s,titleName,groupid,subtitlesN)
% hc  = hcAreaE;      % 15×8
% ad  = adAreaE;      % 15×8
% rad = stiadAreaE;   % 15×8 （实为 rMCI）
% 
% colors = [hex2rgb('b7e4c7')';
%     hex2rgb('b5e2fa')';
%     hex2rgb('cccccc')'];
% 
% figure('Color',[1 1 1]);
% 
% for i = 1:4
%     subplot(2,2,i)
% 
%     data = [hc(:,i); ad(:,i); rad(:,i)];
%     group = [repmat({'HC'},  size(hc,1), 1);
%         repmat({sprintf('%s', groupid)}, size(ad,1), 1);
%         repmat({sprintf('r%s', groupid)}, size(rad,1), 1)];
% 
%     boxplot(data, group, 'Colors', 'k', 'Symbol', '', 'Widths', 0.4);
%     hold on;
%     h = findobj(gca, 'Tag', 'Box');
%     for j = 1:length(h)
%         patch(get(h(j), 'XData'), get(h(j), 'YData'), colors(4-j,:), ...
%             'FaceAlpha', 0.8, 'EdgeColor', 'k');
%     end
%     if i<4
%         ymax = max(data);
%         line([1, 2], [ymax+0.01, ymax+0.01], 'Color', 'k', 'LineWidth', 1.2);
%         text(1.5, ymax+0.012, getstarsnew(p1s(i)), 'HorizontalAlignment', 'center', ...
%             'FontSize', 10, 'FontWeight', 'bold');
%         line([1, 3], [ymax+0.02, ymax+0.02], 'Color', 'k', 'LineWidth', 1.2);
%         text(2, ymax+0.022, getstarsnew(p2s(i)), 'HorizontalAlignment', 'center', ...
%             'FontSize', 10, 'FontWeight', 'bold');
% 
%         xlim([0.5 3.5]);
%         ylim([min(data)-0.03, ymax+0.03]);
%         xticks([1 2 3]);
%         xticklabels({'HC', sprintf('%s', groupid), sprintf('r%s', groupid)});
%         title(sprintf('%s - %s', titleName, subtitlesN{i}), 'FontWeight', 'bold', 'FontSize', 8);
%         hold off;
%     else
%         ymax = max(data);
%         line([1, 2], [ymax+0.0025, ymax+0.0025], 'Color', 'k', 'LineWidth', 1.2);
%         text(1.5, ymax+0.004, getstarsnew(p1s(i)), 'HorizontalAlignment', 'center', ...
%             'FontSize', 10, 'FontWeight', 'bold');
%         line([1, 3], [ymax+0.005, ymax+0.005], 'Color', 'k', 'LineWidth', 1.2);
%         text(2, ymax+0.0065, getstarsnew(p2s(i)), 'HorizontalAlignment', 'center', ...
%             'FontSize', 10, 'FontWeight', 'bold');
% 
%         xlim([0.5 3.5]);
%         ylim([min(data)-0.006, ymax+0.006]);
%         xticks([1 2 3]);
%         xticklabels({'HC', sprintf('%s', groupid), sprintf('r%s', groupid)});
%         title(sprintf('%s - %s', titleName, subtitlesN{i}), 'FontWeight', 'bold', 'FontSize', 8);
%         hold off;
% 
%     end
% 
% end
% end
% function function_plotPms4(name,pms_simHC,pms_simAD,pms_stiAD,group_name)
% %% ad:362  mci:439
% sim_hc = pms_simHC;
%     sim_ad_withoutsti = pms_simAD;
%     sim_ad_withsti = pms_stiAD;
% 
%     % 为不同的亚状态指定颜色
%     colors = [hex2rgb('e3f2fd')';
%         hex2rgb('64b5f6')'
%         hex2rgb('bbdefb')';
%         ];
% % colors = [hex2rgb('b7e4c7')';  
% %           hex2rgb('cccccc')';
% %           hex2rgb('b5e2fa')'; ];  
%     alpha = 0.5;
%     % 创建一个柱状图
%     figure('Color',[1 1 1]);
%     hold on;
% 
%     % 绘制经验的柱状图
%     for i = 1:length(sim_hc)
%         h1 = bar(i-0.3, sim_hc(i), 'BarWidth', 0.3);
%         set(h1, 'FaceColor', colors(1, :), 'FaceAlpha', alpha);
%     end
% 
%     % 绘制模拟的柱状图
%     for i = 1:length(sim_ad_withoutsti)
%         h2 = bar(i, sim_ad_withoutsti(i), 'BarWidth', 0.3);
%         set(h2, 'FaceColor', colors(2, :), 'FaceAlpha', alpha);
%     end
% 
%     for i = 1:length(sim_ad_withsti)
%         h3 = bar(i+0.3, sim_ad_withsti(i), 'BarWidth', 0.3);
%         set(h3, 'FaceColor', colors(3, :), 'FaceAlpha', alpha);
%     end
%     % 添加图例和其他图形属性
%     %xlabel('states');
%     ylabel('probability');
%     title(name);
%     set(gca, 'xtick', 1:3, 'xticklabel', {'sTP', 'sFL', 'sOcc'});
%     ax = gca;
%     ax.FontWeight = 'bold';
%     legend([h1,h2,h3],{'HC',sprintf('%s',group_name),sprintf('r%s',group_name)})
%     legend boxoff
%     hold off;
% end   