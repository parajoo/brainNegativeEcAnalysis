close all

v1 = [pms_hc(1,1),pms_ad(1,1),pms_mci_ad(1,1)];
v2 = [pms_hc(1,2),pms_ad(1,2),pms_mci_ad(1,2)];
v3 = [pms_hc(1,3),pms_ad(1,3),pms_mci_ad(1,3)];
tik = {'HC','AD','MCI-AD'};
colors = [73/255, 108/255, 136/255, 0.7; 
          169/255, 184/255, 198/255, 0.7;  
          254/255, 178/255, 180/255, 0.7];
figure('color',[1 1 1]);
b1 = bar(v1,'FaceColor','flat');
for k = 1:length(v1)
    b1.CData(k, :) = colors(k, 1:3);  % 颜色
    b1.FaceAlpha = colors(k, 4);       % 透明度
end

% 设置x轴标签
set(gca, 'XTickLabel', tik);

% 添加标题和标签
title('state1');
xlabel('group');
ylim([0,0.325]);
ylabel('probility');
y_max1 = max(v1) + 0.01; % 找到最大值并设定显著性标记高度
y_max2 = max(v1) + 0.03;
% 添加显著性标记
hold on;
plot([1, 2], [y_max1, y_max1], 'k-', 'LineWidth', 1); % 绘制线
text(1.5, y_max1 + 0.0025, '**', 'FontSize', 15, 'HorizontalAlignment', 'center'); % 显著性标记
hold on;
plot([1, 3], [y_max2, y_max2], 'k-', 'LineWidth', 1); % 绘制线
text(2, y_max2 + 0.0025, '***', 'FontSize', 15, 'HorizontalAlignment', 'center');
hold off;
figure('color',[1 1 1]);
b2 = bar(v2,'FaceColor','flat');
for k = 1:length(v2)
    b2.CData(k, :) = colors(k, 1:3);  % 颜色
    b2.FaceAlpha = colors(k, 4);       % 透明度
end

% 设置x轴标签
set(gca, 'XTickLabel', tik);

% 添加标题和标签
title('state2');
xlabel('group');
ylabel('probility');
y_max1 = max(v2) + 0.01; % 找到最大值并设定显著性标记高度
y_max2 = max(v2) + 0.03;
y_max3 = max(v2) + 0.05;
% 添加显著性标记
hold on;
plot([1, 2], [y_max1, y_max1], 'k-', 'LineWidth', 1); % 绘制线
text(1.5, y_max1 + 0.0025, '**', 'FontSize', 15, 'HorizontalAlignment', 'center'); % 显著性标记
hold on;
plot([1, 3], [y_max2, y_max2], 'k-', 'LineWidth', 1); % 绘制线
text(2, y_max2 + 0.0025, '***', 'FontSize', 15, 'HorizontalAlignment', 'center');
hold on;
plot([2, 3], [y_max3, y_max3], 'k-', 'LineWidth', 1); % 绘制线
text(2.5, y_max3 + 0.0025, '*', 'FontSize', 15, 'HorizontalAlignment', 'left');
hold off
figure('color',[1 1 1]);
b3 = bar(v3,'FaceColor','flat');
for k = 1:length(v3)
    b3.CData(k, :) = colors(k, 1:3);  % 颜色
    b3.FaceAlpha = colors(k, 4);       % 透明度
end

% 设置x轴标签
set(gca, 'XTickLabel', tik);
ylim ([0,0.45]);
% 添加标题和标签
title('state3');
xlabel('group');
ylabel('probility');
