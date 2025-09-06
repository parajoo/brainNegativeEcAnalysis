clear all
close all
load prisma1126_emp_sim.mat
load network_lobe_idx.mat
emphcnet = emphc_net;
empmcinet = empmci_net;
empadnet = empmad_net;
%hc
emphc_dmn = emphcnet(:,DMN,:);
emphc_atn = emphcnet(:,ATN,:);
emphc_aun = emphcnet(:,AUN,:);
emphc_smn = emphcnet(:,SMN,:);
emphc_sun = emphcnet(:,SUN,:);
emphc_vis = emphcnet(:,VIS,:);
%mci
empmci_dmn = empmcinet(:,DMN,:);
empmci_atn = empmcinet(:,ATN,:);
empmci_aun = empmcinet(:,AUN,:);
empmci_smn = empmcinet(:,SMN,:);
empmci_sun = empmcinet(:,SUN,:);
empmci_vis = empmcinet(:,VIS,:);
%ad
empad_dmn = empadnet(:,DMN,:);
empad_atn = empadnet(:,ATN,:);
empad_aun = empadnet(:,AUN,:);
empad_smn = empadnet(:,SMN,:);
empad_sun = empadnet(:,SUN,:);
empad_vis = empadnet(:,VIS,:);
%%
range = 2:11;
%dmn
ad_dmn_mean = mean(squeeze(mean(squeeze(empad_dmn(range,:,:)),1)),1);
ad_dmn_std = std(ad_dmn_mean);
hc_dmn_mean = mean(squeeze(mean(squeeze(emphc_dmn(range,:,:)),1)),1);
hc_dmn_std = std(hc_dmn_mean);
mci_dmn_mean = mean(squeeze(mean(squeeze(empmci_dmn(range,:,:)),1)),1);
mci_dmn_std = std(mci_dmn_mean);
%atn
ad_atn_mean = mean(squeeze(mean(squeeze(empad_atn(range,:,:)),1)),1);
ad_atn_std = std(ad_atn_mean);
hc_atn_mean = mean(squeeze(mean(squeeze(emphc_atn(range,:,:)),1)),1);
hc_atn_std = std(hc_atn_mean);
mci_atn_mean = mean(squeeze(mean(squeeze(empmci_atn(range,:,:)),1)),1);
mci_atn_std = std(mci_atn_mean);
%aun
ad_aun_mean = mean(squeeze(mean(squeeze(empad_aun(range,:,:)),1)),1);
ad_aun_std = std(ad_aun_mean);
hc_aun_mean = mean(squeeze(mean(squeeze(emphc_aun(range,:,:)),1)),1);
hc_aun_std = std(hc_aun_mean);
mci_aun_mean = mean(squeeze(mean(squeeze(empmci_aun(range,:,:)),1)),1);
mci_aun_std = std(mci_aun_mean);
%smn
ad_smn_mean = mean(squeeze(mean(squeeze(empad_smn(range,:,:)),1)),1);
ad_smn_std = std(ad_smn_mean);
hc_smn_mean = mean(squeeze(mean(squeeze(emphc_smn(range,:,:)),1)),1);
hc_smn_std = std(hc_smn_mean);
mci_smn_mean = mean(squeeze(mean(squeeze(empmci_smn(range,:,:)),1)),1);
mci_smn_std = std(mci_smn_mean);
%sun
ad_sun_mean = mean(squeeze(mean(squeeze(empad_sun(range,:,:)),1)),1);
ad_sun_std = std(ad_sun_mean);
hc_sun_mean = mean(squeeze(mean(squeeze(emphc_sun(range,:,:)),1)),1);
hc_sun_std = std(hc_sun_mean);
mci_sun_mean = mean(squeeze(mean(squeeze(empmci_sun(range,:,:)),1)),1);
mci_sun_std = std(mci_sun_mean);
%vis
ad_vis_mean = mean(squeeze(mean(squeeze(empad_vis(range,:,:)),1)),1);
ad_vis_std = std(ad_vis_mean);
hc_vis_mean = mean(squeeze(mean(squeeze(emphc_vis(range,:,:)),1)),1);
hc_vis_std = std(hc_vis_mean);
mci_vis_mean = mean(squeeze(mean(squeeze(empmci_vis(range,:,:)),1)),1);
mci_vis_std = std(mci_vis_mean);





