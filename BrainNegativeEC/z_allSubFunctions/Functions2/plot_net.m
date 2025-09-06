hc_eloc = hc_eloc;
ad_eloc = ad_eloc;
mciad_eloc = mciad_eloc;
variables = {'HC', 'AD', 'MCI-AD'};
values = [mean(hc_eloc), mean(ad_eloc), mean(mciad_eloc)];

% 自定义颜色（RGBA格式）
colors = [73/255, 108/255, 136/255, 0.7; 
          169/255, 184/255, 198/255, 0.7;  
          254/255, 178/255, 180/255, 0.7]; 

% 创建柱状图
figure('Color',[1 1 1]);
b = bar(values, 'FaceColor', 'flat');

% 设置颜色和透明度
for k = 1:length(values)
    b.CData(k, :) = colors(k, 1:3);  % 颜色
    b.FaceAlpha = colors(k, 4);       % 透明度
end

% 设置x轴标签
set(gca, 'XTickLabel', variables);

% 添加标题和标签
title('local efficient');
xlabel('group');
ylabel('value');

% % 显著性差异标记
% % 假设变量2与变量1显著性差异
y_max = max(values) + 0.05; % 找到最大值并设定显著性标记高度

% 添加显著性标记
hold on;
plot([1, 2], [y_max, y_max], 'k-', 'LineWidth', 2); % 绘制线
text(1.5, y_max + 0.05, '*', 'FontSize', 12, 'HorizontalAlignment', 'center'); % 显著性标记
hold off;
