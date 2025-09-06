%% 0.01-0.09
clear all
close all
load trioBoldCell0707.mat
hcidx_all = 1:43;
mciidx_all =44:88;
adidx_all = 89:140;
% hcidx_s25 = hcidx_all;
% mciidx_s25 = mciidx_all;
% adidx_s25 = adidx_all;
flp_range = 0.01:0.01:0.05; % flp的范围
fhi_range = 0.07:0.01:0.10; % fhi的范围
sub_all = length(trioBoldCell0707);
timepoints = 170;
n_areas = 90;
TR=2;
delete(gcp('nocreate'))
    core_use = 10; 
    c = parpool(core_use); 
num_flp = length(flp_range);
num_fhi = length(fhi_range);
num_combinations = num_flp * num_fhi;

% 预分配结构体数组，每个字段都初始化为空
results_city(num_combinations) = struct(...
    'value', [], ...
    'cluster_num', [], ...
    'centers', [], ...
    'pms_hc_all', [], ...
    'pms_mci_all', [], ...
    'pms_ad_all', [], ...
    'ptrans_hc',[], ...
    'ptrans_mci',[], ...
    'ptrans_ad',[]);

parfor idx = 1:num_combinations
    [i, j] = ind2sub([num_flp, num_fhi], idx);
    flp = flp_range(i);
    fhi = fhi_range(j);

    fprintf('clusters:cityblock   %.2f -- %.2f \n', flp, fhi);
    
    [iFC_all, Leading_Eig] = leida_emp_trio165(trioBoldCell0707, flp, fhi, sub_all, TR);

    leading_eig_per = reshape(Leading_Eig, [timepoints, sub_all, n_areas]);
    leading_eig = permute(leading_eig_per, [2, 1, 3]);

    cluster = leida_clusters_test(leading_eig, 5);
    cluster_num = size(cluster.C, 1);

    [pms_hc_all, pms_mci_all, pms_ad_all, ptrans_hc, ptrans_mci, ptrans_ad] = ...
        cal_pms_ptrans_trio165(cluster.IDX, timepoints, cluster_num, sub_all, hcidx_all, mciidx_all, adidx_all);

    centers = cluster.C;

    % 直接对结构体数组进行赋值
    results_city(idx).value = [flp, fhi];
    results_city(idx).cluster_num = cluster_num;
    results_city(idx).centers = centers;
    results_city(idx).pms_hc_all = pms_hc_all;
    results_city(idx).pms_mci_all = pms_mci_all;
    results_city(idx).pms_ad_all = pms_ad_all;
    results_city(idx).ptrans_hc= ptrans_hc;
    results_city(idx).ptrans_mci= ptrans_mci;
    results_city(idx).ptrans_ad= ptrans_ad;
end
