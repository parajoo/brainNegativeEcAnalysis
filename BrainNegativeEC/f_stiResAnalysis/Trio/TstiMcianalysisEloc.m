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
load ('idx_net6_lobe7.mat','basal_ganglia')
sun_idx = basal_ganglia;
%% plot 8 figures
load ('idx_net6_lobe7.mat')
%mci-Eloc
idxAll.tplEloc = temporal;
idxAll.bgEloc = basal_ganglia;
idxAll.atnEloc = ATN;
idxAll.sunEloc = SUN;
%mci-Ms
idxAll.tplMs = temporal;
idxAll.bgMs = basal_ganglia;
idxAll.haMs = haroad;
idxAll.sunMs =SUN;


region_pad = {'tplEloc','bgEloc','atnEloc','sunEloc','tplMs','bgMs','haMs','sunMs'};
%kldAdAll = [results.kld_pms];
thRange = 2:9;
delete(gcp('nocreate'))
        core_use = 15;       % 使用cpu核数?
        c = parpool(core_use);   % 开启并行池
for i = 1:length(results)
    if results(i).kld_pms<0.015
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
savePath = '/home/zengmin/model/pms_tianjin_data/trio_scale_622/trioRes0718/mciNeCandD0905';  % 替换为你想保存的路径
saveFig626(savePath,'mciNeCandD')


%% mci-po-CandD
% clear all
% close all
% name = 't_stiMciPoCandD0707';
% sect = name;
% figure_name = name;
% load('mci856_data.mat','mci856_simfc')
% load (sprintf('%s.mat',sect),'hc757_simfc','stimulus')
% hcfc = hc757_simfc;
% mcifc = mci856_simfc;
% load (sprintf('%s_results.mat',sect));
% load ('idx_net6_lobe7.mat','SUN')
% sun_idx = basal_ganglia;
% %% plot 8 figures
% load ('idx_net6_lobe7.mat')
% %mci-Eloc
% idxAll.bgEloc = basal_ganglia;
% idxAll.atnEloc = ATN;
% idxAll.aunEloc = AUN;
% idxAll.sunEloc = SUN;
% %mci-Ms
% idxAll.bgMs = basal_ganglia;
% idxAll.atnMs = ATN;
% idxAll.haMs = haroad;
% idxAll.tplMs = temporal;
% region_pad = {'bgEloc','atnEloc','aunEloc','sunEloc','bsMs','atnMs','haMs','tplMs'};
% %kldAdAll = [results.kld_pms];
% thRange = 2:9;
% for i = 1:length(results)
%     if results(i).kld_pms<0.0025
%         stiFc = results(i).simFC;
%         [~,hcEloc,~,adEloc,~,stiadEloc] = calFcCCandEloc(hcfc,mcifc,stiFc,1);
%         hcSunE = mean(mean(hcEloc(sun_idx,:,thRange),3),1)';
%         adSunE = mean(mean(adEloc(sun_idx,:,thRange),3),1)';
%         stiadSunE = mean(mean(stiadEloc(sun_idx,:,thRange),3),1)';
%         [~,p_ad] = ttest2(hcSunE,adSunE);
%         [~,p_stiad] = ttest2(hcSunE,stiadSunE);
%         if p_ad<0.05 && p_stiad>0.05
%             [hcArea8,adArea8,stiadArea8,phcad8,phcstiad8] = getAreaElocOrMs(hcEloc,adEloc,stiadEloc,hcfc,mcifc,stiFc,region_pad,idxAll);
%             stiResPlot_pad(hcArea8,adArea8,stiadArea8,phcad8,phcstiad8,sprintf('%d',i),'MCI',region_pad);
%         end
%     end
% end
% savePath = '/home/zengmin/model/pms_tianjin_data/trio_scale_622/trioRes0717/mciPoCandDNew';  % 替换为你想保存的路径
% saveFig626(savePath,'mciPoCandD')