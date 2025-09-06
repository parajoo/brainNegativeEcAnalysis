% %% p-ad-ne-C
% clear all
% close all
% name = 'p_adneCnodes';
% sect = name;
% figure_name = name;
% load('ad635_data.mat','ad635_simfc')
% load (sprintf('%s.mat',sect),'hc874_simfc','stimulus','results')
% load ('idx_net6_lobe7.mat','parietal')
% parie_idx = parietal;
% hcfc = hc874_simfc;
% adfc = ad635_simfc;
% % kldAdAll = [results.kld_pms];
% % p_values = ones(length(kldAdAll),1);
% % thRange = 2:9;
% %% idx all figures
% load ('idx_net6_lobe7.mat')
% %ad-Eloc -- frontal,temporal,parietal,haroad
% idxAll.flEloc = frontal;
% idxAll.tplEloc = temporal;
% idxAll.ptlEloc = parietal;
% idxAll.HaEloc = haroad;
% %ad-Ms -- Frontal,basalG,Haroad,Atn
% idxAll.flMs = frontal;
% idxAll.bgMs = basal_ganglia;
% idxAll.haMs = haroad;
% idxAll.atnMs = ATN;
% region_pad = {'flEloc','tplEloc','ptlEloc','HaEloc','flMs','bgMs','haMs','atnMs'};
% kldAdAll = [results.kld_pms];
% p_values = ones(length(kldAdAll),1);
% thRange = 2:9;
% %idxRes = idxCond;
% for i = 1:length(results)
%     if results(i).kld_pms<0.005
%         stiadFc = results(i).simFC;
%         [~,hcEloc,~,adEloc,~,stiadEloc] = calFcCCandEloc(hcfc,adfc,stiadFc,1);
%         hcParieE = mean(mean(hcEloc(parie_idx,:,thRange),3),1)';
%         adParieE = mean(mean(adEloc(parie_idx,:,thRange),3),1)';
%         stiadParieE = mean(mean(stiadEloc(parie_idx,:,thRange),3),1)';
%         [~,p_ad] = ttest2(hcParieE,adParieE);
%         [~,p_stiad] = ttest2(hcParieE,stiadParieE);
%         if p_ad<0.05 && p_stiad>0.05
%             %p_values(i) = p_stiad;
%             %stiResPlot(hcParieE,adParieE,stiadParieE,p_ad,p_stiad,sprintf('p-results%d',i),'AD');
%             [hcArea8,adArea8,stiadArea8,phcad8,phcstiad8] = getAreaElocOrMs(hcEloc,adEloc,stiadEloc,hcfc,adfc,stiadFc,region_pad,idxAll);
%             stiResPlot_pad(hcArea8,adArea8,stiadArea8,phcad8,phcstiad8,sprintf('%d',i),'AD',region_pad);
%         end
%     end
% end
% savePath='/home/zengmin/model/pms_tianjin_data/b_prisma_moca0105_data/model_results/sti0709_prisma/adneC';
% figname = 'adneC';
% saveFig626(savePath,figname);
% 
% %% p-ad-ne-C
% clear all
% close all
% name = 'p_adneDnodes';
% sect = name;
% figure_name = name;
% load('ad635_data.mat','ad635_simfc')
% load (sprintf('%s.mat',sect),'hc874_simfc','stimulus','results')
% load ('idx_net6_lobe7.mat','parietal')
% parie_idx = parietal;
% hcfc = hc874_simfc;
% adfc = ad635_simfc;
% % kldAdAll = [results.kld_pms];
% % p_values = ones(length(kldAdAll),1);
% % thRange = 2:9;
% %% idx all figures
% load ('idx_net6_lobe7.mat')
% %ad-Eloc -- frontal,temporal,parietal,haroad
% idxAll.flEloc = frontal;
% idxAll.tplEloc = temporal;
% idxAll.ptlEloc = parietal;
% idxAll.HaEloc = haroad;
% %ad-Ms -- Frontal,basalG,Haroad,Atn
% idxAll.flMs = frontal;
% idxAll.bgMs = basal_ganglia;
% idxAll.haMs = haroad;
% idxAll.atnMs = ATN;
% region_pad = {'flEloc','tplEloc','ptlEloc','HaEloc','flMs','bgMs','haMs','atnMs'};
% kldAdAll = [results.kld_pms];
% p_values = ones(length(kldAdAll),1);
% thRange = 2:9;
% %idxRes = idxCond;
% for i = 1:length(results)
%     if results(i).kld_pms<0.005
%         stiadFc = results(i).simFC;
%         [~,hcEloc,~,adEloc,~,stiadEloc] = calFcCCandEloc(hcfc,adfc,stiadFc,1);
%         hcParieE = mean(mean(hcEloc(parie_idx,:,thRange),3),1)';
%         adParieE = mean(mean(adEloc(parie_idx,:,thRange),3),1)';
%         stiadParieE = mean(mean(stiadEloc(parie_idx,:,thRange),3),1)';
%         [~,p_ad] = ttest2(hcParieE,adParieE);
%         [~,p_stiad] = ttest2(hcParieE,stiadParieE);
%         if p_ad<0.05 && p_stiad>0.05
%             %p_values(i) = p_stiad;
%             %stiResPlot(hcParieE,adParieE,stiadParieE,p_ad,p_stiad,sprintf('p-results%d',i),'AD');
%             [hcArea8,adArea8,stiadArea8,phcad8,phcstiad8] = getAreaElocOrMs(hcEloc,adEloc,stiadEloc,hcfc,adfc,stiadFc,region_pad,idxAll);
%             stiResPlot_pad(hcArea8,adArea8,stiadArea8,phcad8,phcstiad8,sprintf('%d',i),'AD',region_pad);
%         end
%     end
% end
% savePath='/home/zengmin/model/pms_tianjin_data/b_prisma_moca0105_data/model_results/sti0709_prisma/adneD';
% figname = 'adneD';
% saveFig626(savePath,figname);

