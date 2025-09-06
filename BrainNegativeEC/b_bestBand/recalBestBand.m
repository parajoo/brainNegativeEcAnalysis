clear all
close all
load trioBoldCell0707.mat
hcidx = 1:43;
mciidx =44:88;
adidx = 89:140;
flp = 0.04;
fhi = 0.08;
nsub = length(trioBoldCell0707);
timepoints = 170;
n_areas = 90;
TR = 2;
[iFC_all,Leading_Eig] = leida_emp_trio165(trioBoldCell0707,flp,fhi,nsub,TR);
leading_eig_per = reshape(Leading_Eig, [timepoints, nsub, n_areas]);
leading_eig = permute(leading_eig_per,[2,1,3]);
cluster = leida_clusters_test(leading_eig,5);
cluster_num = size(cluster.C,1);
[pms_hc , pms_mci , pms_ad,ptrans_hc,ptrans_mci,ptrans_ad] = cal_pms_ptrans_trio165(cluster.IDX,timepoints,cluster_num,nsub,hcidx,mciidx,adidx);
centers = cluster.C;