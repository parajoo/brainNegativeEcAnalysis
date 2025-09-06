clear all
close all
load ('ad635_data.mat','ad634_ec','ad635_sc')
ec = ad634_ec;
sc = ad635_sc;
SC_reordered =sc([1:2:90,90:-2:2],[1:2:90,90:-2:2]);
EC_reordered = ec([1:2:90,90:-2:2],[1:2:90,90:-2:2]);
total_edges = numel(sc);
fprintf('-- AD --  \n')
th_range = [0.001,0:0.005:0.02];
ad_po_ratio = zeros(1,length(th_range));
ad_ne_ratio = zeros(1,length(th_range));
ad_ne_inter = zeros(1,length(th_range));
ad_ne_intra = zeros(1,length(th_range));
ad_enhance_ratio = zeros(1,length(th_range));
ad_weaken_ratio = zeros(1,length(th_range));
%% calculate the distribution of negative links(inter-brain and intra-brain)
for i=1:length(th_range)
    th = th_range(i);
    EC_thnew = EC_reordered;
    EC_thnew(abs(EC_thnew)<th) = 0;
    positive_edges_new = EC_thnew > 0;
    negative_edges_new = EC_thnew < 0;
    total_positive_new = sum(positive_edges_new, 'all');
    total_negative_new = sum(negative_edges_new, 'all');
    intra_positive_left_new = sum(positive_edges_new(1:45, 1:45), 'all');
    intra_positive_right_new = sum(positive_edges_new(46:90, 46:90), 'all');
    inter_positive_new = sum(positive_edges_new(1:45, 46:90), 'all') + sum(positive_edges_new(46:90, 1:45), 'all');

    intra_negative_left_new = sum(negative_edges_new(1:45, 1:45), 'all');
    intra_negative_right_new = sum(negative_edges_new(46:90, 46:90), 'all');
    inter_negative_new = sum(negative_edges_new(1:45, 46:90), 'all') + sum(negative_edges_new(46:90, 1:45), 'all');

    percentage_positive_new = 100 * total_positive_new / total_edges;
    percentage_negative_new = 100 * total_negative_new / total_edges;
    percentage_intra_positive_new = 100 * (intra_positive_left_new + intra_positive_right_new) / total_edges;
    percentage_inter_positive_new = 100 * inter_positive_new / total_edges;
    percentage_intra_negative_new = 100 * (intra_negative_left_new + intra_negative_right_new) / total_edges;
    percentage_inter_negative_new = 100 * inter_negative_new / total_edges;
    %
    ad_po_ratio(i) = percentage_positive_new;
    ad_ne_ratio(i) = percentage_negative_new;
    ad_ne_inter(i) = percentage_inter_negative_new;
    ad_ne_intra(i) = percentage_intra_negative_new;
    fprintf('positive links and negative links(diff_th = %.3f) \n' , th)
    fprintf('(th = %.4f )positive edges: %.2f%%\n', th,percentage_positive_new);
    fprintf('(th = %.4f )negative edges: %.2f%%\n', th,percentage_negative_new);
    fprintf('(th = %.4f )positive edges(intra): %.2f%%\n', th,percentage_intra_positive_new);
    fprintf('(th = %.4f )positive edges(inter): %.2f%%\n', th,percentage_inter_positive_new);
    fprintf('(th = %.4f)negative edges(intra): %.2f%%\n', th,percentage_intra_negative_new);
    fprintf('(th = %.4f)negative edges(inter): %.2f%%\n', th,percentage_inter_negative_new);
    %% weakened links and enhanced links
    fprintf('weakened links and enhanced links(diff_th = %.3f) \n' , th)
    diff_ecnew_sc = EC_thnew - SC_reordered;
    enhanced_links_all = sum(diff_ecnew_sc>0,'all') / 8100;
    weakened_links_all = sum(diff_ecnew_sc<0,'all') / 8100;
    fprintf('(th = %.4f)weakened links: %.2f%%\n', th,weakened_links_all*100);
    fprintf('(th = %.4f)enhanced links: %.2f%%\n', th,enhanced_links_all*100);
    ad_enhance_ratio(i) = enhanced_links_all*100;
    ad_weaken_ratio(i) = weakened_links_all*100;
    fprintf("\n");
