clear all
%close all
load ad635_data.mat
load hc979_data.mat
load mci838_data.mat
ad_ec = ad635_ec;
hc_ec = hc979_ec;
mci_ec = mci838_ec;
%% negative elements
ad_ec_ne = ad_ec;
ad_ec_ne(ad_ec_ne>0) = 0;
ad_ec_ne = abs(ad_ec_ne);
hc_ec_ne = hc_ec;
hc_ec_ne(hc_ec_ne>0) = 0;
hc_ec_ne = abs(hc_ec_ne);
mci_ec_ne = mci_ec;
mci_ec_ne(mci_ec_ne>0) = 0;
mci_ec_ne = abs(mci_ec_ne);
hc_ecne_v = hc_ec_ne(hc_ec_ne~=0);
mci_ecne_v = mci_ec_ne(mci_ec_ne~=0);
ad_ecne_v = ad_ec_ne(ad_ec_ne~=0);
%% positive elements
hc_ec_po = hc_ec;
hc_ec_po(hc_ec_po<0) = 0;
hc_ecpo_v = hc_ec_po(hc_ec_po~=0);
mci_ec_po = mci_ec;
mci_ec_po(mci_ec_po<0) = 0;
mci_ecpo_v = mci_ec_po(mci_ec_po~=0);
ad_ec_po = ad_ec;
ad_ec_po(ad_ec_po<0) = 0;
ad_ecpo_v = ad_ec_po(ad_ec_po~=0);
%% plot 
figure('color',[1 1 1]);
hold on;
histogram(hc_ecne_v,'FaceColor',[161 169 208]/255,'FaceAlpha',0.7);
histogram(mci_ecne_v,'FaceColor',[240 152 140]/255,'FaceAlpha',0.5);
histogram(ad_ecne_v,'FaceColor',[150 204 203]/255,'FaceAlpha',0.5);
hold off;
legend('HC','MCI','AD');
xlabel('connection strength')
ylabel('probability')
title('histogram of positive EC(HC,MCI,AD)')
%% calculate the wc,ec,cc under different threshold
th_range = 0.01:0.005:0.1;
for i=1:length(th_range)
    thre = th_range(i);
    hc_results(i).th = thre;
    ecne_new = hc_ec_ne;
    ecne_new(ecne_new<thre) = 0;
    hc_results(i).ecne_new = ecne_new;
    % weighted centrality
    weights = sum(ecne_new,2);
    max_wd = sum(max(ecne_new));
    wc = weights / max_wd;
    [wc_v,wc_i] = maxk(wc,10);
    hc_results(i).wc_i = wc_i;
    % eigenvector centrality
    g = graph(ecne_new);
    ec = centrality(g,'eigenvector','Importance',g.Edges.Weight);
    [ec_v,ec_i] = maxk(ec,10);
    hc_results(i).ec_i = ec_i;
    % closeness centrality
    costs = 1 ./ ecne_new;
    costs(isinf(costs)) = 0; 
    costs(isnan(costs)) = 0; 
    costVector = costs(g.Edges.EndNodes(:,1) + size(ecne_new,1)*(g.Edges.EndNodes(:,2)-1));
    cc = centrality(g, 'closeness', 'Cost', costVector);
    [cc_v,cc_i] = maxk(cc,10);
    hc_results(i).cc_i = cc_i;
end











