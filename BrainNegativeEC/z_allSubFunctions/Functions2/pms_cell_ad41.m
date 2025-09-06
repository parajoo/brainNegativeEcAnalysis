%% part1:calculate PMS of emperical subject
    clear all
    close all
    
    load cell_global_ad41.mat
    flp = 0.04;
    fhi = 0.07;%original:0.12
    sub_all = 14+14+41;
    timepoints = 480;
    n_areas = 90;
    [iFC_all,Leading_Eig] = leida_emp_ad41(cell_global_ad41,flp,fhi);
    leading_eig = reshape(Leading_Eig, [sub_all, timepoints, n_areas]);
    cluster = leida_clusters_test(leading_eig,5);
    cluster_num = size(cluster.C,1);
    [pms_hc , pms_ad , pms_mci_ad] = cal_pms_ad41(cluster.IDX,timepoints,cluster_num);
    centers = cluster.C;