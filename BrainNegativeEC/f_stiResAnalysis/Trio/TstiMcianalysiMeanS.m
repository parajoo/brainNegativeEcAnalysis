%% sti-mcine-CandD
clear all
close all
name = 't_stiMciNeCandD0718';
sect = name;
figure_name = name;
load('mci848_data.mat','mci848_simfc')
load (sprintf('%s.mat',sect),'hc895_simfc','stimulus')
hcfc = hc895_simfc;
mcifc = mci848_simfc;
load (sprintf('%s_results.mat',sect));
%% plot 8 figures
load ('idx_net6_lobe7.mat')
ha_idx = haroad;
aun_idx = AUN;
tpl_idx = temporal;
% delete(gcp('nocreate'))
%         core_use = 15;       % 使用cpu核数?
%         c = parpool(core_use);   % 开启并行池
hcMean2Fc = squeeze(mean(hc895_simfc,2));
hcHaMs = mean(hcMean2Fc(ha_idx,:),1);
hcAunMs = mean(hcMean2Fc(aun_idx,:),1);
hcTplMs = mean(hcMean2Fc(tpl_idx,:),1);
k=1;
%% sti-MCI-Ms-cog-relative
idxMs.haMs = ha_idx;
idxMs.aunMs = aun_idx;
idxMs.tplMs = tpl_idx;
region_padMs = {'haMs','aunMs','tplMs'};
%% sti-MCI-Eloc-cog-unrelative
idxEloc.tplEloc = temporal;
idxEloc.occEloc = occipital;
idxEloc.bgEloc = basal_ganglia;
idxEloc.atnEloc = ATN;
idxEloc.aunEloc = AUN;
region_padEloc = {'tplEloc','occEloc','bgEloc','atnEloc','aunEloc'};
%% 
for i = 1:length(results)
    if results(i).kld_pms<0.015
        stimciMean2Fc = squeeze(mean(results(i).simFC,2));
        %% ha
        stimciHaMs = mean(stimciMean2Fc(ha_idx,:),1);
        [~,p_stiad_ha] = ttest2(hcHaMs,stimciHaMs);
        %% tpl
        stimciTplMs = mean(stimciMean2Fc(tpl_idx,:),1);
        [~,p_stiad_tpl] = ttest2(hcTplMs,stimciTplMs);
        %% aun
        stimciAunMs = mean(stimciMean2Fc(aun_idx,:),1);
        [~,p_stiad_aun] = ttest2(hcAunMs,stimciAunMs);
        results_stimci(k).stiNum = i;
        results_stimci(k).p_stiHa = p_stiad_ha;
        results_stimci(k).p_stiTpl = p_stiad_tpl;
        results_stimci(k).p_stiAun = p_stiad_aun;
        if p_stiad_ha>0.05 && p_stiad_tpl>0.05 && p_stiad_aun>0.05
            results_stimci(k).ptest = 3;
            results_stimci(k).stiKld = results(i).kld_pms;
            %% Ms-plot
            plotMs(hcfc,mcifc,results(i).simFC,'','MCI',idxMs,region_padMs,sprintf('%d-Ms-res',i))
            %% Eloc-plot
            [~,hcEloc,~,adEloc,~,stiadEloc] = calFcCCandEloc(hcfc,mcifc,results(i).simFC,1);
            ttestAreaEloc(hcEloc,adEloc,stiadEloc,region_padEloc,idxEloc,'MCI','',sprintf('%d-Eloc-res',i));
        end
        k=k+1;
    end
end
savePath = '/home/zengmin/model/pms_tianjin_data/trio_scale_622/trioRes0718/mciNeCandD0905';  % 替换为你想保存的路径
saveFig626(savePath,'mciNeCandD')

