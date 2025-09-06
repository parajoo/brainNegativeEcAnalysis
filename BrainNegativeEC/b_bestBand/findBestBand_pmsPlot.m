% close all
% city_results = results_cityt;
% textBook = [results_cityt.cluster_num];
% clear results_city
% oulad_results = 0.1*ones(1,10);
% cos_results = 0;
% oula_results = oulad_results;
% for i = 1:length(oula_results)
%     city_results(i).maxdiff = max(abs(city_results(i).pms_hc_all - city_results(i).pms_ad_all));
% end
% city_maxdiff = [city_results.maxdiff];
% figure('Color',[1 1 1]);
% plot(1:10,city_maxdiff,'-o','color',[250 127 111]/255,'LineWidth',1.5,'MarkerFaceColor',[250 127 111]/255);
% hold on
% for i = 1:10
%     text(i, city_maxdiff(i)+0.001, sprintf('N_s:%d', textBook(i)), ...
%         'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',8);
% end
% 
% xlabel('band combinations')
% ylabel('max difference')
% legend('cityblock')
% hold off


%% plot the number of negative elelments under 1000 iterations
% num_negative_ele = zeros(1,1000);
% for i = 1:length(num_negative_ele)
%     ec_cur = results(i).SCnew;
%     num_negative_ele(i) = sum(ec_cur<0,'all');
% end
% figure('color',[1 1 1]);plot(1:length(num_negative_ele),num_negative_ele,'color',[153 153 153]/255,'LineWidth',1.5)