end
%% eigenvector centrality and weighted degree
% th = th_range(5);
% ec_new = ec;
% sc_new = sc;
% diff_new = ec_new - sc_new;
% diff_new_erzhi = diff_new;
% diff_new_erzhi(abs(diff_new_erzhi)<th)= 0;
% diff_new_erzhi(diff_new_erzhi~=0) = 1;
% ec_new_erzhi = ec_new.*diff_new_erzhi;
% ecnew_ne = ec_new_erzhi;
% ecnew_ne(ecnew_ne>0) = 0;
% ecnew_ne = abs(ecnew_ne);
% % wc
% weights = sum(ecnew_ne, 2); % 计算每个节点的加权度
% max_possible_degree = sum(max(ecnew_ne)); % 最大可能的加权度
% weighted_centrality = weights / max_possible_degree;
% [top10Values_wc,top10areas_wc] = maxk(weighted_centrality,20);
% % ev
% G = graph(ecnew_ne);
% node_eigencentrality = centrality(G,'eigenvector','Importance',G.Edges.Weight);
% [top10_evv,top10_evi] = maxk(node_eigencentrality,20);
% % cv
% costs = 1 ./ ecnew_ne;
% costs(isinf(costs)) = 0; % 处理1/0情况
% costs(isnan(costs)) = 0; % 处理0/0情况
% 
% % 成本向量，只考虑边的成本
% costVector = costs(G.Edges.EndNodes(:,1) + size(ecnew_ne,1)*(G.Edges.EndNodes(:,2)-1));
% 
% % 计算加权接近中心性，需要成本为向量
% closeness_centrality = centrality(G, 'closeness', 'Cost', costVector);
% [top10_cvv,top10_cvi] = maxk(closeness_centrality,20);
%% 0-->positive or 0-->negative?

