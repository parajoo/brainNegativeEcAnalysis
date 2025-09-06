clear all
close all
load ('ad635_data.mat','ad634_ec')
load ('hc979_data.mat','hc978_ec')
load ('mci838_data.mat','mci837_ec')
% ad_ec = mci837_ec;
%load hc979_data.mat
%load mci838_data.mat
%load ad635_data.mat
% ad_empfc = mean(ad635_empfc,3);
%mci_empfc = mean(mci838_empfc,3);
%hc_empfc = mean(hc979_empfc,3);
%ad_ec = (ad_empfc + ad_empfc')/2;
%hc_ec = (hc_empfc + hc_empfc')/2;
%mci_ec = (mci_empfc+mci_empfc')/2;
% clear all
% close all
% %load hc1000_results.mat
% load ad635_data.mat
%hc_ec = results(600).SCnew;
%hcIfc = results(979).iFC_sim_mean;
hc_ec = hc978_ec;
ad_ec_po = hc_ec;
ad_ec_po(ad_ec_po<0) = 0;
ad_ec_po = abs(ad_ec_po);
% ad_ec_po = ad_ec;
% ad_ec_po(ad_ec_po<0) = 0;
% hc_ec_ne = hc_ec;
% hc_ec_ne(hc_ec_ne>0) = 0;
% hc_ec_ne = abs(hc_ec_ne);
% hc_ec_po = hc_ec;
% hc_ec_po(hc_ec_po<0) = 0;
% mci_ec_ne = mci_ec;
% mci_ec_ne(mci_ec_ne>0) = 0;
% mci_ec_ne = abs(mci_ec_ne);
% mci_ec_po = mci_ec;
% mci_ec_po(mci_ec_po<0) = 0;
% hc_ecne_v = hc_ec_ne(hc_ec_ne~=0);
% mci_ecne_v = mci_ec_ne(mci_ec_ne~=0);
ad_ecne_v = ad_ec_po(ad_ec_po~=0);
% hc_ecpo_v = hc_ec_po(hc_ec_po~=0);
% mci_ecpo_v = mci_ec_po(mci_ec_po~=0);
ad_ecpo_v = ad_ec_po(ad_ec_po~=0);
%plot histogram distribution of different group
% figure('color',[1 1 1]);
% hold on;
% histogram(hc_ecne_v,'FaceColor',[161 169 208]/255,'FaceAlpha',0.7);
% histogram(mci_ecne_v,'FaceColor',[240 152 140]/255,'FaceAlpha',0.5);
% histogram(ad_ecne_v,'FaceColor',[150 204 203]/255,'FaceAlpha',0.5);
% hold off;
% legend('HC','MCI','AD');
% xlabel('connection strength')
% ylabel('number')
% title('histogram of negative EC(HC,MCI,AD)')
% %plot histogram distribution of positive links and negative links
% figure('Color',[1 1 1]);
% subplot(3,1,1);
% hold on;
% histogram(hc_ecpo_v,'FaceColor',[161 169 208]/255,'FaceAlpha',0.7);
% histogram(hc_ecne_v,'FaceColor',[240 152 140]/255,'FaceAlpha',0.5);
% hold off;
% legend('po','ne');
% ylim([0,1100]);
% xlim([0,0.17]);
% xlabel('connection strength')
% ylabel('number')
% title('positive and negative EC(HC)')
% hold off;
% subplot(3,1,2);
% hold on;
% histogram(mci_ecpo_v,'FaceColor',[161 169 208]/255,'FaceAlpha',0.7);
% histogram(mci_ecne_v,'FaceColor',[240 152 140]/255,'FaceAlpha',0.5);
% hold off;
% legend('po','ne');
% ylim([0,1100]);
% xlim([0,0.17]);
% xlabel('connection strength')
% ylabel('number')
% title('positive and negative EC(MCI)')
% hold off;
% subplot(3,1,3);
% hold on;
% histogram(ad_ecpo_v,'FaceColor',[161 169 208]/255,'FaceAlpha',0.7);
% histogram(ad_ecne_v,'FaceColor',[240 152 140]/255,'FaceAlpha',0.5);
% hold off;
% legend('po','ne');
% xlabel('connection strength')
% ylabel('probability')
% ylim([0,1100]);
% xlim([0,0.17]);
% title('positive and negative EC(AD)')
% hold off;

%spar_range = [0.6,0.55,0.5,0.45,0.4,0.35,0.3,0.25,0.2,0.15,0.1,0.05];
spar_range = [0.45,0.4,0.35,0.3,0.25,0.2,0.15,0.1,0.05];
for i=1:length(spar_range)
    %
    ec_use = ad_ec_po;
    sparsity = spar_range(i);
    hc_results(i).sparsity = sparsity;
    ecne_v = ec_use(:);
    ecne_sort = sort(ecne_v,'descend');
    ecne_edges = round(sparsity*numel(ec_use));
    th = ecne_sort(ecne_edges);
    ecne_new = ec_use;
    ecne_new(ecne_new<th) = 0;
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
