% part1:calculate PMS of emperical subject
    clear all
    close all
    
    load cell_global_bna.mat
    flp_range = 0.01:0.01:0.05; % flp的范围
    fhi_range = 0.06:0.01:0.10; % fhi的范围
    sub_all = 14*3 ;
    timepoints = 480;
    n_areas = 246;
% 初始化用于存储结果的结构体或数组
results = struct();
kk =1;
% 遍历所有flp和fhi的组合
for i = 1:length(flp_range)
    for j = 1:length(fhi_range)
        flp = flp_range(i);
        fhi = fhi_range(j);

        [iFC_all,Leading_Eig] = leida_emp_bna(cell_global_bna,flp,fhi);
        leading_eig = reshape(Leading_Eig, [sub_all, timepoints, n_areas]);
        cluster = leida_clusters_test(leading_eig,5);
        cluster_num = size(cluster.C,1);
        [pms_hc , pms_ad , pms_mci_ad] = cal_pms_bna(cluster.IDX,timepoints,cluster_num);
        centers = cluster.C;

        % 存储每个组合的结果。这里假设您想存储cluster centers和pms
        results(kk).value = [flp,fhi];
        results(kk).cluster_num = cluster_num;
        results(kk).centers = centers;
        results(kk).pms_hc = pms_hc;
        results(kk).pms_ad = pms_ad;
        results(kk).pms_mci_ad = pms_mci_ad;
        kk = kk+1;
    end
end

% % 结果存储在results结构体中，您可以根据需要进行进一步的处理或分析
% load hc_ad_moca.mat
% [iFC_all, Leading_Eig] = leida_emp_0329(hc_ad_moca, 0.05, 0.15);
%         leading_eig = reshape(Leading_Eig, [28, 230, 90]);
%         cluster = leida_clusters(leading_eig);
%         cluster_num = size(cluster.C, 1);
%         [pms_hc, pms_ad] = cal_pms_all_28(cluster.IDX, 230, cluster_num);
%         centers = cluster.C;