%% brain states -- t-test
% close all
% V = cluster.IDX;
% nSubs = 60; nTime = 480; nStates = 3;
% 
% Vmat = reshape(V,[nTime,nSubs]);
% 
% % 计算每个被试在每个亚状态的占有率
% fracOcc = zeros(nSubs,nStates);
% for s = 1:nSubs
%     for k = 1:nStates
%         fracOcc(s,k) = sum(Vmat(:,s)==k)/nTime;
%     end
% end
% 
% % 分组索引
% idxHC  = hcidx;
% idxMCI = mciidx;
% idxAD  = adidx;
% groupNames = {'HC','MCI','AD'};
% colors = [hex2rgb('b7e4c7')';
%           hex2rgb('b5e2fa')';
%           hex2rgb('cccccc')'];
% %% 绘制 5 张图
% for k = 1:nStates
%     
%     dataHC  = fracOcc(idxHC,k);
%     dataMCI = fracOcc(idxMCI,k);
%     dataAD  = fracOcc(idxAD,k);
%     means = [mean(dataHC), mean(dataMCI), mean(dataAD)];
%     errs  = [std(dataHC),  std(dataMCI),  std(dataAD)];
% 
%     figure('Color',[1 1 1]);
% 
%     b = bar(means,'FaceColor','flat'); 
%     for g=1:3
%         b.CData(g,:) = colors(g,:);
%     end
%     b.FaceAlpha = 0.6;
%     hold on
%     set(gca,'XTickLabel',groupNames);
%     ylabel('probability');
%     title(['State ' num2str(k)]);
%     
%     [~,p12] = ttest2(dataHC, dataMCI,"Vartype","unequal"); % HC vs MCI
%     [~,p13] = ttest2(dataHC, dataAD,"Vartype","unequal");  % HC vs AD
%     [~,p23] = ttest2(dataMCI, dataAD,"Vartype","unequal"); % MCI vs AD
% 
%     yMax = max(means+0.01);
%     yStep = 0.025;
%     ylim([0 yMax+0.05]);
% %     if p12 < 0.05
% %         yMax = max(means(1,2));
% %         plot([1 2],[yMax+yStep yMax+yStep],'k','LineWidth',1.2);
% %         text(1.5,yMax+yStep+0.01,'p<0.05','HorizontalAlignment','center','FontSize',8);
% %     end
% %     if p13 < 0.05
% %         yMax = max(means);
% %         plot([1 3],[yMax+yStep+0.015 yMax+yStep+0.015],'k','LineWidth',1.2);
% %         text(2,yMax+yStep+0.025,'p<0.05','HorizontalAlignment','center','FontSize',8);
% %     end
%     hold off;
% end


%% iter 0 results
% close all
% G_value = [results.G_value];
%         fc_rc = [results.corr];
%         kld_pms = [results.kld_pms];
%         phase_corr = [results.phase_corr];
%         fcd_od = [results.fcd_od];
%         figure(f_num +3);set(gcf,'Color',[1 1 1]);plot(G_value, fc_rc, '-','Color',[0.529 0.294 0.525],'LineWidth',1.5);xlabel('coupling strength');ylabel('value');title('similarity between sim and emp(iter = 0)');grid on;
%         figure(f_num +4);set(gcf,'Color',[1 1 1]);plot(G_value, kld_pms, '-','Color',[0.929 0.294 0.525],'LineWidth',1.5);xlabel('coupling strength');ylabel('value');title('KLD for PMS(iter = 0)');grid on;
%         figure(f_num +5);set(gcf,'Color',[1 1 1]);plot(G_value, fcd_od, '-','Color',[0.129 0.194 0.525],'LineWidth',1.5);xlabel('coupling strength');ylabel('value');title('FCD(iter = 0)');grid on;
%         figure(f_num +6);set(gcf,'Color',[1 1 1]);plot(G_value, phase_corr, '-','Color',[0.329 0.594 0.525],'LineWidth',1.5);xlabel('coupling strength');ylabel('value');title('phase correlation(iter = 0)');grid on;
%     
% range = 11:32;
% x = G_value(range);
% FC_corr   = fc_rc(range);
% KLDforPMS = kld_pms(range);
% PCM_corr  = phase_corr(range);
% lengthX = length(range);
% figure('Color',[1 1 1]);
% 
% c1 = hex2rgb('b7e4c7')';
% c2 = hex2rgb('b5e2fa')';
% c3 = hex2rgb('cccccc')';
% 
% hold on;
% yyaxis left
% p1 = plot(x,FC_corr,'-','Color',c1,'LineWidth',2); hold on;
% delta = 0.005;
% fill([x fliplr(x)], ...
%      [FC_corr+delta fliplr(FC_corr-delta)], ...
%      c1,'FaceAlpha',0.1,'EdgeColor','none');
% 
% 
% p3 = plot(x,PCM_corr,'-','Color',c3,'LineWidth',2);
% delta = 0.005;
% fill([x fliplr(x)], ...
%      [PCM_corr+delta fliplr(PCM_corr-delta)], ...
%      c3,'FaceAlpha',0.1,'EdgeColor','none');
% ylabel('correlation');
% xline(1.5, '--k', 'LineWidth', 1.5);
% ylim([0.11,0.31])
% xlim([1,1.65])
% ax = gca;
% yyaxis right
% 
% 
% % KLD 曲线
% p2 = plot(x,KLDforPMS,'-','Color',c2,'LineWidth',2); hold on;
% delta = 0.001;
% fill([x fliplr(x)], ...
%      [KLDforPMS+delta fliplr(KLDforPMS-delta)], ...
%      c2,'FaceAlpha',0.1,'EdgeColor','none');
% 
% ylabel('KLD');
% ylim([0.001,0.03])
% xlim([1,1.65])
% % 美化
% xlabel('G_c_o_u_p_l_i_n_g');
% legend([p1 p3 p2],{'FC_c_o_r_r','PCM_c_o_r_r','KLD_p_m_s'}, ...
%        'Location','northwest','FontSize',11,'Box','off');
% title('best G','FontWeight','bold');
% grid on; box off;


%% iter1000 results
% close all
% c1 = hex2rgb('b5e2fa')';
% c2 = hex2rgb('cccccc')';
% figure('Color',[1 1 1])
% yyaxis left
% x = 1:length(kl_pms_history);
% p1 = plot(1:length(kl_pms_history), kl_pms_history, '-*', 'Color', c1, 'MarkerFaceColor', c1, 'LineWidth', 1.5); hold on;
% delta = 0.005;
% fill([x fliplr(x)], ...
%      [kl_pms_history+delta fliplr(kl_pms_history-delta)], ...
%      c1,'FaceAlpha',0.1,'EdgeColor','none');ylim([min(kl_pms_history)-0.0005,max(kl_pms_history)+0.001]);
% ylabel('KLD')
% 
% hold on
% yyaxis right
% 
% 
% % KLD 曲线
% p2 = plot(1:length(fc_corr_history), fc_corr_history, '-x', 'Color',c2, 'MarkerFaceColor', c2,'LineWidth', 1.5);hold on
% delta = 0.001;
% fill([x fliplr(x)], ...
%      [fc_corr_history+delta fliplr(fc_corr_history-delta)], ...
%      c2,'FaceAlpha',0.1,'EdgeColor','none');
% ylabel('Correation')
% xlabel('iteration')
% legend([p1 p2],{'KLD_p_m_s','FC_c_o_r_r'}, ...
%        'Location','northwest','FontSize',11,'Box','off');
% 
% box off;
% grid on
% title('results')

%% findBestEc and figrue it
%% pms and FC
% clear all
% close all
% cd /home/zengmin/model/pms_tianjin_data/trio_scale_622/trioResCity0718
% load ('hc895_data.mat','hc895_simfc','hc895_empfc','hc895_simpms')
% load('hc0.mat','pms_hc')
% cd /home/zengmin/model/pms_tianjin_data/b_prisma_moca0105_data/model_results/reCalBestEc
% load('hc874_data.mat','hc874_empfc','hc874_simfc','hc874_emppms','hc874_simpms')
%% 假设数据
c1 = hex2rgb('b5e2fa')';
c2 = hex2rgb('cccccc')';
FC_emp = mean(p_hcfc_scale,3);
FC_sim = mean(results(29).simFC,3);

% 5x1向量
PMS_emp = pms_hc; 
PMS_sim = results(29).pms_hc_sim;

%% 1. 绘制FC矩阵
figure('Color',[1 1 1]);

% 创建一个空矩阵，用NaN填充，下三角和上三角分开
FC_plot = NaN(size(FC_emp));
FC_plot(triu(true(size(FC_emp)),1)) = FC_emp(triu(true(size(FC_emp)),1));  % 上三角
FC_plot(tril(true(size(FC_emp)),-1)) = FC_sim(tril(true(size(FC_sim)),-1)); % 下三角

imagesc(FC_plot);
colorbar;
axis square;
title('empFC vs simFC');

%% 2. 绘制PMS柱状图
figure('Color',[1 1 1]);

states = 1:3;
hold on;

bar_width = 0.4;
bar(states - bar_width/2, PMS_emp, bar_width, 'FaceColor', c1,'FaceAlpha',0.6);
bar(states + bar_width/2, PMS_sim, bar_width, 'FaceColor', c2,'FaceAlpha',0.6);

set(gca, 'XTick', states);
xlabel('states');
ylabel('probability');
legend({'empPMS','simPMS'});
title('PMS');
hold off;

% clear all
% close all
% load idx_net6_lobe7.mat
% idxNetVec = [DMN,ATN,SMN,SUN,AUN,VIS];
% netName = [0,length(DMN),length(ATN),length(SMN),length(SUN),length(AUN),length(DMN)];
% netVecTick = zeros(1,6);
% leftBn = 0;
% for i = 2:length(netName)
%     leftBn = leftBn+netName(i-1);
%     netVecTick(i-1) = leftBn+netName(i)/2;
% end
% netNameChar = {'DMN','ATN','SMN','SUN','AUN','VIS'};
% idxLobeVec = [frontal,parietal,temporal,occipital,basal_ganglia,haroad,limblic_road];
% lobeName = [0,28,12,12,12,8,6,12];
% lobeVecTick = zeros(1,7);
% leftBn = 0;
% for i = 2:length(lobeName)
%     leftBn = leftBn+lobeName(i-1);
%     lobeVecTick(i-1) = leftBn+lobeName(i)/2;
% end
% lobeNameChar = {'Frontal','Parietal','Temporal','Occipital','BasalG','HAroad','Limblic'};
% clear frontal parietal temporal occipital basal_ganglia haroad limblic_road DMN ATN SMN SUN AUN VIS
% load ('hc874_data.mat','hc873_ec')
% load ('mci874_data.mat','mci873_ec')
% load('ad635_data.mat','ad634_ec')
% % ecMat = hc894_ec;
% % 
% % ecMat_po = ecMat;
% % ecMat_po(ecMat_po<0) = 0;
% %ecMatPoLobe = ecMat_po(idxLobeVec,idxLobeVec);
% %plotNetAndLobe(ecMatPoLobe,lobeVecTick,lobeNameChar,'poEC-Lobe',1);
% 
% ecMatPoNet = mci873_ec(idxLobeVec,idxLobeVec);
% A = ecMatPoNet;
% upper_mask = triu(true(size(A)), 1); 
% lower_mask = tril(true(size(A)), -1); 
% 
% upper_pos = A;
% upper_pos(~upper_mask | upper_pos < 0) = 0; 
% lower_neg = A;
% lower_neg(~lower_mask | lower_neg > 0) = 0; 
% % 合并数据并归一化
% combined_data = zeros(size(A));
% combined_data(upper_mask) = upper_pos(upper_mask);
% combined_data(lower_mask) = (lower_neg(lower_mask));
% figure('color',[1 1 1]);plotNetAndLobe(combined_data,lobeVecTick,lobeNameChar,'MCI - poEC(upper triangle) and neEC(lower triangle)',1);
% 
% % ecMat_ne = ecMat;
% % ecMat_ne(ecMat_ne>0) = 0;
% % ecMat_ne = abs(ecMat_ne);
% % ecMatNeLobe = ecMat_ne(idxLobeVec,idxLobeVec);
% % plotNetAndLobe(ecMatNeLobe,lobeVecTick,lobeNameChar,'neEC-Lobe',1);
% % 
% % ecMatNeNet = ecMat_ne(idxNetVec,idxNetVec);
% % subplot(122);
% % plotNetAndLobe(ecMatNeNet,netVecTick,netNameChar,'neEC-net',0);


%% pathology

