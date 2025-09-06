%% trio-Ad-Ne-C
    clear all
    close all
    name = 't_stiAdNeC0707';
    sect = name;
    figure_name = name;
    load('ad809_data.mat','ad809_simfc')
    load (sprintf('%s.mat',sect),'hc757_simfc','stimulus','results')
    hcfc = hc757_simfc;
    adfc = ad809_simfc;
    load ('idx_net6_lobe7.mat','basal_ganglia')
    basalganlia_idx = basal_ganglia;
    %% plot 8 figures
    load ('idx_net6_lobe7.mat')
    %ad-Eloc -- frontal,temporal,parietal,haroad
    idxAll.ptlEloc = parietal;
    idxAll.bgEloc = basal_ganglia;
    idxAll.tplEloc = temporal;
    idxAll.smnEloc = SMN;
    %ad-Ms -- Frontal,basalG,Haroad,Atn
    idxAll.ftlMs = frontal;
    idxAll.tplMs = temporal;
    idxAll.haMs = haroad;
    idxAll.dmnMs = DMN;
    region_pad = {'ptlEloc','bgEloc','tplEloc','smnEloc','ftlMs','tplMs','haMs','dmnMs'};
    %subtitlesN = {'Frontal','temporal','parietal','Haroad','Frontal','BasalG','Haroad','ATN'};
    kldAdAll = [results.kld_pms];
    p_values = ones(length(kldAdAll),1);
    thRange = 2:9;
    for i = 1:length(results)
        if results(i).kld_pms<0.0025
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
    savePath = '/home/zengmin/model/pms_tianjin_data/trio_scale_622/trioRes0707/adNeC';
    figName = 'adNeC';
    saveFig626(savePath,figName);

%% trio-Ad-Ne-D
    clear all
    close all
    name = 't_stiAdNeD0707';
    sect = name;
    figure_name = name;
    load('ad809_data.mat','ad809_simfc')
    load (sprintf('%s.mat',sect),'hc757_simfc','stimulus','results')
    hcfc = hc757_simfc;
    adfc = ad809_simfc;
    load ('idx_net6_lobe7.mat','basal_ganglia')
    basalganlia_idx = basal_ganglia;
    %% plot 8 figures
    load ('idx_net6_lobe7.mat')
    %ad-Eloc -- frontal,temporal,parietal,haroad
    idxAll.ptlEloc = parietal;
    idxAll.bgEloc = basal_ganglia;
    idxAll.tplEloc = temporal;
    idxAll.smnEloc = SMN;
    %ad-Ms -- Frontal,basalG,Haroad,Atn
    idxAll.ftlMs = frontal;
    idxAll.tplMs = temporal;
    idxAll.haMs = haroad;
    idxAll.dmnMs = DMN;
    region_pad = {'ptlEloc','bgEloc','tplEloc','smnEloc','ftlMs','tplMs','haMs','dmnMs'};
    %subtitlesN = {'Frontal','temporal','parietal','Haroad','Frontal','BasalG','Haroad','ATN'};
    kldAdAll = [results.kld_pms];
    p_values = ones(length(kldAdAll),1);
    thRange = 2:9;
    for i = 1:length(results)
        if results(i).kld_pms<0.0025
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
    savePath = '/home/zengmin/model/pms_tianjin_data/trio_scale_622/trioRes0707/adNeD';
    figName = 'adNeD';
    saveFig626(savePath,figName);
%% trio-Ad-Po-C
clear all
    close all
    name = 't_stiAdPoC0707';
    sect = name;
    figure_name = name;
    load('ad809_data.mat','ad809_simfc')
    load (sprintf('%s.mat',sect),'hc757_simfc','stimulus','results')
    hcfc = hc757_simfc;
    adfc = ad809_simfc;
    load ('idx_net6_lobe7.mat','basal_ganglia')
    basalganlia_idx = basal_ganglia;
    %% plot 8 figures
    load ('idx_net6_lobe7.mat')
    %ad-Eloc -- frontal,temporal,parietal,haroad
    idxAll.ptlEloc = parietal;
    idxAll.bgEloc = basal_ganglia;
    idxAll.tplEloc = temporal;
    idxAll.smnEloc = SMN;
    %ad-Ms -- Frontal,basalG,Haroad,Atn
    idxAll.ftlMs = frontal;
    idxAll.tplMs = temporal;
    idxAll.haMs = haroad;
    idxAll.dmnMs = DMN;
    region_pad = {'ptlEloc','bgEloc','tplEloc','smnEloc','ftlMs','tplMs','haMs','dmnMs'};
    %subtitlesN = {'Frontal','temporal','parietal','Haroad','Frontal','BasalG','Haroad','ATN'};
    kldAdAll = [results.kld_pms];
    p_values = ones(length(kldAdAll),1);
    thRange = 2:9;
    for i = 1:length(results)
        if results(i).kld_pms<0.0025
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
    savePath = '/home/zengmin/model/pms_tianjin_data/trio_scale_622/trioRes0707/adPoC';
    figName = 'adPoC';
    saveFig626(savePath,figName);


    %% trio-Ad-Po-D
clear all
    close all
    name = 't_stiAdPoD0707';
    sect = name;
    figure_name = name;
    load('ad809_data.mat','ad809_simfc')
    load (sprintf('%s.mat',sect),'hc757_simfc','stimulus','results')
    hcfc = hc757_simfc;
    adfc = ad809_simfc;
    load ('idx_net6_lobe7.mat','basal_ganglia')
    basalganlia_idx = basal_ganglia;
    %% plot 8 figures
    load ('idx_net6_lobe7.mat')
    %ad-Eloc -- frontal,temporal,parietal,haroad
    idxAll.ptlEloc = parietal;
    idxAll.bgEloc = basal_ganglia;
    idxAll.tplEloc = temporal;
    idxAll.smnEloc = SMN;
    %ad-Ms -- Frontal,basalG,Haroad,Atn
    idxAll.ftlMs = frontal;
    idxAll.tplMs = temporal;
    idxAll.haMs = haroad;
    idxAll.dmnMs = DMN;
    region_pad = {'ptlEloc','bgEloc','tplEloc','smnEloc','ftlMs','tplMs','haMs','dmnMs'};
    %subtitlesN = {'Frontal','temporal','parietal','Haroad','Frontal','BasalG','Haroad','ATN'};
    kldAdAll = [results.kld_pms];
    p_values = ones(length(kldAdAll),1);
    thRange = 2:9;
    for i = 1:length(results)
        if results(i).kld_pms<0.0025
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
    savePath = '/home/zengmin/model/pms_tianjin_data/trio_scale_622/trioRes0707/adPoD';
    figName = 'adPoD';
    saveFig626(savePath,figName);