%% plot the network property of simHC simAD and stiAD
%function [idx_mmse_all,p_values,stiAD_mean] = stiAdanalysis_stimulus_results_basalganlia_idxall(name)
    clear all
    %close all
    name = 't_stiAdNeCandD0718';
    sect = name;
    figure_name = name;
    load('ad943_data.mat','ad943_simfc','ad943_simpms')
    load('hc895_data.mat','hc895_simpms')
    load (sprintf('%s.mat',sect),'hc895_simfc','stimulus')
    load (sprintf('%s_results.mat',sect));
    hcfc = hc895_simfc;
    adfc = ad943_simfc;
    %% T-AD:tplEloc,ptlEloc,bgEloc,HaMs
    load ('idx_net6_lobe7.mat')
    %ad-Eloc -- frontal,temporal,parietal,haroad
    idxAll.ptlEloc = parietal;
    idxAll.bgEloc = basal_ganglia;
    idxAll.aunEloc = AUN;
    idxAll.smnEloc = SMN;
    %ad-Ms -- Frontal,basalG,Haroad,Atn
    idxAll.ftlMs = frontal;
    idxAll.ptlMs = parietal;
    idxAll.tplMs = temporal;
    idxAll.haMs = haroad;
    region_pad = {'ptlEloc','bgEloc','aunEloc','smnEloc','ftlMs','ptlMs','tplMs','haMs'};
    region_idx = [1,2,8];
    %region_idx = [3,4,5,6,7];
    %subtitlesN = {'Frontal','temporal','parietal','Haroad','Frontal','BasalG','Haroad','ATN'};
    kldAdAll = [results.kld_pms];
    p_values = ones(length(kldAdAll),1);
    thRange = 2:9;
    delete(gcp('nocreate'))
    core_use = 15;       % 使用cpu核数?
    c = parpool(core_use);   % 开启并行池
    idxRes = 399;
    for i = 1:length(idxRes)
        stiadfc = results(idxRes(i)).simFC;
        stipms = results(idxRes(i)).pms_ad_sim;
        [~,hcEloc,~,adEloc,~,stiadEloc] = calFcCCandEloc(hcfc,adfc,stiadfc,1);
        [hcArea8,adArea8,stiadArea8,phcad8,phcstiad8] = getAreaElocOrMs(hcEloc,adEloc,stiadEloc,hcfc,adfc,stiadfc,region_pad,idxAll);
        stiResPlot_pad2(hcArea8,adArea8,stiadArea8,phcad8,phcstiad8,sprintf('%d',idxRes(i)),'MCI',region_pad,region_idx,'regulation AD-neCandD');
%         stiResPlot_pad(hcArea8,adArea8,stiadArea8,phcad8,phcstiad8,'','AD',region_pad);
%         function_plotPms4('PMS',hc895_simpms,ad943_simpms,stipms,'AD')
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

