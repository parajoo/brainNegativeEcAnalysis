%% sti-mci-ne-C
clear all
close all
name = 't_stiMciNeC0707';
sect = name;
figure_name = name;
load('mci856_data.mat','mci856_simfc')
load (sprintf('%s.mat',sect),'hc757_simfc','stimulus','results')
hcfc = hc757_simfc;
mcifc = mci856_simfc;
%load (sprintf('%s_results.mat',sect));
load ('idx_net6_lobe7.mat','SUN')
sun_idx = SUN;
%% plot 8 figures
load ('idx_net6_lobe7.mat')
%ad-Eloc -- frontal,temporal,parietal,haroad
idxAll.tplEloc = temporal;
idxAll.bgEloc = basal_ganglia;
idxAll.sunEloc = SUN;
idxAll.aunEloc = AUN;
%ad-Ms -- Frontal,basalG,Haroad,Atn
idxAll.tplMs = temporal;
idxAll.bgMs = basal_ganglia;
idxAll.haMs = haroad;
idxAll.sunMs = SUN;
region_pad = {'tplEloc','bgEloc','sunEloc','aunEloc','tplMs','bgMs','haMs','sunMs'};
%kldAdAll = [results.kld_pms];
thRange = 2:9;
for i = 1:length(results)
    if results(i).kld_pms<0.0025
        stiFc = results(i).simFC;
        [~,hcEloc,~,adEloc,~,stiadEloc] = calFcCCandEloc(hcfc,mcifc,stiFc,1);
        hcSunE = mean(mean(hcEloc(sun_idx,:,thRange),3),1)';
        adSunE = mean(mean(adEloc(sun_idx,:,thRange),3),1)';
        stiadSunE = mean(mean(stiadEloc(sun_idx,:,thRange),3),1)';
        [~,p_ad] = ttest2(hcSunE,adSunE);
        [~,p_stiad] = ttest2(hcSunE,stiadSunE);
        if p_ad<0.05 && p_stiad>0.05
            [hcArea8,adArea8,stiadArea8,phcad8,phcstiad8] = getAreaElocOrMs(hcEloc,adEloc,stiadEloc,hcfc,mcifc,stiFc,region_pad,idxAll);
            stiResPlot_pad(hcArea8,adArea8,stiadArea8,phcad8,phcstiad8,sprintf('%d',i),'MCI',region_pad);
        end
    end
end
savePath = '/home/zengmin/model/pms_tianjin_data/trio_scale_622/trioRes0707/MCI/mciNeC';  % 替换为你想保存的路径
saveFig626(savePath,'mciNeC')
%% sti-mci-Po-CandD
clear all
close all
name = 't_stiMciNeD0707';
sect = name;
figure_name = name;
load('mci856_data.mat','mci856_simfc')
load (sprintf('%s.mat',sect),'hc757_simfc','stimulus','results')
hcfc = hc757_simfc;
mcifc = mci856_simfc;
%load (sprintf('%s_results.mat',sect));
load ('idx_net6_lobe7.mat','SUN')
sun_idx = SUN;
%% plot 8 figures
load ('idx_net6_lobe7.mat')
%ad-Eloc -- frontal,temporal,parietal,haroad
idxAll.tplEloc = temporal;
idxAll.bgEloc = basal_ganglia;
idxAll.sunEloc = SUN;
idxAll.aunEloc = AUN;
%ad-Ms -- Frontal,basalG,Haroad,Atn
idxAll.tplMs = temporal;
idxAll.bgMs = basal_ganglia;
idxAll.haMs = haroad;
idxAll.sunMs = SUN;
region_pad = {'tplEloc','bgEloc','sunEloc','aunEloc','tplMs','bgMs','haMs','sunMs'};
%kldAdAll = [results.kld_pms];
thRange = 2:9;
for i = 1:length(results)
    if results(i).kld_pms<0.0025
        stiFc = results(i).simFC;
        [~,hcEloc,~,adEloc,~,stiadEloc] = calFcCCandEloc(hcfc,mcifc,stiFc,1);
        hcSunE = mean(mean(hcEloc(sun_idx,:,thRange),3),1)';
        adSunE = mean(mean(adEloc(sun_idx,:,thRange),3),1)';
        stiadSunE = mean(mean(stiadEloc(sun_idx,:,thRange),3),1)';
        [~,p_ad] = ttest2(hcSunE,adSunE);
        [~,p_stiad] = ttest2(hcSunE,stiadSunE);
        if p_ad<0.05 && p_stiad>0.05
            [hcArea8,adArea8,stiadArea8,phcad8,phcstiad8] = getAreaElocOrMs(hcEloc,adEloc,stiadEloc,hcfc,mcifc,stiFc,region_pad,idxAll);
            stiResPlot_pad(hcArea8,adArea8,stiadArea8,phcad8,phcstiad8,sprintf('%d',i),'MCI',region_pad);
        end
    end
end
savePath = '/home/zengmin/model/pms_tianjin_data/trio_scale_622/trioRes0707/MCI/mciNeD';  % 替换为你想保存的路径
saveFig626(savePath,'mciNeD')

