%% p-mci-ne-CandD
clear all
close all
name = 'p_mcineCandD';
sect = name;
figure_name = name;
load('mci874_data.mat','mci874_simfc')
load (sprintf('%s.mat',sect),'hc874_simfc','stimulus')
load (sprintf('%s_results.mat',sect));
load ('idx_net6_lobe7.mat','temporal')
tpl_idx = temporal;
%% plot all figs
hcfc = hc874_simfc;
mcifc = mci874_simfc;
load ('idx_net6_lobe7.mat')
%ad-Eloc -- frontal,temporal,parietal,haroad
idxAll.flEloc = frontal;
idxAll.tplEloc = temporal;
idxAll.ptlEloc = parietal;
idxAll.dmnEloc = DMN;
%ad-Ms -- Frontal,basalG,Haroad,Atn
idxAll.flMs = frontal;
idxAll.bgMs = basal_ganglia;
idxAll.haMs = haroad;
idxAll.atnMs = ATN;
region_pad = {'flEloc','tplEloc','ptlEloc','dmnEloc','flMs','bgMs','haMs','atnMs'};
kldAdAll = [results.kld_pms];
p_values = ones(length(kldAdAll),1);
thRange = 2:9;
for i = 1:length(results)
    if results(i).kld_pms<0.0025
        stiFc = results(i).simFC;
        [~,hcEloc,~,mciEloc,~,stimciEloc] = calFcCCandEloc(hcfc,mcifc,stiFc,1);
        hctplE = mean(mean(hcEloc(tpl_idx,:,thRange),3),1)';
        mcTplE = mean(mean(mciEloc(tpl_idx,:,thRange),3),1)';
        stimcitplE = mean(mean(stimciEloc(tpl_idx,:,thRange),3),1)';
        [~,p_mci] = ttest2(hctplE,mcTplE);
        [~,p_stimci] = ttest2(hctplE,stimcitplE);
        if p_mci<0.05 && p_stimci>0.05
            [hcArea8,adArea8,stiadArea8,phcad8,phcstiad8] = getAreaElocOrMs(hcEloc,mciEloc,stimciEloc,hcfc,mcifc,stiFc,region_pad,idxAll);
            stiResPlot_pad(hcArea8,adArea8,stiadArea8,phcad8,phcstiad8,sprintf('%d',i),'MCI',region_pad);
        end
    end
end
savePath='/home/zengmin/model/pms_tianjin_data/b_prisma_moca0105_data/model_results/sti0709_prisma/mcineCandDNew';
figname = 'mcineCandD-all';
saveFig626(savePath,figname);

%% mci-po-CandD
clear all
close all
name = 'p_mcipoCandD';
sect = name;
figure_name = name;
load('mci874_data.mat','mci874_simfc')
load (sprintf('%s.mat',sect),'hc874_simfc','stimulus')
load (sprintf('%s_results.mat',sect));
load ('idx_net6_lobe7.mat','temporal')
tpl_idx = temporal;
%% plot all figs
hcfc = hc874_simfc;
mcifc = mci874_simfc;
load ('idx_net6_lobe7.mat')
%ad-Eloc -- frontal,temporal,parietal,haroad
idxAll.flEloc = frontal;
idxAll.tplEloc = temporal;
idxAll.ptlEloc = parietal;
idxAll.dmnEloc = DMN;
%ad-Ms -- Frontal,basalG,Haroad,Atn
idxAll.flMs = frontal;
idxAll.bgMs = basal_ganglia;
idxAll.haMs = haroad;
idxAll.atnMs = ATN;
region_pad = {'flEloc','tplEloc','ptlEloc','dmnEloc','flMs','bgMs','haMs','atnMs'};
kldAdAll = [results.kld_pms];
p_values = ones(length(kldAdAll),1);
thRange = 2:9;
for i = 1:length(results)
    if results(i).kld_pms<0.0025
        stiFc = results(i).simFC;
        [~,hcEloc,~,mciEloc,~,stimciEloc] = calFcCCandEloc(hcfc,mcifc,stiFc,1);
        hctplE = mean(mean(hcEloc(tpl_idx,:,thRange),3),1)';
        mcTplE = mean(mean(mciEloc(tpl_idx,:,thRange),3),1)';
        stimcitplE = mean(mean(stimciEloc(tpl_idx,:,thRange),3),1)';
        [~,p_mci] = ttest2(hctplE,mcTplE);
        [~,p_stimci] = ttest2(hctplE,stimcitplE);
        if p_mci<0.05 && p_stimci>0.05
            [hcArea8,adArea8,stiadArea8,phcad8,phcstiad8] = getAreaElocOrMs(hcEloc,mciEloc,stimciEloc,hcfc,mcifc,stiFc,region_pad,idxAll);
            stiResPlot_pad(hcArea8,adArea8,stiadArea8,phcad8,phcstiad8,sprintf('%d',i),'MCI',region_pad);
        end
    end
end
savePath='/home/zengmin/model/pms_tianjin_data/b_prisma_moca0105_data/model_results/sti0709_prisma/mcipoCandDNew';
figname = 'mcineCandD-all';
saveFig626(savePath,figname);