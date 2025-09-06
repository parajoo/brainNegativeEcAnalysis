% clear all
% close all
%% 5
% emp_hc = pms_hc;
% emp_mci = pms_mci;
% emp_ad = pms_ad;
% 
% % 为不同的亚状态指定颜色
% colors = [
%     130, 176,210;
%     190,184,220;
%     231,218,210;
%     153,153,153;
%     142,207,201
% ]./255;
% alpha = 0.7;
% % 创建一个柱状图
% figure('Color',[1 1 1]);
% hold on;
% 
% % 绘制经验的柱状图
% for i = 1:length(emp_hc)
%     h1 = bar(i-0.3, emp_hc(i), 'BarWidth', 0.3);
%     set(h1, 'FaceColor', colors(i, :), 'FaceAlpha', alpha);
% end
% 
% % 绘制模拟的柱状图
% for i = 1:length(emp_mci)
%     h2 = bar(i, emp_mci(i), 'BarWidth', 0.3);
%     set(h2, 'FaceColor', colors(i, :), 'FaceAlpha', alpha);
% end
% 
% for i = 1:length(emp_ad)
%     h2 = bar(i+0.3, emp_ad(i), 'BarWidth', 0.3);
%     set(h2, 'FaceColor', colors(i, :), 'FaceAlpha', alpha);
% end
% % 添加图例和其他图形属性
% xlabel('states');
% ylabel('probability');
% title('emp-HC emp-MCI emp-AD');
% set(gca, 'xtick', 1:5, 'xticklabel', {'state1', 'state2', 'state3', 'state4', 'state5'});
% 
% hold off;
%% 4
% emp_hc = pms_hc;
% emp_mci = pms_mci;
% emp_ad = pms_ad;
% 
% % 为不同的亚状态指定颜色
% colors = [
%     130, 176,210;
%     190,184,220;
%     231,218,210;
%     153,153,153;
%     %142,207,201
% ]./255;
% alpha = 0.7;
% % 创建一个柱状图
% figure('Color',[1 1 1]);
% hold on;
% 
% % 绘制经验的柱状图
% for i = 1:length(emp_hc)
%     h1 = bar(i-0.3, emp_hc(i), 'BarWidth', 0.3);
%     set(h1, 'FaceColor', colors(i, :), 'FaceAlpha', alpha);
% end
% 
% % 绘制模拟的柱状图
% for i = 1:length(emp_mci)
%     h2 = bar(i, emp_mci(i), 'BarWidth', 0.3);
%     set(h2, 'FaceColor', colors(i, :), 'FaceAlpha', alpha);
% end
% 
% for i = 1:length(emp_ad)
%     h2 = bar(i+0.3, emp_ad(i), 'BarWidth', 0.3);
%     set(h2, 'FaceColor', colors(i, :), 'FaceAlpha', alpha);
% end
% % 添加图例和其他图形属性
% xlabel('states');
% ylabel('probability');
% title('emp-HC emp-MCI emp-AD');
% set(gca, 'xtick', 1:4, 'xticklabel', {'state1', 'state2', 'state3', 'state4'});
% 
% hold off;
%% 3
% idx = [4,6,10,16];
% for j = 1:length(idx)
% 
%     %i = idx(j);
%     emp_hc = hc719_emp_pms;
%     emp_mci = mci891_emp_pms;
%     emp_ad = ad923_emp_pms;
% 
%     % 为不同的亚状态指定颜色
%     colors = [
%         130, 176,210;
%         190,184,220;
%         231,218,210;
%         ]./255;
%     alpha = 0.7;
%     % 创建一个柱状图
%     figure('Color',[1 1 1]);
%     hold on;
% 
%     % 绘制经验的柱状图
%     for i = 1:length(emp_hc)
%         h1 = bar(i-0.3, emp_hc(i), 'BarWidth', 0.3);
%         set(h1, 'FaceColor', colors(i, :), 'FaceAlpha', alpha);
%     end
% 
%     % 绘制模拟的柱状图
%     for i = 1:length(emp_mci)
%         h2 = bar(i, emp_mci(i), 'BarWidth', 0.3);
%         set(h2, 'FaceColor', colors(i, :), 'FaceAlpha', alpha);
%     end
% 
%     for i = 1:length(emp_ad)
%         h3 = bar(i+0.3, emp_ad(i), 'BarWidth', 0.3);
%         set(h3, 'FaceColor', colors(i, :), 'FaceAlpha', alpha);
%     end
%     % 添加图例和其他图形属性
%     xlabel('states');
%     ylabel('probability');
%     title('sim-HC sim-MCI sim-AD');
%     set(gca, 'xtick', 1:3, 'xticklabel', {'state1', 'state2', 'state3'});
% 
%     hold off;
% end
%% plot the PMS under different frequency and calculating methods
%close all
% idx = 18;
% results = results_city;
% for j=1:length(idx)
%     i = idx(j);
%     emp_hc = results(i).pms_hc_all;
%     emp_mci = results(i).pms_mci_all;
%     emp_ad = results(i).pms_ad_all;
% 
%     % 为每个组别（HC, MCI, AD）指定颜色
%     colors = [
%         130, 176, 210; % 第一类颜色
%         190, 184, 220; % 第二类颜色
%         231, 218, 210; 
%         153, 153, 153;
%         % 第三类颜色
%         142,207,201]./255;
%     alpha = 0.7;
% 
%     % 创建一个柱状图
%     figure('Color', [1 1 1]);
%     hold on;
% 
%     % 绘制每个状态的柱状图，并确保每组的第一个柱子、第二个柱子、第三个柱子颜色不一样
%     num_states = length(emp_hc); % 假设emp_hc、emp_mci和emp_ad长度相同
% 
%     for k = 1:num_states
%         % HC组的柱子
%         h1 = bar(k - 0.3, emp_hc(k), 'BarWidth', 0.3);
%         set(h1, 'FaceColor', colors(1, :), 'FaceAlpha', alpha);
% 
%         % MCI组的柱子
%         h2 = bar(k, emp_mci(k), 'BarWidth', 0.3);
%         set(h2, 'FaceColor', colors(2, :), 'FaceAlpha', alpha);
% 
%         % AD组的柱子
%         h3 = bar(k + 0.3, emp_ad(k), 'BarWidth', 0.3);
%         set(h3, 'FaceColor', colors(3, :), 'FaceAlpha', alpha);
%     end
% 
%     % 添加图例和其他图形属性
%     xlabel('States');
%     ylabel('Probability');
%     ylim([0,0.3]);
%     title('empirical PMS');
%     legend('HC','MCI','AD')
%     set(gca, 'xtick', 1:num_states, 'xticklabel', {'state1', 'state2', 'state3'});
% 
%     hold off;
% end
%% hc-ad 3
% close all
% emp_pms = pms_ad;
% %emp_mci = pms_mci;
% sim_pms = results(839).pms_ad_sim;
% 
% % 为不同的亚状态指定颜色
% colors = [
%     130, 176,210;
%     190,184,220;
%     231,218,210;
% ]./255;
% alpha = 0.7;
% % 创建一个柱状图
% figure('Color',[1 1 1]);
% hold on;
% 
% % 绘制经验的柱状图
% for i = 1:length(emp_pms)
%     h1 = bar(i, emp_pms(i), 'BarWidth', 0.45);
%     set(h1, 'FaceColor', colors(i, :), 'FaceAlpha', alpha);
% end
% 
% % % 绘制模拟的柱状图
% % for i = 1:length(emp_mci)
% %     h2 = bar(i, emp_mci(i), 'BarWidth', 0.3);
% %     set(h2, 'FaceColor', colors(i, :), 'FaceAlpha', alpha);
% % end
% 
% for i = 1:length(sim_pms)
%     h2 = bar(i+0.45, sim_pms(i), 'BarWidth', 0.45);
%     set(h2, 'FaceColor', colors(i, :), 'FaceAlpha', alpha);
% end
% % 添加图例和其他图形属性
% xlabel('states');
% ylabel('probability');
% title('emp vs sim PMS');
% set(gca, 'xtick', 1:3, 'xticklabel', {'state1', 'state2', 'state3'});
%%
hc_sim_pms = pms_hc;
mci_sim_pms = pms_ad;
stimulus_mci_pms = pms_mci;


 colors = [hex2rgb('b7e4c7')';
          hex2rgb('b5e2fa')';
          hex2rgb('cccccc')'];

alpha = 0.7;
figure('Color',[1 1 1]);
hold on;
bar_w = 0.3;

h1 = [];
for i = 1:length(hc_sim_pms)
    h1 = [h1; bar(i-bar_w, hc_sim_pms(i), 'BarWidth', bar_w)]; 
    set(h1(end), 'FaceColor', colors(1, :), 'FaceAlpha', alpha);
end

h2 = [];
for i = 1:length(stimulus_mci_pms)
    h2 = [h2; bar(i, stimulus_mci_pms(i), 'BarWidth', bar_w)];
    set(h2(end), 'FaceColor', colors(2, :), 'FaceAlpha', alpha);
end

h3 = [];
for i = 1:length(mci_sim_pms)
    h3 = [h3; bar(i+bar_w, mci_sim_pms(i), 'BarWidth', bar_w)];
    set(h3(end), 'FaceColor', colors(3, :), 'FaceAlpha', alpha);
end

legend([h1(1), h2(1), h3(1)], {'HC', 'MCI', 'AD'});

xlabel('substates');
ylabel('probability');
set(gca, 'xtick', 1:3, 'xticklabel', {'state1', 'state2', 'state3'});
%title('MCI-regulation(Hippocampal-amygdala circut)')
title('(trio)0.01-0.09')
hold off;
