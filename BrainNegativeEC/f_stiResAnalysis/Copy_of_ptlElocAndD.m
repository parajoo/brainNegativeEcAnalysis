% clear all
% close all
% name = 't_stiAdNeC0718';
% sect = name;
% figure_name = name;
% load('ad943_data.mat','ad943_simfc')
% load (sprintf('%s.mat',sect),'hc895_simfc','stimulus','results')
% load('hc0.mat','Isubdiag')
% %load (sprintf('%s_results.mat',sect));
% hcfc = hc895_simfc;
% adfc = ad943_simfc;
% load ('idx_net6_lobe7.mat','basal_ganglia')
% basalganlia_idx = basal_ganglia;

clear all
close all
load tAdNeCRes.mat
load('ad943_data.mat','ad943_simpms')
load('hc895_data.mat','hc895_simpms')
klHcVsAd = calculateKLDivergences_test_new(ad943_simpms,hc895_simpms);
%% plot KLD and FC-Dist
colors = [hex2rgb('b7e4c7')';
          hex2rgb('b5e2fa')';
          hex2rgb('cccccc')';];

% simfc_hc = hc895_simfc;
% oulad_all = zeros(1,length(results));
% for i=1:length(results)
%     simfc_cur = results(i).simFC;
%     simfc_mean = mean(simfc_cur,3);
%     simfc_mean = simfc_mean - eye(90,90);
%     oulad_all(i) = 2*real(sum((simfc_hc(Isubdiag) - simfc_mean(Isubdiag)).^2));
% end
% kl_pms_history = [results.kld_pms];
% range = 1:length(results);
figure('Color',[1 1 1])
range = [-0.01:0.001:-0.001,0.001:0.001:0.01];
kl_pms_out0 = kl_pms_history;
kl_pms_out0(11) = [];
figure('Color',[1 1 1]);
yyaxis left
plot(range, kl_pms_out0, '-', 'Color',colors(1,:), 'MarkerFaceColor', colors(1,:), 'LineWidth', 2);
title('KLD and FC Distance');
xlabel('SI');
ylabel('KLD');
ylim([0.01,0.06])
hold on
plot(range,klHcVsAd*ones(1,length(range)), '-', 'Color',colors(2,:), 'MarkerFaceColor', colors(2,:), 'LineWidth', 2)
hold on;
ax = gca;
ax.YColor = [0 0 0]/255;
ouladAll = oulad_all;
ouladAll(11) = [];
yyaxis right
plot(range, ouladAll, '-', 'Color',colors(3,:), 'MarkerFaceColor', colors(3,:), 'LineWidth', 2);
ylabel('FC Distance');
ax.YColor = [0 0 0]/255;
set(gca, 'LineWidth', 1.2);
set(gca,'FontWeight','bold');
ylim([70,90])
%xlim([1,length(results)])
xlim([min(range), max(range)]);   % x轴范围覆盖 range
xticks(range);                    % 指定刻度值

%ylim([0,0.06])
legend('KLD','Distance','target-KLD')
box off;
%% calculate bg's Eloc of simAD,simHC and stiAD
% colors = [hex2rgb('b7e4c7')';
%           hex2rgb('b5e2fa')';
%           hex2rgb('cccccc')';];
% p_values = ones(length(results),1);
%     thRange = 2:9;
%     delete(gcp('nocreate'))
%     core_use = 15;
%     c = parpool(core_use);
% stiadBGE = ones(length(results),1);  
% for i=1:length(results)
%     if results(i).kld_pms < 0.025
%     stiFc = results(i).simFC;
%     [~,hcEloc,~,adEloc,~,stiadEloc] = calFcCCandEloc(hcfc,adfc,stiFc,1);
%     hcBasalgE = mean(mean(hcEloc(basalganlia_idx,:,thRange),3),1)';
%     adBasalgE = mean(mean(adEloc(basalganlia_idx,:,thRange),3),1)';
%     stiadBasalgE = mean(mean(stiadEloc(basalganlia_idx,:,thRange),3),1)';
%     [~,p_stiad] = ttest2(hcBasalgE,stiadBasalgE);
%     p_values(i) = p_stiad;
%     end
% end
% 
%% 
figure('Color',[1 1 1]);
plot(range,mean(hcBasalgE)*ones(length(range),1),'Color',colors(1,:),'LineStyle','-','LineWidth',2);hold on
plot(range,mean(adBasalgE)*ones(length(range),1),'Color',colors(3,:),'LineStyle','-','LineWidth',2);hold on
ylim([0.22,0.27])
idx = [0.006,0.007];
yidx = [0.26,0.23];
%plo%t(idx,yidx,'Color',colors(2,:),'MarkerSize',12,'MarkerFaceColor',colors(2,:))
scatter(idx,yidx,40,colors(2,:),'filled')
legend('hc-BG-Eloc','ad-BG-Eloc','sti-ad')
box off;
xlim([min(range), max(range)]);   % x轴范围覆盖 range
xticks(range);
ylabel('Eloc')



% sigIdx = find(p_values > 0.05)
% 
% hold on;
% 
% plot(sigIdx, stiadBasalgE*ones(length(sigIdx),1), 'ro', ...
%     'MarkerFaceColor','r','MarkerSize',6);
















