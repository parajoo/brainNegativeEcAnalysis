% clear all
% %close all
% load tGroup3Fc_scale0905.mat
% clear tAdFc tMciFc tHcFc
% sub_hc = 25;sub_mci = 45;sub_ad = 52;
% hc_mmse_new = zeros(sub_hc,6);
% for i = 1:sub_hc
%     hc_mmse_new(i,1:5) = hc_mmse(i,1:5);
%     hc_mmse_new(i,6) = sum(hc_mmse(i,6:11));
% end
% mci_mmse_new = zeros(sub_mci,6);
% for i = 1:sub_mci
%     mci_mmse_new(i,1:5) = mci_mmse(i,1:5);
%     mci_mmse_new(i,6) = sum(mci_mmse(i,6:11));
% end
% ad_mmse_new = zeros(sub_ad,6);
% for i = 1:sub_mci
%     ad_mmse_new(i,1:5) = ad_mmse(i,1:5);
%     ad_mmse_new(i,6) = sum(ad_mmse(i,6:11));
% end
% HC = hc_mmse_new;
% MCI = mci_mmse_new;
% AD = ad_mmse_new;
% mean_HC = mean(HC, 1);
% sem_HC = std(HC, 0, 1) ./ sqrt(size(HC, 1));
% 
% mean_MCI = mean(MCI, 1);
% sem_MCI = std(MCI, 0, 1) ./ sqrt(size(MCI, 1));
% 
% mean_AD = mean(AD, 1);
% sem_AD = std(AD, 0, 1) ./ sqrt(size(AD, 1));
% 
% num_subscores = 6;
% p_values = zeros(num_subscores, 3); % 存储每个量表的三组比较结果 [HC-MCI, HC-AD, MCI-AD]
% for i = 1:num_subscores
%     [~, p_values(i,1)] = ttest2(HC(:,i), MCI(:,i));
%     [~, p_values(i,2)] = ttest2(HC(:,i), AD(:,i));
%     [~, p_values(i,3)] = ttest2(MCI(:,i), AD(:,i));
% end
% 
% % 设置颜色
% % colors = [hex2rgb('8ecae6')';    % HC蓝色
% %           hex2rgb('ffc8dd')';    % MCI绿色
% %           hex2rgb('99d98c')'];   % AD红色
% colors = [hex2rgb('b7e4c7')';
%           hex2rgb('b5e2fa')'; 
%           hex2rgb('cccccc')'];
% name_subplot = {'MMSE','Orientation','Registration','Attention and Calculation','Recall','Language and Praxis'};
% %name_subplot = {'MoCA','Visualspacial and excution','naming','attention','language','abstract','delay recall','orientation'};
% figure('Color',[1 1 1]);
% for i = 1:num_subscores
%     subplot(2, 3, i);
%     
%     % 绘制柱状图
%     means = [mean_HC(i), mean_MCI(i), mean_AD(i)];
%     sems = [sem_HC(i), sem_MCI(i), sem_AD(i)];
%     b = bar(1:3, means, 'FaceColor', 'flat');
%     b.CData = colors; % 设置柱子颜色
%     b.FaceAlpha = 0.6;
%     hold on;
%     
%     % 添加误差线
%     errorbar(1:3, means, sems, 'k.', 'LineWidth', 1, 'CapSize', 15);
%     
%     % 设置坐标轴
%     set(gca, 'XTick', 1:3, 'XTickLabel', {'HC', 'MCI', 'AD'});
%     title(name_subplot(i));
%     ylabel('Score');
%     ylim([0, max(means + sems)*1.4]);
%     
%     % 添加显著性标记
%     y_pos = max(means + sems);
%     line_height = 0.1 * y_pos;
%     
%     % HC vs MCI
%     if p_values(i,1) < 0.05
%         plot([1, 2], [1, 1]*y_pos + line_height, 'k', 'LineWidth', 1);
%         text(1.5, y_pos + line_height*1.1, getStars(p_values(i,1)), ...
%             'HorizontalAlignment', 'center', 'FontSize', 12);
%     end
%     
%     % HC vs AD
%     if p_values(i,2) < 0.05
%         plot([1, 3], [1, 1]*y_pos + 2*line_height, 'k', 'LineWidth', 1);
%         text(2, y_pos + 2*line_height*1.1, getStars(p_values(i,2)), ...
%             'HorizontalAlignment', 'center', 'FontSize', 12);
%     end
%     
%     % MCI vs AD
%     if p_values(i,3) < 0.05
%         plot([2, 3], [1, 1]*y_pos + 3*line_height, 'k', 'LineWidth', 1);
%         text(2.5, y_pos + 3*line_height*1.1, getStars(p_values(i,3)), ...
%             'HorizontalAlignment', 'center', 'FontSize', 12);
%     end
%     box off
%     ax = gca;
%     ax.FontWeight = 'bold';
% end
% 
% % 添加总标题
% sgtitle('MoCA');
% % 
% % % 辅助函数：根据p值返回星号标记
% % function stars = getStars(p)
% %     if p < 0.001
% %         stars = '***';
% %     elseif p < 0.01
% %         stars = '**';
% %     elseif p < 0.05
% %         stars = '*';
% %     else
% %         stars = '';
% %     end
% % end

%% plot 3groups 
% clear all
% close all
%load net_simdata_subnetE.mat
%load net_simdata_meanss.mat
%load empsc_meanss_lobe.mat
clear all
%close all
load trio0718_EandCC_subarea.mat
num_lobe = 6;
HC = zeros(15,num_lobe);
MCI = zeros(15,num_lobe);
AD = zeros(15,num_lobe);
simhc_meanss = hcNetE;
simmci_meanss = mciNetE;
simad_meanss = adNetE;
if num_lobe == 6
    areaS = 'subnet';
else
    areaS = 'lobe';
end
for i=1:num_lobe
    hc_lobei = simhc_meanss.(sprintf('%s%d',areaS,i)).mean;
    HC(:,i) = hc_lobei;
    mci_lobei = simmci_meanss.(sprintf('%s%d',areaS,i)).mean;
    MCI(:,i) = mci_lobei;
    ad_lobei = simad_meanss.(sprintf('%s%d',areaS,i)).mean;
    AD(:,i) = ad_lobei;
end
mean_HC = mean(HC, 1);
sem_HC = std(HC, 0, 1) ./ sqrt(size(HC, 1));

mean_MCI = mean(MCI, 1);
sem_MCI = std(MCI, 0, 1) ./ sqrt(size(MCI, 1));

mean_AD = mean(AD, 1);
sem_AD = std(AD, 0, 1) ./ sqrt(size(AD, 1));

num_subscores = num_lobe;
p_values = zeros(num_subscores, 3); % 存储每个量表的三组比较结果 [HC-MCI, HC-AD, MCI-AD]
for i = 1:num_subscores
    [~, p_values(i,1)] = ttest2(HC(:,i), MCI(:,i));
    [~, p_values(i,2)] = ttest2(HC(:,i), AD(:,i));
    [~, p_values(i,3)] = ttest2(MCI(:,i), AD(:,i));
end

% 设置颜色
colors = [hex2rgb('b7e4c7')';
          hex2rgb('b5e2fa')'; 
          hex2rgb('cccccc')'];

%name_subplot = {'MMSE','Orientation','Registration','Attention and Calculation','Recall','Language and Praxis'};
%name_subplot = {'MoCA','Visualspacial and excution','naming','attention','language','abstract','delay recall','orientation'};
if num_lobe == 6
    name_subplot = {'DMN','SUN','SMN','VIS','ATN','AUN'};
else
    name_subplot = {'Frontal','Temporal','Occipital','parietal','BasalGanglia','HAroad','Limbic'};
end
%name_subplot = {'DMN','SUN','SMN','VIS','ATN','AUN'};
figure('Color',[1 1 1]);
sgtitle('Local efficienct Differences across Three Groups')
for i = 1:num_subscores
    if num_lobe ==6
        subplot(2,3,i);
    else
    subplot(3, 3, i);
    end
    % 绘制柱状图
    means = [mean_HC(i), mean_MCI(i), mean_AD(i)];
    sems = [sem_HC(i), sem_MCI(i), sem_AD(i)];
%     if i==3||i==4
%         means = abs(means);
%         sems = abs(sems);
%     end
    b = bar(1:3, means, 'FaceColor', 'flat','FaceAlpha',0.6);
    b.CData = colors; % 设置柱子颜色
    hold on;
    box off;
    % 添加误差线
    errorbar(1:3, means, sems, 'k.', 'LineWidth', 1, 'CapSize', 15);
    
    % 设置坐标轴
    set(gca, 'XTick', 1:3, 'XTickLabel', {'HC', 'MCI', 'AD'});
    title(name_subplot(i));
    ylabel('value');
    add_value = 1;
   %ylim([0,max(means + sems)*add_value]);
   ylim([min(means)*add_value,max(means)*add_value]);
    % 添加显著性标记
    y_pos = max(means + sems);
    line_height = y_pos;
    
    % HC vs MCI
    if p_values(i,1) < 0.05
        plot([1, 2], [1, 1]*y_pos +0.007+ 0*line_height, 'k', 'LineWidth', 1);
        text(1.5, y_pos + 0.008+0.1*line_height*0, getStars(p_values(i,1)), ...
            'HorizontalAlignment', 'center', 'FontSize', 12);
    end
    
    % HC vs AD
    if p_values(i,2) < 0.05
        plot([1, 3], [1, 1]*y_pos +0.005+ 0*line_height, 'k', 'LineWidth', 1);
        text(2, y_pos +0.006+ 0.2*line_height*0, getStars(p_values(i,2)), ...
            'HorizontalAlignment', 'center', 'FontSize', 12);
    end
    
    % MCI vs AD
    if p_values(i,3) < 0.05
        plot([2, 3], [1, 1]*y_pos+0.003 + 0*line_height, 'k', 'LineWidth', 1);
        text(2.5, y_pos+0.004 + 0.3*line_height*0, getStars(p_values(i,3)), ...
            'HorizontalAlignment', 'center', 'FontSize', 12);
    end
    
    ax = gca;
    ax.FontWeight = 'bold';
end



% clear all
% close all
% %load p_cluster3_moca0105_singlesub.mat
% 
% %% plot PMS and TPM
% % load hc979_pmsAndTpm.mat
% % pmsSubnHc = tpmSubnSim;
% % clear tpmSubnSim
% % load mcistiCandD_pmsAndTpm.mat
% % pmsSubnMci = tpmSubnSim;
% % clear tpmSubnSim
% % load adstiCandD_pmsAndTpm.mat
% % pmsSubnAd = tpmSubnSim;
% % clear tpmSubnSim
% % num_lobe = 3;
% % n_sub = 15;
% % HC = zeros(n_sub,num_lobe);
% % MCI = zeros(n_sub,num_lobe);
% % AD = zeros(n_sub,num_lobe);
% % n = 1;
% % for i=1:num_lobe
% %     for j = 1:num_lobe
% %         HC(:,n) = squeeze(pmsSubnHc(i,j,:))';
% %         MCI(:,n) = squeeze(pmsSubnMci(i,j,:))';
% %         AD(:,n) = squeeze(pmsSubnAd(i,j,:))';
% %         n = n+1;
% %     end
% % end
% %% plot precunues
% 
% %% color1
% % colors = [hex2rgb('8ecae6')';   
% %           hex2rgb('ffc8dd')';   
% %           hex2rgb('99d98c')'];  
% %% color2
% colors = [hex2rgb('d8f3dc')';
%     hex2rgb('95d5b2')';
%     hex2rgb('52b788')'];
% %name_subplot = {'s1','s2','s3','s4','s5','s6','s7','s8','s9'};
% %name_subplot = {'DMN','ATN','SMN','SUN','AUN','VIS'};
% name_subplot = {'frontal','parietal','temporal','occipital','basalG','Haroad','Limbic'};
% figure('Color',[1 1 1]);
% 
% for i = 1:num_subscores
%     subplot(3, 3, i);
%     % 绘制柱状图
%     means = [mean_HC(i), mean_MCI(i), mean_AD(i)];
%     sems = [sem_HC(i), sem_MCI(i), sem_AD(i)];
% %     if i==3||i==4
% %         means = abs(means);
% %         sems = abs(sems);
% %     end
%     b = bar(1:3, means, 'FaceColor', 'flat');
%     b.CData = colors; % 设置柱子颜色
%     hold on;
%     
%     % 添加误差线
%     %errorbar(1:3, means, sems, 'k.', 'LineWidth', 1, 'CapSize', 15);
%     
%     % 设置坐标轴
%     set(gca, 'XTick', 1:3, 'XTickLabel', {'HC', 'MCI', 'AD'});
%     title(name_subplot(i));
%     ylabel('value');
%     add_value = 1.1;%1.4
% %     if max(means + sems)>0
% %       ylim([0.2, max(means + sems)*add_value]);
% %     else
% %        ylim([max(means + sems)*add_value,0]); 
% %     end
% %     if i == 1 || i ==5 || i==9
% %        ylim([0.5,max(means + sems)*add_value*add_value]);
% %     else
% %        ylim([0,max(means + sems)*add_value*add_value]);
% %     end
%    
%    % ylim([min(means)*add_value,max(means)*add_value]);
%     % 添加显著性标记
%     y_pos = max(means + sems);
%     line_height = 0.025 * y_pos;
%     
%     % HC vs MCI
%     if p_values(i,1) < 0.05
%         plot([1, 2], [1, 1]*y_pos + line_height, 'k', 'LineWidth', 1);
%         text(1.5, y_pos + line_height*1.1, getStars(p_values(i,1)), ...
%             'HorizontalAlignment', 'center', 'FontSize', 12);
%     end
%     
%     % HC vs AD
%     if p_values(i,2) < 0.05
%         plot([1, 3], [1, 1]*y_pos + 2*line_height, 'k', 'LineWidth', 1);
%         text(2, y_pos + 2*line_height*1.1, getStars(p_values(i,2)), ...
%             'HorizontalAlignment', 'center', 'FontSize', 12);
%     end
%     
%     % MCI vs AD
%     if p_values(i,3) < 0.05
%         plot([2, 3], [1, 1]*y_pos + 3*line_height, 'k', 'LineWidth', 1);
%         text(2.5, y_pos + 3*line_height*1.1, getStars(p_values(i,3)), ...
%             'HorizontalAlignment', 'center', 'FontSize', 12);
%     end
%     ax = gca;
%     ax.FontWeight = 'bold';
% end
% 
% % 添加总标题
% if kk==1
% sgtitle('Precuneus(FC)');
% else
%    sgtitle('Precuneus(FC)'); 
% end

% 辅助函数：根据p值返回星号标记
function stars = getStars(p)
    if p < 0.001
        stars = '***';
    elseif p < 0.01
        stars = '**';
    elseif p < 0.05
        stars = '*';
    else
        stars = 'n.s';
    end
end