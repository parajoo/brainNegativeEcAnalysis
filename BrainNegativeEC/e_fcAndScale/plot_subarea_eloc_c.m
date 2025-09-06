% clear all
% close all
% load ptGroup3CCandEloc0707.mat
% simhc_netC = emphc_netC;
% simmci_netC = empmci_netC;
% simad_netC = empad_netC;
% [hcNetC,mciNetC,adNetC] = plot_subarea_eloc_cl(simhc_netC,simmci_netC,simad_netC,6);
% [hcLobeC,mciLobeC,adLobeC] = plot_subarea_eloc_cl(simhc_netC,simmci_netC,simad_netC,7);
% simhc_netE = emphc_netE;
% simmci_netE = empmci_netE;
% simad_netE = empad_netE;
% [hcNetE,mciNetE,adNetE] = plot_subarea_eloc_cl(simhc_netE,simmci_netE,simad_netE,6);
% [hcLobeE,mciLobeE,adLobeE] = plot_subarea_eloc_cl(simhc_netE,simmci_netE,simad_netE,7);
% clear simhc_netE simhc_netC simmci_netE simmci_netC simad_netC simad_netE
% clear emphc_netE emphc_netC empmci_netE empmci_netC empad_netC empad_netE
% clear all
% close all
% load ('hc989_res.mat','hc989_simfc')
% load ('mci987_res.mat','mci987_simfc')
% load ('ad981_res.mat','ad981_simfc')
% clear all
% close all
% load ptGroup3CCandEloc0707.mat
[hcNetE,mciNetE,adNetE] = plot_subarea_eloc_cl(emphc_netE,empmci_netE,empad_netE,6);
[hcLobeE,mciLobeE,adLobeE] = plot_subarea_eloc_cl(emphc_netE,empmci_netE,empad_netE,7);
% 
[hcNetC,mciNetC,adNetC] = plot_subarea_eloc_cl(emphc_netC,empmci_netC,empad_netC,6);
[hcLobeC,mciLobeC,adLobeC] = plot_subarea_eloc_cl(emphc_netC,empmci_netC,empad_netC,7);
clear emphc_netE empmci_netE empad_netE emphc_netC empmci_netC empad_netC
function [emphcNetp,empmciNetp,empadNetp] = plot_subarea_eloc_cl(hcNetProperty,mciNetProperty,adNetProperty,areaIdx)
load network_lobe_idx.mat
%% haroad = hippocampal+amygdala;fusi
haroad = [hippocampal,amygdala];
limblic_road = [insula,cingulate,paracentral,fusiform];
% clear hippocampal amygdala insula cingulate paracentral fusiform
% clear frontal occipital parietal temporal basal_ganglia
%% lobe
if areaIdx == 7
    lobe_name = {frontal,temporal,occipital,parietal,basal_ganglia,haroad,limblic_road};
elseif areaIdx == 6
    lobe_name = {DMN,SUN,SMN,VIS,ATN,AUN};
end

%% network property
thRange = 2:9;
emphc_netC_mean = mean(hcNetProperty(:,:,thRange),3);
empmci_netC_mean = mean(mciNetProperty(:,:,thRange),3);
empad_netC_mean = mean(adNetProperty(:,:,thRange),3);
for i=1:length(lobe_name)
    if areaIdx == 7
        s = sprintf('lobe%d',i);
    elseif areaIdx == 6
        s = sprintf('subnet%d',i);
    end
    emphcNetp.(s).value= emphc_netC_mean(lobe_name{i},:);
    emphcNetp.(s).mean= mean(emphc_netC_mean(lobe_name{i},:),1);
    emphcNetp.(s).std= std(mean(emphc_netC_mean(lobe_name{i},:),1));
    empmciNetp.(s).value= empmci_netC_mean(lobe_name{i},:);
    empmciNetp.(s).mean= mean(empmci_netC_mean(lobe_name{i},:),1);
    empmciNetp.(s).std= std(mean(empmci_netC_mean(lobe_name{i},:),1));
    empadNetp.(s).value= empad_netC_mean(lobe_name{i},:);
    empadNetp.(s).mean= mean(empad_netC_mean(lobe_name{i},:),1);
    empadNetp.(s).std= std(mean(empad_netC_mean(lobe_name{i},:),1));
end
%% figure
% data_mean = zeros(length(lobe_name),3);
% data_error = zeros(length(lobe_name),3);
% for i=1:length(lobe_name)
%     if areaIdx == 7
%         s = sprintf('lobe%d',i);
%     elseif areaIdx == 6
%         s = sprintf('subnet%d',i);
%     end
%     data_mean(i,1) = mean(emphcNetp.(s).mean);
%     data_mean(i,2) = mean(empmciNetp.(s).mean);
%     data_mean(i,3) = mean(empadNetp.(s).mean);
%     data_error(i,1) = emphcNetp.(s).std;
%     data_error(i,2) = empmciNetp.(s).std;
%     data_error(i,3) = empadNetp.(s).std;
% end
% num_groups = 3;  
% num_regions = length(lobe_name); 
% figure('Color','white');
% hBar = bar(data_mean, 'BarWidth', 0.8);
% hold on;
% 
% colors = [142 139 254;
%     254 163 162;
%     111 111 111]./255;
% 
% for k = 1:num_groups
%     hBar(k).FaceColor = colors(k,:);
%     hBar(k).FaceAlpha = 0.7; 
% end
% 
% xPositions = zeros(num_regions, num_groups);
% for k = 1:num_groups
%     xPositions(:,k) = hBar(k).XEndPoints;
% end
% if areaIdx ==7
%     lobe_name_char = {'frontal','temporal','occipital','parietal','basal ganglia','haroad','limblic road'};
% elseif areaIdx == 6
%     lobe_name_char = {'DMN','SUN','SMN','VIS','ATN','AUN'};
% end
% set(gca, 'FontSize', 12, 'LineWidth', 1.2);
% ylabel('Eloc', 'FontSize', 14,'FontWeight','bold');
% title('empdata', 'FontSize', 16);
% legend([hBar(1), hBar(2), hBar(3)], {'HC', 'MCI', 'AD'});
% 
% ax = gca;
% ax.XTickLabel = lobe_name_char;
% ax.XTickLabelRotation = 0;
% ax.XAxis.FontWeight = 'bold';
% ax.YAxis.FontWeight = 'bold';
% set(gca, 'Position', [0.1 0.15 0.85 0.75]);
% hold off;
end