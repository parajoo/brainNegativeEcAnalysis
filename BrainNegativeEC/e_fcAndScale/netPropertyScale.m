%% 90*90*subn
% clear all
% close all
% % 1.calculate network property(each brain area corresponds to a value)
% load tGroup3Fc_scale0905.mat
% [emphc_netC,emphc_netE,empmci_netC,empmci_netE,empad_netC,empad_netE] = cal_net_simfc(trioHcFc,trioMciFc,trioAdFc);
% 2.extract value of brain lobes or sub-network(Eloc/CC/meanS)
%% Moca-Ms
%% lobeCC
% load PTmoca.mat
% hcScale = pthcMoca;
% mciScale = ptmciMoca;
% adScale = ptadMoca;
% adScale(36,:) = [];
% scaleIdx = 1;
% load ptGroup3Fc0707.mat
% hcfc = ptHcFc0707;
% mcifc = ptMciFc0707;
% adfc = ptAdFc0707;
% adfc(:,:,36) = [];
% [emphcLobeMs,empmciLobeMs,empadLobeMs] = plot_subarea_glocal_meanss(hcfc,mcifc,adfc,7,0);
% % 3.calculate correlation bewteen indicators and scale
% % hcIndicator,ad/mciIndicator,hcScale,ad/mciScale,scaleIdx,hcNumScale,ad/mciNumScale,hcNumAll,areaIdx,figname,groupname
% plot_netproperty_score(emphcLobeMs,empadLobeMs,63,hcScale,adScale,scaleIdx,7,'lobeMs','AD')
% saveFig626('/home/zengmin/model/pms_tianjin_data/trio_scale_622/resultsFig/mocaAndIndValue/MeanS0707','lobeMs-Moca(AD)')
% close all
% plot_netproperty_score(emphcLobeMs,empmciLobeMs,63,hcScale,mciScale,scaleIdx,7,'lobeMs','MCI')
% saveFig626('/home/zengmin/model/pms_tianjin_data/trio_scale_622/resultsFig/mocaAndIndValue/MeanS0707','lobeMs-Moca(MCI)')
% %% netCC
% close all
% [emphcNetMs,empmciNetMs,empadNetMs] = plot_subarea_glocal_meanss(hcfc,mcifc,adfc,6,0);
% % 3.calculate correlation bewteen indicators and scale
% % hcIndicator,ad/mciIndicator,hcScale,ad/mciScale,scaleIdx,hcNumScale,ad/mciNumScale,hcNumAll,areaIdx,figname,groupname
% plot_netproperty_score(emphcNetMs,empadNetMs,63,hcScale,adScale,scaleIdx,6,'netMs','AD')
% saveFig626('/home/zengmin/model/pms_tianjin_data/trio_scale_622/resultsFig/mocaAndIndValue/MeanS0707','netMs-Moca(AD)')
% close all
% plot_netproperty_score(emphcNetMs,empmciNetMs,63,hcScale,mciScale,scaleIdx,6,'netMs','MCI')
% saveFig626('/home/zengmin/model/pms_tianjin_data/trio_scale_622/resultsFig/mocaAndIndValue/MeanS0707','netMs-Moca(MCI)')
% %% Mmse-Ms
clear all
close all
load ('tGroup3Fc_scale0905.mat')
clear tHcFc tMciFc tAdFc
hcScale = hc_moca;
mciScale = mci_moca;
adScale = ad_moca;
scaleIdx = 1;%0:MMSE 1:MOCA
hcSubAll = 43;
load t_subArea_CCandEloc0905.mat
%adfc(:,:,36) = [];
% 3.calculate correlation bewteen indicators and scale
%hcIndicator,ad/mciIndicator,hcScale,ad/mciScale,scaleIdx,hcNumScale,ad/mciNumScale,hcNumAll,areaIdx,figname,groupname
% plot_netproperty_score(hcNetC,adNetC,hcSubAll,hcScale,adScale,scaleIdx,6,'NetC','AD')
% saveFig626('/home/zengmin/model/pms_tianjin_data/trioScaleAndInx/mocaAndIndValue/CC0905','NetC-Moca(AD)')
% close all
% plot_netproperty_score(hcNetC,mciNetC,hcSubAll,hcScale,mciScale,scaleIdx,6,'NetC','MCI')
% saveFig626('/home/zengmin/model/pms_tianjin_data/trioScaleAndInx/mocaAndIndValue/CC0905','NetC-Moca(MCI)')
% close all
%% lobe
% hcIndicator,ad/mciIndicator,hcScale,ad/mciScale,scaleIdx,hcNumScale,ad/mciNumScale,hcNumAll,areaIdx,figname,groupname
plot_netproperty_score(hcLobeC,adLobeC,hcSubAll,hcScale,adScale,scaleIdx,7,'lobeC','AD')
saveFig626('/home/zengmin/model/pms_tianjin_data/trioScaleAndInx/mocaAndIndValue/CC0905','lobeC-Moca(AD)')
close all
plot_netproperty_score(hcLobeC,mciLobeC,hcSubAll,hcScale,mciScale,scaleIdx,7,'lobeC','MCI')
saveFig626('/home/zengmin/model/pms_tianjin_data/trioScaleAndInx/mocaAndIndValue/CC0905','lobeC-Moca(MCI)')
close all


