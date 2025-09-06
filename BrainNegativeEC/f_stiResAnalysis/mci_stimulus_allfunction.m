%% trio-Stimuli-Code
%ad-ne-coupling
clear all
close all
load('trioSdi0718.mat','mciNeSdi')
[~,sti_area] = mink(mciNeSdi,10);
TMciStiSetArea(sti_area,'t_stiMciNeC0718')
%ad-ne-decoupling
clear all
close all
load('trioSdi0718.mat','mciNeSdi')
[~,sti_area] = maxk(mciNeSdi,10);
TMciStiSetArea(sti_area,'t_stiMciNeD0718')
%ad-po-coupling
clear all
close all
load('trioSdi0718.mat','mciPoSdi')
[~,sti_area] = mink(mciPoSdi,10);
TMciStiSetArea(sti_area,'t_stiMciPoC0718')
%ad-po-decoupling
clear all
close all
load('trioSdi0718.mat','mciPoSdi')
[~,sti_area] = maxk(mciPoSdi,10);
TMciStiSetArea(sti_area,'t_stiMciPoD0718')
%ad po+ne Coupling
clear all
close all
load('trioSdi0718.mat','mciNeSdi','mciPoSdi')
[~,poCnode] = mink(mciNeSdi,10);
[~,neCnode] = mink(mciPoSdi,10);
CnodeAll = [poCnode;neCnode];
sti_area = unique(CnodeAll);
TMciStiSetArea(sti_area,'t_stiMciPoNeC0718')
% ad po+ne Decoupling
clear all
close all
load('trioSdi0718.mat','mciNeSdi','mciPoSdi')
[~,poDnode] = maxk(mciNeSdi,10);
[~,neDnode] = maxk(mciPoSdi,10);
DnodeAll = [poDnode;neDnode];
sti_area = unique(DnodeAll);
TMciStiSetArea(sti_area,'t_stiMciPoNeD0718')

%% ad ne CandD
clear all
close all
load('trioSdi0718.mat','mciNeSdi')
[~,poCnodes] = mink(mciNeSdi,10);
[~,poDnodes] = maxk(mciNeSdi,10);
TMciStiSetAreadouble_test(poCnodes,poDnodes,'t_stiMciNeCandD0718')
%% ad po CandD
clear all
close all
load('trioSdi0718.mat','mciPoSdi')
[~,poCnodes] = mink(mciPoSdi,10);
[~,poDnodes] = maxk(mciPoSdi,10);
TMciStiSetAreadouble_test(poCnodes,poDnodes,'t_stiMciPoCandD0718')