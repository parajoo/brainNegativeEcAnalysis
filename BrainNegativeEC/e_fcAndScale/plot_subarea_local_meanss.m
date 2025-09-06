%% brain lobe:local efficiency and coeefficient
clear all
close all
load('ad981_res.mat','ad981_simfc')
load('mci987_res.mat','mci987_simfc')
load ('hc989_res.mat','hc989_simfc')
[simhcNetMs,simmciNetMs,simadNetMs] = plot_subarea_local_meanssl(hc989_simfc,mci987_simfc,ad981_simfc,6,1);
[simhcLobeMs,simmciLobeMs,simadLobeMs] = plot_subarea_local_meanssl(hc989_simfc,mci987_simfc,ad981_simfc,7,1);
function [emphcMs,empmciMs,empadMs] = plot_subarea_local_meanssl(hcfc,mcifc,adfc,areaIdx,diagIdx)
load network_lobe_idx.mat
%% haroad = hippocampal+amygdala;fusi
haroad = [hippocampal,amygdala];
limblic_road = [insula,cingulate,paracentral,fusiform];
%% lobe
if areaIdx == 7
    lobe_name = {frontal,temporal,occipital,parietal,basal_ganglia,haroad,limblic_road};
elseif areaIdx == 6
    lobe_name = {DMN,SUN,SMN,VIS,ATN,AUN};
end
%% for meansc
if diagIdx == 1
    for iii=1:15
    emphc_netC_mean(:,:,iii) = hcfc(:,:,iii) - eye(90,90);
    empmci_netC_mean(:,:,iii) = mcifc(:,:,iii) - eye(90,90);
    empad_netC_mean(:,:,iii) = adfc(:,:,iii) - eye(90,90);
    end
else
    emphc_netC_mean = hcfc;
    empmci_netC_mean = mcifc;
    empad_netC_mean = adfc;
end
for i=1:length(lobe_name)
    if areaIdx == 7
        s = sprintf('lobe%d',i);
    elseif areaIdx ==6
        s = sprintf('subnet%d',i);
    end
    %hc
    emphc_lobei_fc = squeeze(mean(emphc_netC_mean(lobe_name{i},lobe_name{i},:),1));
    emphcMs.(s).value= emphc_lobei_fc;
    emphcMs.(s).mean= mean(emphc_lobei_fc,1);
    emphcMs.(s).std= std(mean(emphc_lobei_fc,1));
    %mci
    empmci_lobei_fc = squeeze(mean(empmci_netC_mean(lobe_name{i},lobe_name{i},:),1));
    empmciMs.(s).value= empmci_lobei_fc;
    empmciMs.(s).mean= mean(empmci_lobei_fc,1);
    empmciMs.(s).std= std(mean(empmci_lobei_fc,1));
    %ad
    empad_lobei_fc = squeeze(mean(empad_netC_mean(lobe_name{i},lobe_name{i},:),1));
    empadMs.(s).value= empad_lobei_fc;
    empadMs.(s).mean= mean(empad_lobei_fc,1);
    empadMs.(s).std= std(mean(empad_lobei_fc,1));
end
end