%% P-AD-PO-C
clear all
close all
name = 'p_adpoCnodes';
sect = name;
figure_name = name;
load('ad635_data.mat','ad635_simfc')
load (sprintf('%s.mat',sect),'hc874_simfc','stimulus','results')
load ('idx_net6_lobe7.mat','parietal')
parie_idx = parietal;
hcfc = hc874_simfc;
adfc = ad635_simfc;
% kldAdAll = [results.kld_pms];
% p_values = ones(length(kldAdAll),1);
% thRange = 2:9;
%% idx all figures
load ('idx_net6_lobe7.mat')
%ad-Eloc -- frontal,temporal,parietal,haroad
idxAll.flEloc = frontal;
idxAll.tplEloc = temporal;
idxAll.ptlEloc = parietal;
idxAll.HaEloc = haroad;
%ad-Ms -- Frontal,basalG,Haroad,Atn
idxAll.flMs = frontal;
idxAll.bgMs = basal_ganglia;
idxAll.haMs = haroad;
idxAll.atnMs = ATN;
region_pad = {'flEloc','tplEloc','ptlEloc','HaEloc','flMs','bgMs','haMs','atnMs'};
kldAdAll = [results.kld_pms];
p_values = ones(length(kldAdAll),1);
thRange = 2:9;
%idxRes = idxCond;
for i = 1:length(results)
    if results(i).kld_pms<0.0025
        stiadFc = results(i).simFC;
        [~,hcEloc,~,adEloc,~,stiadEloc] = calFcCCandEloc(hcfc,adfc,stiadFc,1);
        hcParieE = mean(mean(hcEloc(parie_idx,:,thRange),3),1)';
        adParieE = mean(mean(adEloc(parie_idx,:,thRange),3),1)';
        stiadParieE = mean(mean(stiadEloc(parie_idx,:,thRange),3),1)';
        [~,p_ad] = ttest2(hcParieE,adParieE);
        [~,p_stiad] = ttest2(hcParieE,stiadParieE);
        if p_ad<0.05 && p_stiad>0.05
            %p_values(i) = p_stiad;
            %stiResPlot(hcParieE,adParieE,stiadParieE,p_ad,p_stiad,sprintf('p-results%d',i),'AD');
            [hcArea8,adArea8,stiadArea8,phcad8,phcstiad8] = getAreaElocOrMs(hcEloc,adEloc,stiadEloc,hcfc,adfc,stiadFc,region_pad,idxAll);
            stiResPlot_pad(hcArea8,adArea8,stiadArea8,phcad8,phcstiad8,sprintf('%d',i),'AD',region_pad);
        end
    end
