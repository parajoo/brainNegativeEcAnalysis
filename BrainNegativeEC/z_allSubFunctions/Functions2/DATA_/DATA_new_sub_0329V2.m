clear all
close all

load cell_hcad_neww.mat
flp_range = 0.01:0.01:0.05; % flp的范围
fhi_range = 0.07:0.01:0.15; % fhi的范围
% delete(gcp('nocreate'))
% core_use = 10;       % 使用cpu核数?
% c = parpool(core_use);   % 开启并行池
% c.IdleTimeout = 4800;

num_com = length(flp_range)*length(fhi_range);
results(num_com) = struct('value', [], 'cluster_num', [], 'centers', [], 'pms_hc', [], 'pms_ad', [], 'diff', [], 'states', []);

for idx = 1:num_com
    [i, j] = ind2sub([length(flp_range), length(fhi_range)], idx);
    flp = flp_range(i);
    fhi = fhi_range(j);
    [iFC_all, Leading_Eig] = leida_emp(cell_hcad_neww, flp, fhi);
    leading_eig = reshape(Leading_Eig, [28, 230, 90]);
    cluster = leida_clusters(leading_eig, 8);
    cluster_num = size(cluster.C, 1);
    [pms_hc, pms_ad] = cal_pms_all_28(cluster.IDX, 230, cluster_num);
    centers = cluster.C;
    %% 假设检验
    [ttest_results, nonsignificant_states] = static_diff_cluster(cluster, cluster_num);
    if length(nonsignificant_states) == 0
        results(idx).LE = leading_eig;
        results(idx).iFC = iFC_all;
        results(idx).cluster = cluster;
    end
    results(idx).value = [flp, fhi];
    results(idx).cluster_num = cluster_num;
    results(idx).centers = centers;
    results(idx).pms_hc = pms_hc;
    results(idx).pms_ad = pms_ad;
    diff = abs(pms_hc - pms_ad);
    max_diff = max(diff);
    min_diff = min(diff);
    max_min_diff = [min_diff max_diff];
    results(idx).diff = max_min_diff;
    results(idx).states = nonsignificant_states;
end
function [ttest_results, nonsignificant_states] = static_diff_cluster(cluster, cluster_num)
original_vec = cluster.IDX;
num_subjects = length(original_vec) / (230 * 2);
hc_data_vec = original_vec(1:num_subjects*230);
ad_data_vec = original_vec(num_subjects*230+1:end); 
hc_data_mat = reshape(hc_data_vec, 230, num_subjects);
ad_data_mat = reshape(ad_data_vec, 230, num_subjects);
hc_pms = zeros(num_subjects, cluster_num); 
ad_pms = zeros(num_subjects, cluster_num); 
for i = 1:num_subjects
    for state = 1:cluster_num
        hc_pms(i, state) = sum(hc_data_mat(:, i) == state);
        ad_pms(i, state) = sum(ad_data_mat(:, i) == state);
    end
end

ttest_results = struct();
nonsignificant_states = []; 
for i = 1:cluster_num
    [h, p, ci, stats] = ttest2(hc_pms(:, i), ad_pms(:, i), 'Vartype', 'unequal');
    ttest_results(i).state = i;
    ttest_results(i).p_value = p;
    ttest_results(i).h_value = h;
    ttest_results(i).confidence_interval = ci;
    ttest_results(i).stats = stats;
    if p > 0.05
        nonsignificant_states = [nonsignificant_states; i];
    end
end
end