%% mci-po-C
clear all
close all
name = 't_stiMciPoC0707';
sect = name;
figure_name = name;
load('mci856_data.mat','mci856_simfc')
load (sprintf('%s.mat',sect),'hc757_simfc','stimulus','results')
hcfc = hc757_simfc;
mcifc = mci856_simfc;
%load (sprintf('%s_results.mat',sect));
load ('idx_net6_lobe7.mat','SUN')
sun_idx = SUN;
%% plot 8 figures
load ('idx_net6_lobe7.mat')
%ad-Eloc -- frontal,temporal,parietal,haroad
idxAll.tplEloc = temporal;
idxAll.bgEloc = basal_ganglia;
idxAll.sunEloc = SUN;
idxAll.aunEloc = AUN;
%ad-Ms -- Frontal,basalG,Haroad,Atn
idxAll.tplMs = temporal;
idxAll.bgMs = basal_ganglia;
idxAll.haMs = haroad;
idxAll.sunMs = SUN;
region_pad = {'tplEloc','bgEloc','sunEloc','aunEloc','tplMs','bgMs','haMs','sunMs'};
%kldAdAll = [results.kld_pms];
thRange = 2:9;
for i = 1:length(results)
    if results(i).kld_pms<0.0025
        stiFc = results(i).simFC;
        [~,hcEloc,~,adEloc,~,stiadEloc] = calFcCCandEloc(hcfc,mcifc,stiFc,1);
        hcSunE = mean(mean(hcEloc(sun_idx,:,thRange),3),1)';
        adSunE = mean(mean(adEloc(sun_idx,:,thRange),3),1)';
        stiadSunE = mean(mean(stiadEloc(sun_idx,:,thRange),3),1)';
        [~,p_ad] = ttest2(hcSunE,adSunE);
        [~,p_stiad] = ttest2(hcSunE,stiadSunE);
        if p_ad<0.05 && p_stiad>0.05
            [hcArea8,adArea8,stiadArea8,phcad8,phcstiad8] = getAreaElocOrMs(hcEloc,adEloc,stiadEloc,hcfc,mcifc,stiFc,region_pad,idxAll);
            stiResPlot_pad(hcArea8,adArea8,stiadArea8,phcad8,phcstiad8,sprintf('%d',i),'MCI',region_pad);
        end
    end
end
savePath = '/home/zengmin/model/pms_tianjin_data/trio_scale_622/trioRes0707/MCI/mciPoC';  % 替换为你想保存的路径
saveFig626(savePath,'mciPoC')
%% trio - po- D
clear all
close all
name = 't_stiMciPoD0707';
sect = name;
figure_name = name;
load('mci856_data.mat','mci856_simfc')
load (sprintf('%s.mat',sect),'hc757_simfc','stimulus','results')
hcfc = hc757_simfc;
mcifc = mci856_simfc;
%load (sprintf('%s_results.mat',sect));
load ('idx_net6_lobe7.mat','SUN')
sun_idx = SUN;
%% plot 8 figures
load ('idx_net6_lobe7.mat')
%ad-Eloc -- frontal,temporal,parietal,haroad
idxAll.tplEloc = temporal;
idxAll.bgEloc = basal_ganglia;
idxAll.sunEloc = SUN;
idxAll.aunEloc = AUN;
%ad-Ms -- Frontal,basalG,Haroad,Atn
idxAll.tplMs = temporal;
idxAll.bgMs = basal_ganglia;
idxAll.haMs = haroad;
idxAll.sunMs = SUN;
region_pad = {'tplEloc','bgEloc','sunEloc','aunEloc','tplMs','bgMs','haMs','sunMs'};
%kldAdAll = [results.kld_pms];
thRange = 2:9;
for i = 1:length(results)
    if results(i).kld_pms<0.0025
        stiFc = results(i).simFC;
        [~,hcEloc,~,adEloc,~,stiadEloc] = calFcCCandEloc(hcfc,mcifc,stiFc,1);
        hcSunE = mean(mean(hcEloc(sun_idx,:,thRange),3),1)';
        adSunE = mean(mean(adEloc(sun_idx,:,thRange),3),1)';
        stiadSunE = mean(mean(stiadEloc(sun_idx,:,thRange),3),1)';
        [~,p_ad] = ttest2(hcSunE,adSunE);
        [~,p_stiad] = ttest2(hcSunE,stiadSunE);
        if p_ad<0.05 && p_stiad>0.05
            [hcArea8,adArea8,stiadArea8,phcad8,phcstiad8] = getAreaElocOrMs(hcEloc,adEloc,stiadEloc,hcfc,mcifc,stiFc,region_pad,idxAll);
            stiResPlot_pad(hcArea8,adArea8,stiadArea8,phcad8,phcstiad8,sprintf('%d',i),'MCI',region_pad);
        end
    end
end
savePath = '/home/zengmin/model/pms_tianjin_data/trio_scale_622/trioRes0707/MCI/mciPoD';  % 替换为你想保存的路径
saveFig626(savePath,'mciPoD')