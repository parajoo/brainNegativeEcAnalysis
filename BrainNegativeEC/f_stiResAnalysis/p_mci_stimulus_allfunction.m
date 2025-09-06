%% prisma-
% ad-po-coupling
clear all
close all
load ('pEcSdi.mat','mciPoEcSdi')
[~,mcipoCnodes] = mink(mciPoEcSdi,10);
P_sim_mci_stimulus_set_area(mcipoCnodes,'p_mcipoCnodes')
% ad-po-decoupling
clear all
close all
load ('pEcSdi.mat','mciPoEcSdi')
[~,mcipoDnodes] = maxk(mciPoEcSdi,10);
P_sim_mci_stimulus_set_area(mcipoDnodes,'p_mcipoDnodes')
% ad-ne-coupling
clear all
close all
load ('pEcSdi.mat','mciNeEcSdi')
[~,mcineCnodes] = mink(mciNeEcSdi,10);
P_sim_mci_stimulus_set_area(mcineCnodes,'p_mcineCnodes')
% ad-ne-decoupling
clear all
close all
load ('pEcSdi.mat','mciNeEcSdi')
[~,mcineDnodes] = maxk(mciNeEcSdi,10);
P_sim_mci_stimulus_set_area(mcineDnodes,'p_mcineDnodes')
% ad-nepo-coupling
clear all
close all
load ('pEcSdi.mat','mciNeEcSdi','mciPoEcSdi')
[~,mcineCnodes] = mink(mciNeEcSdi,10);
[~,mcipoCnodes] = mink(mciPoEcSdi,10);
mcinepoc = [mcipoCnodes,mcineCnodes];
mcinepoC = unique(mcinepoc);
P_sim_mci_stimulus_set_area(mcinepoC,'p_mcinepoCnodes')
% ad-nepo-decoupling
clear all
close all
load ('pEcSdi.mat','mciNeEcSdi','mciPoEcSdi')
[~,mcineCnodes] = maxk(mciNeEcSdi,10);
[~,mcipoCnodes] = maxk(mciPoEcSdi,10);
mcinepoc = [mcipoCnodes,mcineCnodes];
mcinepoC = unique(mcinepoc);
P_sim_mci_stimulus_set_area(mcinepoC,'p_mcinepoDnodes')
%% ad-po-coupling-decoupling brain areas-10*2nodes
clear all
close all
load ('pEcSdi.mat','mciPoEcSdi')
[~,mci_min10_node] = mink(mciPoEcSdi,10);
[~,mci_max10_node] = maxk(mciPoEcSdi,10);
sti_mci_po_coupling = mci_min10_node;
stiCoupling = -0.01:0.001:0.01;
sti_mci_po_decoupling = mci_max10_node;
stiDecoupling = -0.01:0.001:0.01;
P_sim_mci_stimulus_set_areadouble(sti_mci_po_coupling,stiCoupling,sti_mci_po_decoupling,stiDecoupling,'p_mcipoCandD')

%% ad-ne-coupling-decoupling brain areas-10*2nodes
clear all
close all
load ('pEcSdi.mat','mciNeEcSdi')
[~,mci_min10_node] = mink(mciNeEcSdi,10);
[~,mci_max10_node] = maxk(mciNeEcSdi,10);
sti_ad_ne_coupling = mci_min10_node;
stiCoupling = -0.01:0.001:0.01;
sti_mci_ne_decoupling = mci_max10_node;
stiDecoupling = -0.01:0.001:0.01;
P_sim_mci_stimulus_set_areadouble(sti_ad_ne_coupling,stiCoupling,sti_mci_ne_decoupling,stiDecoupling,'p_mcineCandD')
