% close all
% clear all
% close all
% load hcCity1000Results_0718.mat
% load hcCity1000_0718.mat

simfc_hc = mean(trioHcFc0707,3);
oulad_all = zeros(1,length(results));
for i=1:length(results)
    simfc_cur = results(i).simFC;
    simfc_mean = mean(simfc_cur,3);
    simfc_mean = simfc_mean - eye(90,90);
    oulad_all(i) = 2*real(sum((simfc_hc(Isubdiag) - simfc_mean(Isubdiag)).^2));
end
figure('Color',[1 1 1]);
plot(1:length(oulad_all),oulad_all);
figure('Color',[1 1 1]);
plot(1:length(oulad_all),[results.kld_pms]);
fcCorrAll = [results.corr];
range=1:1000;
figure('color',[1 1 1]);
kld_pms_all = [results.kld_pms];
range_new = 1:1000;
figure('color',[1 1 1]);
subplot(3,1,1);
plot(1:length(range_new),kld_pms_all(range_new),'Color','k','LineStyle','-','LineWidth',1.5);
ylabel('KLD')
title('KLD of PMS')
grid on;
subplot(3,1,2);
plot(1:length(range_new),oulad_all(range_new),'Color','k','LineStyle','-','LineWidth',1.5);
ylabel('oula distance')
title('oulad bewteen empFC and simFC')
grid on;
subplot(3,1,3);
plot(1:length(range_new),fcCorrAll(range_new),'Color','k','LineStyle','-','LineWidth',1.5);
ylabel('correlation')
title('preason correlation bewteen empFC and simFC')
grid on;
hold off
figure('color',[1 1 1]);

% 使用 yyaxis 创建双 y 轴
yyaxis left
plot(1:length(range), kl_pms_history(range), '-*', 'Color', [0 0 0]/255, 'MarkerFaceColor', [0.85, 0.325, 0.098], 'LineWidth', 1.2);
title('KLD and FC Correlation');
xlabel('Iteration Number');
ylabel('KLD');
hold on;

% 自定义左侧 y 轴颜色
ax = gca;
ax.YColor = [0 0 0]/255; % 设置左侧 y 轴颜色

yyaxis right
plot(1:length(range), oulad_all(range), '-x', 'Color', [40 120 181]/255, 'MarkerFaceColor', [0.929, 0.694, 0.125], 'LineWidth', 1.2);
ylabel('FC Correlation');

% 自定义右侧 y 轴颜色
ax.YColor = [40 120 181]/255; % 设置右侧 y 轴颜色

% 调整图形
set(gca, 'LineWidth', 1.2);
set(gca,'FontWeight','bold');
%% find index
close all
c1 = hex2rgb('b5e2fa')';
c2 = hex2rgb('cccccc')';
kld_pms_all = [results.kld_pms];
kld_th = 0.0001;
indices_kld = find(kld_pms_all<kld_th);
indices_kld_values = kld_pms_all(indices_kld);
if ~isempty(indices_kld)
    oulad_indices_kld = oulad_all(indices_kld);
    [min_oulad,min_index] = min(oulad_indices_kld);
end
figure('color',[1 1 1]);
subplot(1,2,1);
plot(1:length(indices_kld_values), indices_kld_values, '-*', 'Color', c1, 'MarkerFaceColor', c1, 'LineWidth', 1.5);
title('KLD');
xticks(1:length(indices_kld));
xticklabels(arrayfun(@(x) sprintf('%d', indices_kld(x)), 1:length(indices_kld), 'UniformOutput', false));
%xlabel('Iteration Number');
ylabel('Value');
subplot(1,2,2);
plot(1:length(indices_kld_values), oulad_indices_kld, '-o', 'Color', c2, 'MarkerFaceColor', c2, 'LineWidth', 1.5);
title('oulad');
xticks(1:length(indices_kld));
xticklabels(arrayfun(@(x) sprintf('%d', indices_kld(x)), 1:length(indices_kld), 'UniformOutput', false));
%xlabel('Iteration Number');
ylabel('Value');

figure('color',[1 1 1]);

% 使用 yyaxis 创建双 y 轴
yyaxis left
plot(1:length(indices_kld_values), indices_kld_values, '-*', 'Color', c1, 'MarkerFaceColor', c1, 'LineWidth', 1.5);
ylabel('KLD')
hold on;

% 自定义左侧 y 轴颜色
ax = gca;
ax.YColor = 'k'; % 设置左侧 y 轴颜色
[~,mi] = min(oulad_indices_kld);
xline(mi,'--k','LineWidth',1.5)
yyaxis right
plot(1:length(indices_kld_values), oulad_indices_kld, '-o', 'Color', c2, 'MarkerFaceColor', c2, 'LineWidth', 1.5);
%title('Euler distance');
xticks(1:length(indices_kld));
xticklabels(arrayfun(@(x) sprintf('%d', indices_kld(x)), 1:length(indices_kld), 'UniformOutput', false));
%xlabel('Iteration Number');
ylabel('Euler distance');
box off
% 自定义右侧 y 轴颜色
ax.YColor = 'k';
title('HC')
% 调整图形
set(gca, 'LineWidth', 1.5);
set(gca,'FontWeight','bold');