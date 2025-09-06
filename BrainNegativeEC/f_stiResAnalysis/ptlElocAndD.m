% clear all
% close all
% name = 't_stiAdNeCandD0718';
% sect = name;
% figure_name = name;
% load('ad943_data.mat','ad943_simfc')
% load (sprintf('%s.mat',sect),'hc895_simfc','stimulus')
% load('hc0.mat','Isubdiag')
% load (sprintf('%s_results.mat',sect));
% hcfc = hc895_simfc;
% adfc = ad943_simfc;
% load ('idx_net6_lobe7.mat','basal_ganglia')
% basalganlia_idx = basal_ganglia;

clear all
close all
load tAdNeCandD.mat
load('ad943_data.mat','ad943_simpms')
load('hc895_data.mat','hc895_simpms')
%klHcVsAd = calculateKLDivergences_test_new(ad943_simpms,hc895_simpms);
klHcVsAd = 0.015;
%% plot KLD and FC-Dist
colors = [hex2rgb('b7e4c7')';
          hex2rgb('b5e2fa')';
          hex2rgb('cccccc')';];

simfc_hc = hc895_simfc;
oulad_all = zeros(1,length(results));
for i=1:length(results)
    simfc_cur = results(i).simFC;
    simfc_mean = mean(simfc_cur,3);
    simfc_mean = simfc_mean - eye(90,90);
    oulad_all(i) = 2*real(sum((simfc_hc(Isubdiag) - simfc_mean(Isubdiag)).^2));
end
kl_pms_history = [results.kld_pms];
klAll = kl_pms_history;
klAll(221) = [];
range = 1:length(klAll);
figure('Color',[1 1 1]);
yyaxis left
plot(1:length(range), klAll, '-', 'Color',colors(1,:), 'MarkerFaceColor', [0.85, 0.325, 0.098], 'LineWidth', 1.5);
title('KLD and FC Distance');
xlabel('SI combs');
ylabel('KLD');
hold on;

plot(range,klHcVsAd*ones(1,length(range)), '-', 'Color',colors(2,:), 'MarkerFaceColor', colors(2,:), 'LineWidth', 2)
hold on;
ax = gca;
ax.YColor = [0 0 0]/255;
oulaAll = oulad_all;
oulaAll(221) = [];
yyaxis right
plot(1:length(range), oulaAll, '-', 'Color',colors(3,:), 'MarkerFaceColor', [0.929, 0.694, 0.125], 'LineWidth', 1.5);
ylabel('FC Distance');
ax.YColor = [0 0 0]/255;
set(gca, 'LineWidth', 1.2);
set(gca,'FontWeight','bold');
xlim([1,length(results)])
box off;
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
%     [~,hcEloc,~,adEloc,~,adadEloc] = calFcCCandEloc(hcfc,adfc,adfc,1);
%     hcBasalgE = mean(mean(hcEloc(basalganlia_idx,:,thRange),3),1)';
%     adBasalgE = mean(mean(adEloc(basalganlia_idx,:,thRange),3),1)';
%     stiadBasalgEAll = ones(length(range),1);
% for i=1:length(results)
%     if results(i).kld_pms<0.015
%         stiFc = results(i).simFC;
%         [~,~,~,~,~,stiadEloc] = calFcCCandEloc(hcfc,adfc,stiFc,1);
%         stiadBasalgE = mean(mean(stiadEloc(basalganlia_idx,:,thRange),3),1)';
%         [~,p_stiad] = ttest2(hcBasalgE,stiadBasalgE);
%         p_values(i) = p_stiad;
%         stiadBasalgEAll(i)=mean(stiadBasalgE);
%     end
% end
%%

% figure('Color',[1 1 1]);
% plot(1:length(range),mean(hcBasalgE)*ones(1,length(range)),'Color',colors(1,:),'LineStyle','-','LineWidth',1.3);
% plot(1:length(range),mean(adBasalgE)*ones(1,length(range)),'Color',colors(3,:),'LineStyle','-','LineWidth',1.3);


% sigIdx = find(p_values < 0.05);
% 
% hold on;
% plot(sigIdx, stiadBasalgE*ones(length(sigIdx),1), 'ro', ...
%     'MarkerFaceColor','r','MarkerSize',6);
%% 

figure('Color',[1 1 1]);
plot(range,mean(hcBasalgE)*ones(length(range),1),'Color',colors(1,:),'LineStyle','-','LineWidth',2);hold on
plot(range,mean(adBasalgE)*ones(length(range),1),'Color',colors(3,:),'LineStyle','-','LineWidth',2);hold on
ylim([0.22,0.27])
pVall = p_values;
pVall(221) = [];
% 假设你的原始向量叫 vec
vec = pVall;
idx = find(vec < 1);    % 找到小于1的索引
l = length(idx);        % 索引数量

ypoints = zeros(1, l);

% 根据条件赋值
for i = 1:l
    if vec(idx(i)) < 0.05
        ypoints(i) = 0.23;
    else
        ypoints(i) = 0.255;
    end
end

% 生成对应的 xpoints（就是索引位置）
xpoints = idx;
%plo%t(idx,yidx,'Color',colors(2,:),'MarkerSize',12,'MarkerFaceColor',colors(2,:))
scatter(xpoints,ypoints,40,colors(2,:),'filled')
legend('hc-BG-Eloc','ad-BG-Eloc','sti-ad(p_b_e_f_o_r_e<0.05 and p_a_f_t_e_r>0.05)')
box off;
xlim([min(range), max(range)]);   % x轴范围覆盖 range
xlabel('SI combs')
ylabel('Eloc')













