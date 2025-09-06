%% brain lobe:local efficiency and coeefficient
% clear all
% close all
% load('ad981_res.mat','ad981_simfc')
% load('mci987_res.mat','mci987_simfc')
% load ('hc989_res.mat','hc989_simfc')
% [simhcNetMs,simmciNetMs,simadNetMs] = plot_subarea_glocal_meanssl(hc989_simfc,mci987_simfc,ad981_simfc,6,1);
% [simhcLobeMs,simmciLobeMs,simadLobeMs] = plot_subarea_glocal_meanssl(hc989_simfc,mci987_simfc,ad981_simfc,7,1);
%% STIMU0627
% clear all
% close all
% load stiAdNeCandD627_results.mat
% %idxRight = [332,353];
% idxRight = [124,248,332,353,355,375,394,435];
% load('ad981_res.mat','ad981_simfc')
% load('hc989_res.mat','hc989_simfc')
% hcfc = hc989_simfc;
% adfc = ad981_simfc;
% 
% for i=1:length((idxRight))
%     stiadfc = results(idxRight(i)).simFC;
%     [simhcNetMs,simadNetMs,stiadNetMs] = plot_subarea_glocal_meanssl(hcfc,adfc,stiadfc,6,1);
%     [simhcLobeMs,simadLobeMs,stiadLobeMs] = plot_subarea_glocal_meanssl(hcfc,adfc,stiadfc,7,1);
%     save(sprintf('%s%dMS.mat','adneCandD',idxRight(i)),'simhcNetMs','simadNetMs','stiadNetMs','simhcLobeMs','simadLobeMs','stiadLobeMs');
% end
% 
% clear all
% close all
% load stiAdPoCandD627_results.mat
% %idxRight = [124,333,438];
% idxRight = [76,124,333,438];
% load('ad981_res.mat','ad981_simfc')
% load('hc989_res.mat','hc989_simfc')
% hcfc = hc989_simfc;
% adfc = ad981_simfc;
% 
% for i=1:length((idxRight))
%     stiadfc = results(idxRight(i)).simFC;
%     [simhcNetMs,simadNetMs,stiadNetMs] = plot_subarea_global_meanssl(hcfc,adfc,stiadfc,6,1);
%     [simhcLobeMs,simadLobeMs,stiadLobeMs] = plot_subarea_global_meanssl(hcfc,adfc,stiadfc,7,1);
%     save(sprintf('%s%dMS.mat','adpoCandD',idxRight(i)),'simhcNetMs','simadNetMs','stiadNetMs','simhcLobeMs','simadLobeMs','stiadLobeMs');
% end
%% trioDATA0707-0718
% clear all
% close all
% load('ad943_data.mat','ad943_simfc')
% load('mci848_data.mat','mci848_simfc')
% load ('hc895_data.mat','hc895_simfc')
% hcfc = hc895_simfc;
% mcifc = mci848_simfc;
% adfc = ad943_simfc;
% [hcNetMs,mciNetMs,adNetMs] = plot_subarea_global_meanssl(hcfc,mcifc,adfc,6,1);
% [hcLobeMs,mciLobeMs,adLobeMs] = plot_subarea_global_meanssl(hcfc,mcifc,adfc,7,1);
%% pathology -- 821
clear all
load ('tGroup3Fc_scale0905.mat','tAdFc','tMciFc','tHcFc')
%adfc(:,:,36) = [];
hcfc = tHcFc;
mcifc = tMciFc;
adfc = tAdFc;
clear tAdFc tMciFc tHcFc
[hcNetMs,mciNetMs,adNetMs] = plot_subarea_global_meanssl(hcfc,mcifc,adfc,6,0);
[hcLobeMs,mciLobeMs,adLobeMs] = plot_subarea_global_meanssl(hcfc,mcifc,adfc,7,0);
clear hcfc mcifc adfc
function [emphcMs,empmciMs,empadMs] = plot_subarea_global_meanssl(hcfc1,mcifc1,adfc1,areaIdx,diagIdx)
load network_lobe_idx.mat
%% haroad = hippocampal+amygdala;fusi
haroad = [hippocampal,amygdala];
limblic_road = [insula,cingulate,paracentral,fusiform];
if diagIdx ==1
    for i=1:15
        hcfc(:,:,i) = hcfc1(:,:,i) - eye(90,90);
        mcifc(:,:,i) =mcifc1(:,:,i) - eye(90,90);
        adfc(:,:,i) = adfc1(:,:,i) - eye(90,90);
    end
else
    hcfc = hcfc1;
    mcifc = mcifc1;
    adfc = adfc1;
end
%% lobe
if areaIdx == 7
    lobe_name = {frontal,temporal,occipital,parietal,basal_ganglia,haroad,limblic_road};
elseif areaIdx == 6
    lobe_name = {DMN,SUN,SMN,VIS,ATN,AUN};
end
%% for meansc
emphc_netC_mean = squeeze(mean(hcfc,2));
empmci_netC_mean = squeeze(mean(mcifc,2));
empad_netC_mean = squeeze(mean(adfc,2));
for i=1:length(lobe_name)
    if areaIdx == 7
        s = sprintf('lobe%d',i);
    elseif areaIdx ==6
        s = sprintf('subnet%d',i);
    end
    %hc
    emphcMs.(s).value= emphc_netC_mean(lobe_name{i},:);
    emphcMs.(s).mean= mean(emphc_netC_mean(lobe_name{i},:),1);
    emphcMs.(s).std= std(mean(emphc_netC_mean(lobe_name{i},:),1));
    %mci
    empmciMs.(s).value= empmci_netC_mean(lobe_name{i},:);
    empmciMs.(s).mean= mean(empmci_netC_mean(lobe_name{i},:),1);
    empmciMs.(s).std= std(mean(empmci_netC_mean(lobe_name{i},:),1));
    %ad
    empadMs.(s).value= empad_netC_mean(lobe_name{i},:);
    empadMs.(s).mean= mean(empad_netC_mean(lobe_name{i},:),1);
    empadMs.(s).std= std(mean(empad_netC_mean(lobe_name{i},:),1));
end
end
