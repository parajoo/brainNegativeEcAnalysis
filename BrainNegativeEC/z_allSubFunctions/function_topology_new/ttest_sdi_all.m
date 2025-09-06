clear all
%close all
load hc_sdi_results_meansc.mat
load mci_sdi_results_meansc.mat
load ad_sdi_results_meansc.mat
AD_SDI = mci_sdi_all;
HC_SDI =hc_sdi_all;

p_values = zeros(90, 1); 
t_stats = zeros(90, 1);  

for i = 1:90
    [~, p_values(i), ~, stats] = ttest2(AD_SDI(i, :), HC_SDI(i, :)); 
    t_stats(i) = stats.tstat; 
end

alpha = 0.05; 
significant_mask = p_values < alpha;
[significant_regions, ~] = find(significant_mask);  % 获取显著差异的脑区索引
% scatter(significant_regions, zeros(size(significant_regions)), 'r', 'filled'); % 在显著差异的脑区位置上标记红点
% legend('T-statistics', 'Significant Changes', 'Location', 'Best');

figure('Color',[1 1 1]);
bar(t_stats);
hold on;
bar(significant_regions, t_stats(significant_regions), 'FaceColor',[216 56 58]./255);
title('SDI-MCI vs HC(empirical data-meanSC)');
xlabel('Brain areas');
ylabel('T-statistics');
legend('Non-significant', 'Significant');
%% vec v = 1:AD<HC;v = 2:AD>HC
significant_vec = zeros(1,90);
for i=1:length(significant_regions)
    if t_stats(significant_regions(i))<0
        significant_vec(significant_regions(i)) = 1;
    else
        significant_vec(significant_regions(i)) = 2;
    end
end
% 假设p_values是每个脑区的p值，已经通过t检验计算得到
% p_values: 90 x 1  向量，存储每个脑区的p值
% alpha = 0.05;  % 原始显著性水平
% n = length(p_values);  % 检验的总数（即脑区数，90个脑区）
% 
% % 进行Bonferroni校正
% alpha_adjusted = alpha / n;  % 校正后的显著性水平
% 
% % 找到显著的脑区
% significant_mask = p_values < alpha_adjusted;  % 显著性检验
% 
% % 显示显著性差异的脑区
% significant_regions = find(significant_mask);  % 获取显著差异的脑区索引
% disp('Significant brain regions after Bonferroni correction:');
% disp(significant_regions);
