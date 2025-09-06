% % clear all
close all
clear all
load t184_data_empnet_g.mat
% %load net_trio42.mat
% load emp78_net_index1113.mat
emp_net_hc = emphc_net;
emp_net_mci = empmci_net;
emp_net_ad = empmad_net;
%%
range =2:10;%2:11
for i = 1:4
    ad_mean(i,:) = mean(squeeze(emp_net_ad(range,:,i)),1);
    ad_std(i,:) = std(squeeze(emp_net_ad(range,:,i))');
    hc_mean(i,:) = mean(squeeze(emp_net_hc(range,:,i)),1);
    hc_std(i,:) = std(squeeze(emp_net_hc(range,:,i))');
    mci_mean(i,:) = mean(squeeze(emp_net_mci(range,:,i)),1);
    mci_std(i,:) = std(squeeze(emp_net_mci(range,:,i))');
end
%% 阈值为0
model = squeeze(ad_mean(:,1));
HC = squeeze(hc_mean(:,1));
R_mean = [squeeze(hc_mean(:,1)),squeeze(mci_mean(:,1)),squeeze(ad_mean(:,1))];
R_std = [squeeze(hc_std(:,1)),squeeze(mci_std(:,1)),squeeze(ad_std(:,1))];
figure('Color',[1 1 1]);
for i = 1:4
    figure(i);
    set(gcf,'Color',[1 1 1]);
    mean_new = R_mean(i,:);
    std = R_std(i,:);
    handles = bar(1:3,mean_new,0.5,'linewidth',0.7);
    handles.FaceColor = 'flat';
    handles.CData(1,:) = [73 108 136]/255;
    handles.CData(2,:) = [169 184 198]/255;
    handles.CData(3,:) = [254 178 180]/255;
    handles.FaceAlpha = 0.7;
    hold on;
    
    if i==1
        hErrorbar  = errorbar(1:3,mean_new,std, 'k');
    set(hErrorbar,'color','K','marker', 'none', 'linestyle', 'none', 'linewidth', 1);
        ylabel('CC','fontsize',10);
    elseif i==2
        ylabel('PL','fontsize',10);
    elseif i==3
hErrorbar  = errorbar(1:3,mean_new,std, 'k');
    set(hErrorbar,'color','K','marker', 'none', 'linestyle', 'none', 'linewidth', 1);
        ylabel('Eg','fontsize',10);
    else
        hErrorbar  = errorbar(1:3,mean_new,std, 'k');
    set(hErrorbar,'color','K','marker', 'none', 'linestyle', 'none', 'linewidth', 1);
        ylabel('Eloc','fontsize',10);
    end
    set(gca,'XTickLabel',{'HC','MCI','AD'})
    box off
    
end
% 进行ANOVA分析并记录结果
% 进行t检验并记录结果
p_values = zeros(3, 4); % 存储p值，3组比较，4个指标
for i = 1:4
    % 提取每个指标的组别数据
    HC_data = squeeze(emp_net_hc(range,:,i));
    MCI_data = squeeze(emp_net_mci(range,:,i));
    AD_data = squeeze(emp_net_ad(range,:,i));
    HC_y1=squeeze(HC_data(:,1));
    MCI_y1 = squeeze(MCI_data(:,1));
    AD_y1 = squeeze(AD_data(:,1));

    % 进行两两比较
    [~, p_values(1, i)] = ttest2(HC_y1(:), MCI_y1(:)); % HC vs MCI
    [~, p_values(2, i)] = ttest2(HC_y1(:), AD_y1(:)); % HC vs AD
    [~, p_values(3, i)] = ttest2(MCI_y1(:), AD_y1(:)); % MCI vs AD
end

% 输出p值
disp('P-values for the comparisons (HC vs MCI, HC vs AD, MCI vs AD):')
disp(p_values)