%% trio0718  --  load data
clear all
close all
load('hc895_data.mat','hc895_empfc')
hc_ec = mean(hc895_empfc,3);
hc_ec_po = (hc_ec+hc_ec')/2;
hc_ec_po(hc_ec_po>0) = 0;
hc_ec_po = abs(hc_ec_po);
load('mci848_data.mat','mci848_empfc')
mci_ec = mean(mci848_empfc,3);
mci_ec_po = (mci_ec+mci_ec')/2;
mci_ec_po(mci_ec_po>0) = 0;
mci_ec_po = abs(mci_ec_po);
load('ad943_data.mat','ad943_empfc')
ad_ec = mean(ad943_empfc,3);
ad_ec_po = (ad_ec+ad_ec')/2;
ad_ec_po(ad_ec_po>0) = 0;
ad_ec_po = abs(ad_ec_po);
%% trio0718
% clear all
% close all
% load('hc895_data.mat','hc895_empfc')
% hc_ec = mean(hc895_empfc,3);
% hcecSym = (hc_ec+hc_ec')/2;
% hc_ec_po = hcecSym-eye(90,90);
% hc_ec_po(hc_ec_po>0) = 0;
% hc_ec_po = abs(hc_ec_po);
% load('mci848_data.mat','mci848_empfc')
% mci_ec = mean(mci848_empfc,3);
% mciecSym = (mci_ec+mci_ec')/2;
% mci_ec_po = mciecSym-eye(90,90);
% mci_ec_po(mci_ec_po>0) = 0;
% mci_ec_po = abs(mci_ec_po);
% load('ad943_data.mat','ad943_empfc')
% ad_ec = mean(ad943_empfc,3);
% adecSym = (ad_ec+ad_ec')/2;
% ad_ec_po = adecSym-eye(90,90);
% ad_ec_po(ad_ec_po>0) = 0;
% ad_ec_po = abs(ad_ec_po);
%% trio --  load data
% clear all
% close all
% load('hc757_data.mat','hc756_ec')
% hc_ec = hc756_ec;
% hc_ec_po = hc_ec;
% hc_ec_po(hc_ec_po>0) = 0;
% hc_ec_po = abs(hc_ec_po);
% load('mci856_data.mat','mci855_ec')
% mci_ec = mci855_ec;
% mci_ec_po = mci_ec;
% mci_ec_po(mci_ec_po>0) = 0;
% mci_ec_po = abs(mci_ec_po);
% load('ad809_data.mat','ad808_ec')
% ad_ec = ad808_ec;
% ad_ec_po = ad_ec;
% ad_ec_po(ad_ec_po>0) = 0;
% ad_ec_po = abs(ad_ec_po);
spar_range = [0.55,0.50,0.45,0.4,0.35,0.3,0.25,0.2,0.15,0.1,0.05];
nodeNum = 10;
clear neec_results
for i=1:length(spar_range)
    %% HC
    ec_use = hc_ec_po;
    sparsity = spar_range(i);
    neec_results(i).sparsity = sparsity;
    ecne_v = ec_use(:);
    ecne_sort = sort(ecne_v,'descend');
    ecne_edges = round(sparsity*numel(ec_use));
    th = ecne_sort(ecne_edges);
    ecne_new = ec_use;
    ecne_new(ecne_new<th) = 0;
    %neec_results(i).ecneHc = ecne_new;
    g = graph(ecne_new);
    ec = centrality(g,'eigenvector','Importance',g.Edges.Weight);
    [~,ec_i] = maxk(ec,nodeNum);
    neec_results(i).ec_Hc = ecne_new;
    neec_results(i).evc_iHc = ec_i;
    %% MCI
    clear ec_use ecne_v ecne_sort ecne_edges th ecne_new g ec_i ec
    ec_use = mci_ec_po;
    ecne_v = ec_use(:);
    ecne_sort = sort(ecne_v,'descend');
    ecne_edges = round(sparsity*numel(ec_use));
    th = ecne_sort(ecne_edges);
    ecne_new = ec_use;
    ecne_new(ecne_new<th) = 0;
    %neec_results(i).ecneMci = ecne_new;
    g = graph(ecne_new);
    ec = centrality(g,'eigenvector','Importance',g.Edges.Weight);
    [~,ec_i] = maxk(ec,nodeNum);
    neec_results(i).ec_Mci = ecne_new;
    neec_results(i).evc_iMci = ec_i;
    %% AD
    clear ec_use ecne_v ecne_sort ecne_edges th ecne_new g ec_i ec
    ec_use = ad_ec_po;
    ecne_v = ec_use(:);
    ecne_sort = sort(ecne_v,'descend');
    ecne_edges = round(sparsity*numel(ec_use));
    th = ecne_sort(ecne_edges);
    ecne_new = ec_use;
    ecne_new(ecne_new<th) = 0;
    %neec_results(i).ecneAd = ecne_new;
    g = graph(ecne_new);
    ec = centrality(g,'eigenvector','Importance',g.Edges.Weight);
    [~,ec_i] = maxk(ec,nodeNum);
    neec_results(i).ec_Ad = ecne_new;
    neec_results(i).evc_iAd = ec_i;
end
