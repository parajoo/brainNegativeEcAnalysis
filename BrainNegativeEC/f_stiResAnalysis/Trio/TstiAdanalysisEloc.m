%% trio-Ad-Ne-CandD
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
    load ('idx_net6_lobe7.mat','basal_ganglia')
    basalganlia_idx = basal_ganglia;
    %% plot 8 figures
    load ('idx_net6_lobe7.mat')
    %ad-Eloc -- frontal,temporal,parietal,haroad
    idxAll.ptlEloc = parietal;
    idxAll.bgEloc = basal_ganglia;
    idxAll.aunEloc = AUN;
    idxAll.smnEloc = SMN;
    %ad-Ms -- Frontal,basalG,Haroad,Atn
    idxAll.ftlMs = frontal;
    idxAll.ptlMs = parietal;
    idxAll.tplMs = temporal;
    idxAll.haMs = haroad;
    region_pad = {'ptlEloc','bgEloc','aunEloc','smnEloc','ftlMs','ptlMs','tplMs','haMs'};
    %subtitlesN = {'Frontal','temporal','parietal','Haroad','Frontal','BasalG','Haroad','ATN'};
    kldAdAll = [results.kld_pms];
    p_values = ones(length(kldAdAll),1);
    thRange = 2:9;
    delete(gcp('nocreate'))
    core_use = 15;       % 使用cpu核数?
    c = parpool(core_use);   % 开启并行池
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
                [hcArea8,adArea8,stiadArea8,phcad8,phcstiad8] = getAreaElocOrMs(hcEloc,adEloc,stiadEloc,hcfc,adfc,stiFc,region_pad,idxAll);
                stiResPlot_pad(hcArea8,adArea8,stiadArea8,phcad8,phcstiad8,sprintf('%d',i),'AD',region_pad);
            end
        end
    end
    savePath = '/home/zengmin/model/pms_tianjin_data/trio_scale_622/trioRes0718/adPoCandD';
    figName = 'adPoCandD';
    saveFig626(savePath,figName);
%% trio-Ad-Po-CandD
% clear all
%     close all
%     name = 't_stiAdPoCandD0707';
%     sect = name;
%     figure_name = name;
%     load('ad809_data.mat','ad943_simfc')
%     load (sprintf('%s.mat',sect),'hc895_simfc','stimulus')
%     load (sprintf('%s_results.mat',sect));
%     hcfc = hc895_simfc;
%     adfc = ad943_simfc;
%     load ('idx_net6_lobe7.mat','basal_ganglia')
%     basalganlia_idx = basal_ganglia;
%     %% plot 8 figures
%     load ('idx_net6_lobe7.mat')
%     %ad-Eloc -- frontal,temporal,parietal,haroad
%     idxAll.ptlEloc = parietal;
%     idxAll.bgEloc = basal_ganglia;
%     idxAll.tplEloc = temporal;
%     idxAll.smnEloc = SMN;
%     %ad-Ms -- Frontal,basalG,Haroad,Atn
%     idxAll.ftlMs = frontal;
%     idxAll.tplMs = temporal;
%     idxAll.haMs = haroad;
%     idxAll.dmnMs = DMN;
%     region_pad = {'ptlEloc','bgEloc','tplEloc','smnEloc','ftlMs','tplMs','haMs','dmnMs'};
%     %subtitlesN = {'Frontal','temporal','parietal','Haroad','Frontal','BasalG','Haroad','ATN'};
%     kldAdAll = [results.kld_pms];
%     p_values = ones(length(kldAdAll),1);
%     thRange = 2:9;
%     for i = 1:length(results)
%         if results(i).kld_pms<0.0025
%             stiFc = results(i).simFC;
%             [~,hcEloc,~,adEloc,~,stiadEloc] = calFcCCandEloc(hcfc,adfc,stiFc,1);
%             hcBasalgE = mean(mean(hcEloc(basalganlia_idx,:,thRange),3),1)';
%             adBasalgE = mean(mean(adEloc(basalganlia_idx,:,thRange),3),1)';
%             stiadBasalgE = mean(mean(stiadEloc(basalganlia_idx,:,thRange),3),1)';
%             [~,p_ad] = ttest2(hcBasalgE,adBasalgE);
%             [~,p_stiad] = ttest2(hcBasalgE,stiadBasalgE);
%             if p_ad<0.05 && p_stiad>0.05
%                 [hcArea8,adArea8,stiadArea8,phcad8,phcstiad8] = getAreaElocOrMs(hcEloc,adEloc,stiadEloc,hcfc,adfc,stiFc,region_pad,idxAll);
%                 stiResPlot_pad(hcArea8,adArea8,stiadArea8,phcad8,phcstiad8,sprintf('%d',i),'AD',region_pad);
%             end
%         end
%     end
%     savePath = '/home/zengmin/model/pms_tianjin_data/trio_scale_622/trioRes0707/adPoCandDNew';
%     figName = 'adPoCandDNew';
%     saveFig626(savePath,figName);