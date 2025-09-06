%% part1:calculate PMS of emperical subject
    clear all
    close all
%     
%     load hc_ad_moca.mat
%      flp_range = 0.01:0.01:0.05; % flp的范围
% fhi_range = 0.07:0.01:0.10; % fhi的范围
% 
% % 初始化用于存储结果的结构体或数组
% results = struct();
% kk =1;
% % 遍历所有flp和fhi的组合
% for i = 1:length(flp_range)
%     for j = 1:length(fhi_range)
%         flp = 0.02;
%         fhi = 0.11;
% 
%         % 根据当前的flp和fhi调用您的函数
%         [iFC_all, Leading_Eig] = leida_emp_0329(hc_ad_moca, flp, fhi);
%         leading_eig = reshape(Leading_Eig, [28, 230, 90]);
%         cluster = leida_clusters(leading_eig);
%         cluster_num = size(cluster.C, 1);
%         [pms_hc, pms_ad] = cal_pms_all_28(cluster.IDX, 230, cluster_num);
%         centers = cluster.C;
% 
%         % 存储每个组合的结果。这里假设您想存储cluster centers和pms
%         results(kk).value = [flp,fhi];
%         results(kk).cluster_num = cluster_num;
%         results(kk).centers = centers;
%         results(kk).pms_hc = pms_hc;
%         results(kk).pms_ad = pms_ad;
%         diff = pms_hc - pms_ad;
%         results(kk).diff = diff;
%         kk = kk+1;
%     end
% end

% 结果存储在results结构体中，您可以根据需要进行进一步的处理或分析
load hc_ad_moca.mat
[iFC_all, Leading_Eig] = leida_emp_0329(hc_ad_moca, 0.04, 0.07);
        leading_eig = reshape(Leading_Eig, [28, 230, 90]);
        cluster = leida_clusters(leading_eig);
        cluster_num = size(cluster.C, 1);
        [pms_hc, pms_ad] = cal_pms_all_28(cluster.IDX, 230, cluster_num);
        centers = cluster.C;







