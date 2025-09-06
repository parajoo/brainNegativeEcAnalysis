%% trio-Stimuli-Code
%ad-ne-coupling
clear all
close all
load('trioSdi0718.mat','adNeSdi')
[~,sti_area] = mink(adNeSdi,10);
TAdStiSetArea(sti_area,'t_stiAdNeC0718')
%ad-ne-decoupling
clear all
close all
load('trioSdi0718.mat','adNeSdi')
[~,sti_area] = maxk(adNeSdi,10);
TAdStiSetArea(sti_area,'t_stiAdNeD0718')
%ad-po-coupling
clear all
close all
load('trioSdi0718.mat','adPoSdi')
[~,sti_area] = mink(adPoSdi,10);
TAdStiSetArea(sti_area,'t_stiAdPoC0718')
%ad-po-decoupling
clear all
close all
load('trioSdi0718.mat','adPoSdi')
[~,sti_area] = maxk(adPoSdi,10);
TAdStiSetArea(sti_area,'t_stiAdPoD0718')
%ad po+ne Coupling
clear all
close all
load('trioSdi0718.mat','adNeSdi','adPoSdi')
[~,poCnode] = mink(adNeSdi,10);
[~,neCnode] = mink(adPoSdi,10);
CnodeAll = [poCnode;neCnode];
sti_area = unique(CnodeAll);
TAdStiSetArea(sti_area,'t_stiAdPoNeC0718')
% ad po+ne Decoupling
clear all
close all
load('trioSdi0718.mat','adNeSdi','adPoSdi')
[~,poDnode] = maxk(adNeSdi,10);
[~,neDnode] = maxk(adPoSdi,10);
DnodeAll = [poDnode;neDnode];
sti_area = unique(DnodeAll);
TAdStiSetArea(sti_area,'t_stiAdPoNeD0718')

% ad ne CandD
clear all
close all
load('trioSdi0718.mat','adNeSdi')
[~,poCnodes] = mink(adNeSdi,10);
[~,poDnodes] = maxk(adNeSdi,10);
TAdStiSetAreadouble_test(poCnodes,poDnodes,'t_stiAdNeCandD0718')
%% ad po CandD
clear all
close all
load('trioSdi0718.mat','adPoSdi')
[~,poCnodesNew] = mink(adPoSdi,10);
[~,poDnodesNew] = maxk(adPoSdi,10);
TAdStiSetAreadouble_test(poCnodes,poDnodes,'t_stiAdPoCandD0718')

%% ad-ne-coupling-decoupling brain areas
% clear all
% close all
% load sdi_ad_ec_sc.mat
% [ad_min10_value,ad_min10_node] = mink(ad_neec_sdi,10);
% [ad_max10_value,ad_max10_node] = maxk(ad_neec_sdi,10);
% sti_ad_ne_coupling = ad_min10_node;
% sti_ad_ne_decoupling = ad_max10_node;
% P_sim_ad_stimulus_set_areadouble(sti_ad_ne_coupling,sti_ad_ne_decoupling,'sti_ad_ne_areadouble')

%% ad-po-coupling-decoupling brain areas-10*2nodes
% clear all
% close all
% load sdi_ad_ec_sc.mat
% [ad_min10_value,ad_min10_node] = mink(ad_poec_sdi,10);
% [ad_max10_value,ad_max10_node] = maxk(ad_poec_sdi,10);
% sti_ad_po_coupling = ad_min10_node;
% sti_ad_po_decoupling = ad_max10_node;
% P_sim_ad_stimulus_set_areadouble(sti_ad_po_coupling,sti_ad_po_decoupling,'sti_ad_po_areadouble')
% 
% %% ad-po-coupling-decoupling brain areas-10*2nodes
% clear all
% close all
% load sdi_ad_ec_sc.mat
% [ad_min10_value,ad_min10_node] = mink(ad_neec_sdi,10);
% [ad_max10_value,ad_max10_node] = maxk(ad_neec_sdi,10);
% sti_ad_ne_coupling = ad_min10_node;
% sti_ad_ne_decoupling = ad_max10_node;
% P_sim_ad_stimulus_set_areadouble(sti_ad_ne_coupling,sti_ad_ne_decoupling,'sti_ad_ne_areadouble')
%% 5*2nodes
% clear all
% close all
% load sdi_ad_ec_sc.mat
% [ad_min10_value,ad_min10_node] = mink(ad_neec_sdi,5);
% [ad_max10_value,ad_max10_node] = maxk(ad_neec_sdi,5);
% sti_ad_ne_coupling = ad_min10_node;
% sti_ad_ne_decoupling = ad_max10_node;
% P_sim_ad_stimulus_set_areadouble(sti_ad_ne_coupling,sti_ad_ne_decoupling,'sti_ad_ne_areadouble5')
% 
% % ad-ne-coupling-decoupling brain areas-10*2nodes
% clear all
% close all
% load sdi_ad_ec_sc.mat
% [ad_min10_value,ad_min10_node] = mink(ad_poec_sdi,5);
% [ad_max10_value,ad_max10_node] = maxk(ad_poec_sdi,5);
% sti_ad_po_coupling = ad_min10_node;
% sti_ad_po_decoupling = ad_max10_node;
% P_sim_ad_stimulus_set_areadouble(sti_ad_po_coupling,sti_ad_po_decoupling,'sti_ad_po_areadouble5')