%% CC and Eloc
% clear all
% close all
% load ptGroup3_CCandE0707.mat
% %load PTmmse0707.mat
% load PTmoca0707.mat
% hcScale = pthcMoca;
% mciScale = ptmciMoca;
% adScale = ptadMoca;
% scaleIdx = 1;
% hcIdx = hcNetE;
% mciIdx = mciNetE;
% adIdx = adNetE;
% s1 = 'moca';
% s2 = 'Eloc0707';
% s3 = 'Eloc';
% s4 = 'Moca';
% % 3.calculate correlation bewteen indicators and scale
% % hcIndicator,ad/mciIndicator,hcScale,ad/mciScale,scaleIdx,hcNumScale,ad/mciNumScale,hcNumAll,areaIdx,figname,groupname
% plot_netproperty_score(hcIdx,adIdx,63,hcScale,adScale,scaleIdx,6,sprintf('Net%s',s3),'AD')
% saveFig626(sprintf('/home/zengmin/model/pms_tianjin_data/trio_scale_622/resultsFig/%sAndIndValue/%s',s1,s2),sprintf('Net%s-%s(AD)',s3,s4));
% close all
% plot_netproperty_score(hcIdx,mciIdx,63,hcScale,mciScale,scaleIdx,6,sprintf('Net%s',s3),'MCI')
% saveFig626(sprintf('/home/zengmin/model/pms_tianjin_data/trio_scale_622/resultsFig/%sAndIndValue/%s',s1,s2),sprintf('Net%s-%s(MCI)',s3,s4));
% 
% %% lobeMs
% close all
% hcIdx1 = hcLobeE;
% mciIdx1 = mciLobeE;
% adIdx1 = adLobeE;
% % 3.calculate correlation bewteen indicators and scale
% % hcIndicator,ad/mciIndicator,hcSubAll,hcScale,ad/mciScale,scaleIdx,areaIdx,figname,groupname
% plot_netproperty_score(hcIdx1,adIdx1,63,hcScale,adScale,scaleIdx,7,sprintf('Lobe%s',s3),'AD')
% saveFig626(sprintf('/home/zengmin/model/pms_tianjin_data/trio_scale_622/resultsFig/%sAndIndValue/%s',s1,s2),sprintf('Lobe%s-%s(AD)',s3,s4));
% close all
% plot_netproperty_score(hcIdx1,mciIdx1,63,hcScale,mciScale,scaleIdx,7,sprintf('Lobe%s',s3),'MCI')
% saveFig626(sprintf('/home/zengmin/model/pms_tianjin_data/trio_scale_622/resultsFig/%sAndIndValue/%s',s1,s2),sprintf('Lobe%s-%s(MCI)',s3,s4));
% 
