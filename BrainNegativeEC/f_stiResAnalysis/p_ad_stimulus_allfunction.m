%% prisma-
% ad-po-coupling
clear all
close all
load ('pEcSdi.mat','adPoEcSdi')
[~,adpoCnodes] = mink(adPoEcSdi,10);
P_sim_ad_stimulus_set_area(adpoCnodes,'p_adpoCnodes')
% ad-po-decoupling
clear all
close all
load ('pEcSdi.mat','adPoEcSdi')
[~,adpoDnodes] = maxk(adPoEcSdi,10);
P_sim_ad_stimulus_set_area(adpoDnodes,'p_adpoDnodes')
% ad-ne-coupling
clear all
close all
load ('pEcSdi.mat','adNeEcSdi')
[~,adneCnodes] = mink(adNeEcSdi,10);
P_sim_ad_stimulus_set_area(adneCnodes,'p_adneCnodes')
% ad-ne-decoupling
clear all
close all
load ('pEcSdi.mat','adNeEcSdi')
[~,adneDnodes] = maxk(adNeEcSdi,10);
P_sim_ad_stimulus_set_area(adneDnodes,'p_adneDnodes')
% ad-nepo-coupling
clear all
close all
load ('pEcSdi.mat','adNeEcSdi','adPoEcSdi')
[~,adneCnodes] = mink(adNeEcSdi,10);
[~,adpoCnodes] = mink(adPoEcSdi,10);
adnepoc = [adpoCnodes,adneCnodes];
adnepoC = unique(adnepoc);
P_sim_ad_stimulus_set_area(adnepoC,'p_adnepoCnodes')
% ad-nepo-decoupling
clear all
close all
load ('pEcSdi.mat','adNeEcSdi','adPoEcSdi')
[~,adneCnodes] = maxk(adNeEcSdi,10);
[~,adpoCnodes] = maxk(adPoEcSdi,10);
adnepoc = [adpoCnodes,adneCnodes];
adnepoC = unique(adnepoc);
P_sim_ad_stimulus_set_area(adnepoC,'p_adnepoDnodes')
%% ad-po-coupling-decoupling brain areas-10*2nodes
clear all
close all
load ('pEcSdi.mat','adPoEcSdi')
[~,ad_min10_node] = mink(adPoEcSdi,10);
[~,ad_max10_node] = maxk(adPoEcSdi,10);
sti_ad_po_coupling = ad_min10_node;
stiCoupling = -0.01:0.001:0.01;
sti_ad_po_decoupling = ad_max10_node;
stiDecoupling = -0.01:0.001:0.01;
P_sim_ad_stimulus_set_areadouble_if(sti_ad_po_coupling,stiCoupling,sti_ad_po_decoupling,stiDecoupling,'p_adpoCandD')

%% ad-ne-coupling-decoupling brain areas-10*2nodes
clear all
close all
load ('pEcSdi.mat','adNeEcSdi')
[~,ad_min10_node] = mink(adNeEcSdi,10);
[~,ad_max10_node] = maxk(adNeEcSdi,10);
sti_ad_ne_coupling = ad_min10_node;
stiCoupling = -0.01:0.001:0.01;
sti_ad_ne_decoupling = ad_max10_node;
stiDecoupling = -0.01:0.001:0.01;
P_sim_ad_stimulus_set_areadouble_if(sti_ad_ne_coupling,stiCoupling,sti_ad_ne_decoupling,stiDecoupling,'p_adneCandD')
