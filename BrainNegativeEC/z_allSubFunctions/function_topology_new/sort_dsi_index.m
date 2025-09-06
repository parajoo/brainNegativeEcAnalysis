clear all
close all
load dsi_ad_neec_noabs.mat
load dsi_mci_neec_noabs.mat
load dsi_hc_neec_noabs.mat
hc_dsi_1 = dsi_hc_neec_noabs - 1;
mci_dsi_1 = dsi_mci_neec_noabs - 1;
ad_dsi_1 = dsi_ad_neec_noabs - 1;
[hc_sv,hc_si] = sort(hc_dsi_1);
[mci_sv,mci_si] = sort(mci_dsi_1);
[ad_sv,ad_si] = sort(ad_dsi_1);
