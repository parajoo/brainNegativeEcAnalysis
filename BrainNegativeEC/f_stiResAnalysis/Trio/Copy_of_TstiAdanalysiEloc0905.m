%% sti-adne-CandD
clear all
close all
name = 't_stiAdPoCandD0718';
sect = name;
figure_name = name;
load('ad943_data.mat','ad943_simfc')
load (sprintf('%s.mat',sect),'hc895_simfc','stimulus')
load (sprintf('%s_results.mat',sect));
hcfc = hc895_simfc;
adfc = ad943_simfc;
%% plot 8 figures
load ('idx_net6_lobe7.mat')
%% sti-Ad-Eloc-cog-unrelative
idxEloc.bgEloc =basal_ganglia;
idxEloc.bgEloc =basal_ganglia;
idxEloc.ptlEloc = parietal;
idxEloc.aunEloc = AUN;
idxEloc.smnEloc = SMN;
region_padEloc = {'bgEloc','ptlEloc','aunEloc','smnEloc'};
%% sti-MCI-Ms-cog-relative
idxMs.haMs = haroad;
idxMs.ftlMs = frontal;
idxMs.tplMs = temporal;
idxMs.ptlMs = parietal;
idxMs.smnMs = SMN;
region_padMs = {'haMs','ftlMs','tplMs','ptlMs','smnMs'};
thRange = 2:9;
basalganlia_idx = basal_ganglia;
% delete(gcp('nocreate'))
%         core_use = 15;       % 使用cpu核数?
%         c = parpool(core_use);   % 开启并行池
%% 
for i = 1:length(results)
    if results(i).kld_pms<0.015
        stiFc = results(i).simFC;
        [~,hcEloc,~,adEloc,~,stiadEloc] = calFcCCandEloc(hcfc,adfc,stiFc,1);
        hcBasalgE = mean(mean(hcEloc(basalganlia_idx,:,thRange),3),1)';
        adBasalgE = mean(mean(adEloc(basalganlia_idx,:,thRange),3),1)';
        stiadBasalgE = mean(mean(stiadEloc(basalganlia_idx,:,thRange),3),1)';
        [~,p_ad] = ttest2(hcBasalgE,adBasalgE);
        [~,p_stiad] = ttest2(hcBasalgE,stiadBasalgE);
        if p_ad<0.05 && p_stiad>0.05
            %% Ms-plot
            plotMs(hcfc,adfc,results(i).simFC,'','AD',idxMs,region_padMs,sprintf('%d-Ms-res',i))
            %% Eloc-plot
            ttestAreaEloc(hcEloc,adEloc,stiadEloc,region_padEloc,idxEloc,'AD','',sprintf('%d-Eloc-res',i));
        end
    end
end
savePath = '/home/zengmin/model/pms_tianjin_data/trio_scale_622/trioRes0718/ADPoCandD0905';  % 替换为你想保存的路径
saveFig626(savePath,'ADPoCandD')