end
%% idx all figure
savePath='/home/zengmin/model/pms_tianjin_data/b_prisma_moca0105_data/model_results/sti0709_prisma/adpoC';
figname = 'adpoC';
saveFig626(savePath,figname);

%% P-AD-PO-C
clear all
close all
name = 'p_adpoDnodes';
sect = name;
figure_name = name;
load('ad635_data.mat','ad635_simfc')
load (sprintf('%s.mat',sect),'hc874_simfc','stimulus','results')
load ('idx_net6_lobe7.mat','parietal')
parie_idx = parietal;
hcfc = hc874_simfc;
adfc = ad635_simfc;
% kldAdAll = [results.kld_pms];
% p_values = ones(length(kldAdAll),1);
% thRange = 2:9;
%% idx all figures
load ('idx_net6_lobe7.mat')
%ad-Eloc -- frontal,temporal,parietal,haroad
idxAll.flEloc = frontal;
idxAll.tplEloc = temporal;
idxAll.ptlEloc = parietal;
idxAll.HaEloc = haroad;
%ad-Ms -- Frontal,basalG,Haroad,Atn
idxAll.flMs = frontal;
idxAll.bgMs = basal_ganglia;
idxAll.haMs = haroad;
idxAll.atnMs = ATN;
region_pad = {'flEloc','tplEloc','ptlEloc','HaEloc','flMs','bgMs','haMs','atnMs'};
kldAdAll = [results.kld_pms];
p_values = ones(length(kldAdAll),1);
thRange = 2:9;
%idxRes = idxCond;
for i = 1:length(results)
    if results(i).kld_pms<0.0025
        stiadFc = results(i).simFC;
        [~,hcEloc,~,adEloc,~,stiadEloc] = calFcCCandEloc(hcfc,adfc,stiadFc,1);
        hcParieE = mean(mean(hcEloc(parie_idx,:,thRange),3),1)';
        adParieE = mean(mean(adEloc(parie_idx,:,thRange),3),1)';
        stiadParieE = mean(mean(stiadEloc(parie_idx,:,thRange),3),1)';
        [~,p_ad] = ttest2(hcParieE,adParieE);
        [~,p_stiad] = ttest2(hcParieE,stiadParieE);
        if p_ad<0.05 && p_stiad>0.05
            %p_values(i) = p_stiad;
            %stiResPlot(hcParieE,adParieE,stiadParieE,p_ad,p_stiad,sprintf('p-results%d',i),'AD');
            [hcArea8,adArea8,stiadArea8,phcad8,phcstiad8] = getAreaElocOrMs(hcEloc,adEloc,stiadEloc,hcfc,adfc,stiadFc,region_pad,idxAll);
            stiResPlot_pad(hcArea8,adArea8,stiadArea8,phcad8,phcstiad8,sprintf('%d',i),'AD',region_pad);
        end
    end
end
%% idx all figure
savePath='/home/zengmin/model/pms_tianjin_data/b_prisma_moca0105_data/model_results/sti0709_prisma/adpoD';
figname = 'adpoD';
saveFig626(savePath,figname);