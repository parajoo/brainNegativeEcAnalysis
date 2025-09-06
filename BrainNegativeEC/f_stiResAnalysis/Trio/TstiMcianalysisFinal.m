%% plot the network property of simHC simAD and stiAD
%function [idx_mmse_all,p_values,stiAD_mean] = stiAdanalysis_stimulus_results_basalganlia_idxall(name)
%% 1.input results of adding stimulus
clear all
close all
name = 't_stiMciPoCandD0718';
sect = name;
figure_name = name;
load('mci848_data.mat','mci848_simfc','mci848_simpms')
load('hc895_data.mat','hc895_simpms')
load (sprintf('%s.mat',sect),'hc895_simfc','stimulus')
hcfc = hc895_simfc;
adfc = mci848_simfc;
load (sprintf('%s_results.mat',sect));
load ('idx_net6_lobe7.mat','basal_ganglia')
sun_idx = basal_ganglia;
%% plot 8 figures
load ('idx_net6_lobe7.mat')
%mci-Eloc
idxAll.tplEloc = temporal;
idxAll.bgEloc = basal_ganglia;
idxAll.atnEloc = ATN;
idxAll.sunEloc = SUN;
%mci-Ms
idxAll.tplMs = temporal;
idxAll.bgMs = basal_ganglia;
idxAll.haMs = haroad;
idxAll.sunMs =SUN;

% cog-related
% idxAll1.tplEloc = temporal;
% idxAll1.atnEloc = ATN;
% idxAll1.bgEloc = basal_ganglia;
% idxAll1.haMs = haroad;


region_pad = {'tplEloc','bgEloc','atnEloc','sunEloc','tplMs','bgMs','haMs','sunMs'};
region_idx = [1,3,2,7];
%region_idx = [4,5,6,8];
%region_pad = {'tplEloc','atnEloc','bgEloc','haMs'};
%kldAdAll = [results.kld_pms];
thRange = 2:9;
delete(gcp('nocreate'))
        core_use = 15;       % 使用cpu核数?
        c = parpool(core_use);   % 开启并行池
    idxRes = 336;
    for i = 1:length(idxRes)
        stiadfc = results(idxRes(i)).simFC;
        stipms = results(idxRes(i)).pms_ad_sim;
        [~,hcEloc,~,adEloc,~,stiadEloc] = calFcCCandEloc(hcfc,adfc,stiadfc,1);
        [hcArea8,adArea8,stiadArea8,phcad8,phcstiad8] = getAreaElocOrMs(hcEloc,adEloc,stiadEloc,hcfc,adfc,stiadfc,region_pad,idxAll);
        stiResPlot_pad(hcArea8,adArea8,stiadArea8,phcad8,phcstiad8,sprintf('%d',idxRes(i)),'MCI',region_pad,region_idx,'regulation MCI-neCandD');
        %function_plotPms4('PMS',hc895_simpms,mci848_simpms,stipms,'MCI')
    end
%%
    %    function [hcArea,adArea,stiadArea,phcad,phcstiad]=getAreaElocOrMs4(hcEloc,adEloc,stiadEloc,hcfc,adfc,stiadfc,region_pad,idxAll)
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
%     for i=1:2
%         hceloci = mean(mean(hcEloc(idxAll.(region_pad{i}),:,2:9),3),1)';
%         adeloci = mean(mean(adEloc(idxAll.(region_pad{i}),:,2:9),3),1)';
%         stiadeloci = mean(mean(stiadEloc(idxAll.(region_pad{i}),:,2:9),3),1)';
%         hcArea(:,i) = hceloci;
%         adArea(:,i) = adeloci;
%         stiadArea(:,i) = stiadeloci;
%         [~,phcad(i)] = ttest2(hceloci,adeloci,'Vartype','unequal');
%         [~,phcstiad(i)] = ttest2(hceloci,stiadeloci,'Vartype','unequal');
%     end
%     for i=3:4
%         hcmsi = mean(squeeze(mean(hcfcNew(idxAll.(region_pad{i}),:,:),2)),1)';
%        admsi = mean(squeeze(mean(adfcNew(idxAll.(region_pad{i}),:,:),2)),1)';
%         stiadmsi = mean(squeeze(mean(stiadfcNew(idxAll.(region_pad{i}),:,:),2)),1)';
%         hcArea(:,i) = hcmsi;
%         adArea(:,i) = admsi;
%         stiadArea(:,i) = stiadmsi;
%         [~,phcad(i)] = ttest2(hcmsi,admsi,'Vartype','unequal');
%         [~,phcstiad(i)] = ttest2(hcmsi,stiadmsi,'Vartype','unequal');
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
% function function_plotPms4(name, pms_simHC, pms_simAD, pms_stiAD, group_name)
%     % 假设每个输入都是 1×4 的向量
%     sim_hc = pms_simHC;
%     sim_ad_withoutsti = pms_simAD;
%     sim_ad_withsti = pms_stiAD;
% 
%     % 为不同的组指定颜色
%     colors = [hex2rgb('e3f2fd')';    % HC
%               hex2rgb('64b5f6')';    % AD
%               hex2rgb('bbdefb')'];   % rAD
%     alpha = 0.5;
% 
%     figure('Color', [1 1 1]); hold on;
% 
%     nStates = length(sim_hc);  % 应为 4
%     barWidth = 0.25;
%     for i = 1:nStates
%         % HC
%         h1 = bar(i - barWidth, sim_hc(i), barWidth, ...
%                  'FaceColor', colors(1,:), 'FaceAlpha', alpha);
% 
%         % AD
%         h2 = bar(i, sim_ad_withoutsti(i), barWidth, ...
%                  'FaceColor', colors(2,:), 'FaceAlpha', alpha);
% 
%         % rAD
%         h3 = bar(i + barWidth, sim_ad_withsti(i), barWidth, ...
%                  'FaceColor', colors(3,:), 'FaceAlpha', alpha);
%     end
% 
%     ylabel('Probability');
%     title(name);
%     set(gca, 'xtick', 1:nStates, ...
%              'xticklabel', {'s1', 's2', 's3', 's4','s5'});  % 你可以修改标签
%     ax = gca;
%     ax.FontWeight = 'bold';
%     legend([h1, h2, h3], {'HC', group_name, ['r' group_name]});
%     legend boxoff;
%     hold off;
% end