% negative_idx = find(ec<0);
% ec_zero = 1*ones(size(sc));
% ec_zero(negative_idx) = ec(negative_idx);
% sc_zero = 1*ones(size(sc));
% sc_zero(negative_idx) = sc(negative_idx);
% ec_zero_range = ec_zero([1:2:90,90:-2:2],[1:2:90,90:-2:2]);
% sc_zero_range = sc_zero([1:2:90,90:-2:2],[1:2:90,90:-2:2]);
% figure('Color',[1 1 1]);imagesc(abs(ec_zero_range));colorbar;title('negative EC');colormap('jet');caxis([0 0.01])
% figure('Color',[1 1 1]);imagesc(sc_zero);colorbar;title('negative EC --> SC');colormap('jet');caxis([0 0.01])
% intra_negative_left_new = sum(sc_zero_range(1:45, 1:45)>0, 'all');
% intra_negative_right_new = sum(sc_zero_range(46:90, 46:90)>0, 'all');
% intra_scpo_ecne = intra_negative_right_new+intra_negative_left_new;
% 
% 
% negative_idx = find(ec<0);
% ec_ones = ones(size(sc));
% ec_ones(negative_idx) = ec(negative_idx);% include the negative elements and 1
% sc_ones = ones(size(sc));
% sc_ones(negative_idx) = sc(negative_idx);% include the positive,0 and 1
% ec_ones_range = ec_ones([1:2:90,90:-2:2],[1:2:90,90:-2:2]);
% sc_ones_range = sc_ones([1:2:90,90:-2:2],[1:2:90,90:-2:2]);
% figure('Color',[1 1 1]);imagesc(abs(ec_ones_range));colorbar;title('negative EC');colormap('jet');caxis([0 0.0055])
% figure('Color',[1 1 1]);imagesc(sc_ones_range);colorbar;title('negative EC --> SC');colormap('jet');caxis([0 0.0055])
% intra_negative_left_new = sum(sc_ones_range(1:45, 46:90)==0, 'all');
% intra_negative_right_new = sum(sc_ones_range(1:45, 46:90)==0, 'all');
% intra_scpo_ecne = intra_negative_right_new+intra_negative_left_new;
% %% simulated fc
% load adfc127.mat
% fc_zeros = zeros(size(adsc0));
% fc_zeros(negative_idx) = adfc127(negative_idx);
% fc_zeros_range = fc_zeros([1:2:90,90:-2:2],[1:2:90,90:-2:2]);
% figure('Color',[1 1 1]);imagesc(fc_zeros_range);colorbar;title('simulated FC');colormap('jet');
% %% empirical fc
% load adfc0.mat
% fc_zeros = zeros(size(adsc0));
% fc_zeros(negative_idx) = adfc0(negative_idx);
% fc_zeros_range = fc_zeros([1:2:90,90:-2:2],[1:2:90,90:-2:2]);
% figure('Color',[1 1 1]);imagesc(fc_zeros_range);colorbar;title('empirical FC');colormap('jet');
% %% empirical phase coherence matrix
% load phase_ad_emp.mat
% phase_zeros = zeros(size(adsc0));
% phase_zeros(negative_idx) = phase_ad_emp(negative_idx);
% phase_zeros_range = phase_zeros([1:2:90,90:-2:2],[1:2:90,90:-2:2]);
% figure('Color',[1 1 1]);imagesc(phase_zeros_range);colorbar;title('empirical phase coherence matrix(AD)');colormap('jet');
% %% simulated phase coherence matrix
% load phase_ad_sim.mat
% phase_zeros = zeros(size(adsc0));
% phase_zeros(negative_idx) = phase_ad_sim(negative_idx);
% phase_zeros_range = phase_zeros([1:2:90,90:-2:2],[1:2:90,90:-2:2]);
% figure('Color',[1 1 1]);imagesc(phase_zeros_range);colorbar;title('simulated phase coherence matrix(AD)');colormap('jet');
% ad_diff = ec - sc;
% ad_diff_th = ad_diff;
% ad_diff_th(abs(ad_diff_th)<0.001) = 0;
% ad_diff_range = ad_diff_th([1:2:90,90:-2:2],[1:2:90,90:-2:2]);
% figure('color',[1 1 1]);imagesc(ad_diff_th);colorbar;colormap('jet');title('(th = 0.03)difference bewteen SC and EC');
% figure('color',[1 1 1]);imagesc(ad_diff_range);colorbar;colormap('jet');title('(th = 0.02)difference bewteen SC and EC(rearrange)');
% % calculate the enhanced and weakened edges after setting threshold
% total_enhanced_th = sum(ad_diff_th>0,'all');
% total_weakened_th = sum(ad_diff_th<0,'all');
% % 计算半脑内和半脑间的增强边(after setting threshold)
% intra_enhanced_th_left = sum(ad_diff_th(1:45, 1:45)>0, 'all');
% intra_enhanced_th_right = sum(ad_diff_th(46:90, 46:90)>0, 'all');
% inter_enhanced_th = sum(ad_diff_th(1:45, 46:90)>0, 'all') + sum(ad_diff_th(46:90, 1:45)>0, 'all');
% % 计算半脑内和半脑间的减弱边(after setting threshold)
% intra_weakened_th_left = sum(ad_diff_th(1:45, 1:45)<0, 'all');
% intra_weakened_th_right = sum(ad_diff_th(46:90, 46:90)<0, 'all');
% inter_weakened_th = sum(ad_diff_th(1:45, 46:90)<0, 'all') + sum(ad_diff_th(46:90, 1:45)<0, 'all');
% % 计算比例
% percentage_enhanced_th = 100 * total_enhanced_th / total_edges;
% percentage_weakened_th = 100 * total_weakened_th / total_edges;
% percentage_intra_enhanced_th = 100 * (intra_enhanced_th_left + intra_enhanced_th_right) / total_edges;
% percentage_inter_enhanced_th = 100 * inter_enhanced_th / total_edges;
% percentage_intra_weakened_th = 100 * (intra_weakened_th_left + intra_weakened_th_right) / total_edges;
% percentage_inter_weakened_th = 100 * inter_weakened_th / total_edges;
% % 显示结果(after setting threshold)
% fprintf('(th = 0.001)enhanced edges: %.2f%%\n', percentage_enhanced_th);
% fprintf('(th = 0.001)weakened edges: %.2f%%\n', percentage_weakened_th);
% fprintf('(th = 0.001)enhanced edges(intra): %.2f%%\n', percentage_intra_enhanced_th);
% fprintf('(th = 0.001)enhanced edges(inter): %.2f%%\n', percentage_inter_enhanced_th);
% fprintf('(th = 0.001)weakened edges(intra): %.2f%%\n', percentage_intra_weakened_th);
% fprintf('(th = 0.001)weakened edges(inter): %.2f%%\n', percentage_inter_weakened_th);
% 
% fprintf('all changes \n');
% % 计算增强和减弱的边
% enhanced_edges = EC_reordered > SC_reordered;
% weakened_edges = EC_reordered < SC_reordered;
% 
% % 计算增强和减弱的边的总数
% total_enhanced = sum(enhanced_edges, 'all');
% total_weakened = sum(weakened_edges, 'all');
% 
% % 计算半脑内和半脑间的增强边
% intra_enhanced_left = sum(enhanced_edges(1:45, 1:45), 'all');
% intra_enhanced_right = sum(enhanced_edges(46:90, 46:90), 'all');
% inter_enhanced = sum(enhanced_edges(1:45, 46:90), 'all') + sum(enhanced_edges(46:90, 1:45), 'all');
% 
% % 计算半脑内和半脑间的减弱边
% intra_weakened_left = sum(weakened_edges(1:45, 1:45), 'all');
% intra_weakened_right = sum(weakened_edges(46:90, 46:90), 'all');
% inter_weakened = sum(weakened_edges(1:45, 46:90), 'all') + sum(weakened_edges(46:90, 1:45), 'all');
% 
% 
% % 计算比例
% percentage_enhanced = 100 * total_enhanced / total_edges;
% percentage_weakened = 100 * total_weakened / total_edges;
% percentage_intra_enhanced = 100 * (intra_enhanced_left + intra_enhanced_right) / total_edges;
% percentage_inter_enhanced = 100 * inter_enhanced / total_edges;
% percentage_intra_weakened = 100 * (intra_weakened_left + intra_weakened_right) / total_edges;
% percentage_inter_weakened = 100 * inter_weakened / total_edges;
% 
% % 显示结果
% fprintf('(th = 0)enhanced edges: %.2f%%\n', percentage_enhanced);
% fprintf('(th = 0)weakened edges: %.2f%%\n', percentage_weakened);
% fprintf('(th = 0)enhanced edges(intra): %.2f%%\n', percentage_intra_enhanced);
% fprintf('(th = 0)enhanced edges(inter): %.2f%%\n', percentage_inter_enhanced);
% fprintf('(th = 0)weakened edges(intra): %.2f%%\n', percentage_intra_weakened);
% fprintf('(th = 0)weakened edges(inter): %.2f%%\n', percentage_inter_weakened);