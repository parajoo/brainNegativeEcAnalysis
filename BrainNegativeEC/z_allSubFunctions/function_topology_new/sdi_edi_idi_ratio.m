%% EDI/IDI
clear all
close all
load sim_hc_sdi_poec_results.mat
hcE_coupling = mean_c;
hcE_decoupling = mean_d;
hcE_sdi = dsi;
clear mean_c mean_d mPSD dsi
load sim_hc_sdi_results_noabs.mat
hcI_coupling = mean_c;
hcI_decoupling = mean_d;
hcI_sdi = dsi;
clear mean_c mean_d mPSD dsi
load sim_mci_sdi_poec_results.mat
mciE_coupling = mean_c;
mciE_decoupling = mean_d;
mciE_sdi = dsi;
clear mean_c mean_d mPSD dsi
load sim_mci_sdi_results_noabs.mat
mciI_coupling = mean_c;
mciI_decoupling = mean_d;
mciI_sdi = dsi;
clear mean_c mean_d mPSD dsi
load sim_ad_sdi_poec_results.mat
adE_coupling = mean_c;
adE_decoupling = mean_d;
adE_sdi = dsi;
clear mean_c mean_d mPSD dsi
load sim_ad_sdi_results_noabs.mat
adI_coupling = mean_c;
adI_decoupling = mean_d;
adI_sdi = dsi;
clear mean_c mean_d mPSD dsi
hc_coupling_EI = hcE_coupling./hcI_coupling;
hc_decoupling_EI = hcE_decoupling./hcI_decoupling;
mci_coupling_EI = mciE_coupling./mciI_coupling;
mci_decoupling_EI = mciE_decoupling./mciI_decoupling;
ad_coupling_EI = adE_coupling./adI_coupling;
ad_decoupling_EI = adE_decoupling./adI_decoupling;
figure('Color',[1 1 1]);
hold on;
plot(1:90,hc_coupling_EI,'Color',[20 81 124]/255,'LineWidth',1.3);
plot(1:90,mci_coupling_EI,'Color',[50 184 151]/255,'LineWidth',1.3);
plot(1:90,ad_coupling_EI,'Color',[247 136 132]/255,'LineWidth',1.3);
plot(1:90,ones(90,1),'Color','k','LineWidth',1.3);
title('coupling-E/I')
legend('HC','MCI','AD')
hold off;

figure('Color',[1 1 1]);
hold on;
plot(1:90,hc_decoupling_EI,'Color',[20 81 124]/255,'LineWidth',1.3);
plot(1:90,mci_decoupling_EI,'Color',[50 184 151]/255,'LineWidth',1.3);
plot(1:90,ad_decoupling_EI,'Color',[247 136 132]/255,'LineWidth',1.3);
plot(1:90,ones(90,1),'Color','k','LineWidth',1.3);
title('decoupling-E/I')
legend('HC','MCI','AD')
hold off;
