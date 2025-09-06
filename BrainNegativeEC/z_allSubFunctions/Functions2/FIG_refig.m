% figure('Color',[1 1 1]);
% plot(1:length(kl_pms_history), kl_pms_history, '-*', 'Color', [142/255, 207/255, 201/255], 'MarkerFaceColor', [142/255, 207/255, 201/255], 'LineWidth', 1.35);
% title('KLD of empirical and simulated data');
% xlabel('Iterations');
% ylabel('Value');
% drawnow;
% figure('Color',[1 1 1]);
% plot(1:length(fc_corr_history), fc_corr_history, '-x', 'Color', [190/255, 184/255, 220/255], 'MarkerFaceColor', [190/255, 184/255, 220/255], 'LineWidth', 1.35);
% title('FC similarity between empirical and simulated data');
% xlabel('Iterations');
% ylabel('Value');
% drawnow;
figure('Color',[1 1 1]);
yyaxis left;

% 绘制第一条曲线
plot(1:length(kl_pms_history), kl_pms_history, '-*', ...
    'Color', [255/255, 190/255, 122/255], ...
    'MarkerFaceColor', [255/255, 190/255, 122/255], ...
    'LineWidth', 1.2);
ylabel('KLD','Color','k');
set(gca,'YColor','k');
hold on;
plot(127, kl_pms_history(127), 'o', 'MarkerEdgeColor', [255/255, 190/255, 122/255], 'MarkerFaceColor', [0/255 0/255 0/255], 'MarkerSize', 6);
yyaxis right;

% 绘制第二条曲线
plot(1:length(fc_corr_history), fc_corr_history, '-x', ...
    'Color', [130/255, 176/255, 210/255], ...
    'MarkerFaceColor',[130/255, 176/255, 210/255], ...
    'LineWidth', 1.2);
ylabel('FC Similarity','Color','k');
ylim([0,1]);
set(gca,'YColor','k');
% 添加标题和标签
title('KLD and FC similarity between empirical and simulated data');
xlabel('Iterations');
hold on;
plot(127, fc_corr_history(127), 'o', 'MarkerEdgeColor', [130/255, 176/255, 210/255], 'MarkerFaceColor', [0/255 0/255 0/255], 'MarkerSize', 6);
% 添加图例
legend('KLD', 'FC similarity');

% 显示图形
drawnow;
