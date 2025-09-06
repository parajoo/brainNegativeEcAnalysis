clear all
close all
load ad812_data.mat
load hc794_data.mat
load hc794_ec_sc.mat
load mci930_data.mat
load diff_spar_mci.mat
ad_ec = ad812_ec;
hc_ec = hc794_ec;
mci_ec = mci930_ec;
ad_ec_ne = ad_ec;
ad_ec_ne(ad_ec_ne>0) = 0;
ad_ec_ne = abs(ad_ec_ne);
hc_ec_ne = hc_ec;
hc_ec_ne(hc_ec_ne>0) = 0;
hc_ec_ne = abs(hc_ec_ne);
mci_ec_ne = mci_ec;
mci_ec_ne(mci_ec_ne>0) = 0;
mci_ec_ne = abs(mci_ec_ne);
% hc_ecne_v = hc_ec_ne(hc_ec_ne~=0);
% mci_ecne_v = mci_ec_ne(mci_ec_ne~=0);
% ad_ecne_v = ad_ec_ne(ad_ec_ne~=0);
% figure('color',[1 1 1]);
% hold on;
% histogram(hc_ecne_v,'FaceColor',[161 169 208]/255,'FaceAlpha',0.7);
% histogram(mci_ecne_v,'FaceColor',[240 152 140]/255,'FaceAlpha',0.5);
% histogram(ad_ecne_v,'FaceColor',[150 204 203]/255,'FaceAlpha',0.5);
% hold off;
% legend('HC','MCI','AD');
% xlabel('connection strength')
% ylabel('probability')
% title('histogram of negative EC(HC,MCI,AD)')
spar_range = 0.4:-0.1:0.1;
for i=1:length(spar_range)
    sparsity = spar_range(i);
    ad_results(i).sparsity = sparsity;
    ad_ecne_v = ad_ec_ne(:);
    ad_ecne_sort = sort(ad_ecne_v,'descend');
    ad_ecne_edges = round(sparsity*numel(ad_ec_ne));
    ad_th = ad_ecne_sort(ad_ecne_edges);
    ad_ecne_new = ad_ec_ne;
    ad_ecne_new(ad_ecne_new<ad_th) = 0;
    ad_results(i).mci_ecne_new = ad_ecne_new;
    % weighted centrality
    ad_weights = sum(ad_ecne_new,2);
    ad_max_wd = sum(max(ad_ecne_new));
    ad_wc = ad_weights / ad_max_wd;
    [ad_wc_v,ad_wc_i] = maxk(ad_wc,10);
    ad_results(i).mci_wc_i = ad_wc_i;
    % eigenvector centrality
    g_ad = graph(ad_ecne_new);
    ad_ec = centrality(g_ad,'eigenvector','Importance',g_ad.Edges.Weight);
    [ad_ec_v,ad_ec_i] = maxk(ad_ec,10);
    ad_results(i).mci_ec_i = ad_ec_i;
    % closeness centrality
    ad_costs = 1 ./ ad_ecne_new;
    ad_costs(isinf(ad_costs)) = 0; 
    ad_costs(isnan(ad_costs)) = 0; 
    ad_costVector = ad_costs(g_ad.Edges.EndNodes(:,1) + size(ad_ecne_new,1)*(g_ad.Edges.EndNodes(:,2)-1));
    ad_cc = centrality(g_ad, 'closeness', 'Cost', ad_costVector);
    [ad_cc_v,ad_cc_i] = maxk(ad_cc,10);
    ad_results(i).mci_cc_i = ad_cc_i;
end











