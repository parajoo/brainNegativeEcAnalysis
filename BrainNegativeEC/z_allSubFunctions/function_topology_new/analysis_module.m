clear all
close all
load ad_spar_results.mat
load mci_spar_results.mat
load hc_spar_results.mat
rng(0)
ad_s5 = ad_results(7).ecne_new;
mci_s5 = mci_results(7).ecne_new;
hc_s5 = hc_results(7).ecne_new;

%% hc_module
% [com_hc,modu_hc] = community_louvain(hc_s5);
% unique = unique(com_hc);
% counts = accumarray(com_hc,1);
% for i=1:length(unique)
%     if counts(length(unique) - i+1)==1
%         counts(length(unique) - i+1) = [];
%     end
% end
% fprintf('HC-number of module : %d\n', length(counts));
% fprintf('HC-modularity : %.4f\n',modu_hc);
% figure('color',[1 1 1]);
% plot(graph(hc_s5), 'NodeCData', com_hc, 'MarkerSize', 7);
% title('community structure of negative EC(HC)');
% colorbar;
% [com_mci,modu_mci] = community_louvain(mci_s5);
% clear unique
% unique = unique(com_mci);
% counts = accumarray(com_mci,1);
% for i=1:length(unique)
%     if counts(length(unique) - i+1)==1
%         counts(length(unique) - i+1) = [];
%     end
% end
% fprintf('MCI-number of module : %d\n', length(counts));
% fprintf('MCI-modularity : %.4f\n',modu_mci);
% figure('color',[1 1 1]);
% plot(graph(mci_s5), 'NodeCData', com_mci, 'MarkerSize', 7);
% title('community structure of negative EC(MCI)');
% colorbar;
% [com_ad,modu_ad] = community_louvain(ad_s5);
% clear unique
% unique = unique(com_ad);
% counts = accumarray(com_ad,1);
% for i=1:length(unique)
%     if counts(length(unique) - i+1)==1
%         counts(length(unique) - i+1) = [];
%     end
% end
% fprintf('AD-number of module : %d\n', length(counts));
% fprintf('AD-modularity : %.4f\n',modu_ad);
% figure('color',[1 1 1]);
% plot(graph(ad_s5), 'NodeCData', com_ad, 'MarkerSize', 7);
% title('community structure of negative EC(AD)');
% colorbar;

%% extract module(nodal number unequal to 1)
% matrix = hc_s5;
% colmask = any(matrix~=0,1);
% rowmask = any(matrix~=0,2);
% matrix = matrix(rowmask,colmask);
% orgindex = find(rowmask);
% orgindex = find(colmask);
% [community_ne,modularity_ne] = community_louvain(matrix);
% fprintf('HC - number of module : %d\n',max(community_ne));
% fprintf('HC - modularity : %.4f\n',modularity_ne);
% figure('color',[1 1 1]);p = plot(graph(matrix),'NodeCData',community_ne,'MarkerSize',7);p.NodeLabel = arrayfun(@num2str,orgindex,'UniformOutput',false);
% p.MarkerSize = 7;
% title('HC-module')
% clear matrix colmask rowmask orgindex community_ne modularity_ne
% matrix = mci_s5;
% colmask = any(matrix~=0,1);
% rowmask = any(matrix~=0,2);
% matrix = matrix(rowmask,colmask);
% orgindex = find(rowmask);
% orgindex = find(colmask);
% [community_ne,modularity_ne] = community_louvain(matrix);
% fprintf('MCI - number of module : %d\n',max(community_ne));
% fprintf('MCI - modularity : %.4f\n',modularity_ne);
% figure('color',[1 1 1]);p = plot(graph(matrix),'NodeCData',community_ne,'MarkerSize',7);p.NodeLabel = arrayfun(@num2str,orgindex,'UniformOutput',false);
% p.MarkerSize = 7;
% title('MCI-module')
% clear matrix colmask rowmask orgindex community_ne modularity_ne
% matrix = ad_s5;
% colmask = any(matrix~=0,1);
% rowmask = any(matrix~=0,2);
% matrix = matrix(rowmask,colmask);
% orgindex = find(rowmask);
% orgindex = find(colmask);
% [community_ne,modularity_ne] = community_louvain(matrix);
% fprintf('AD - number of module : %d\n',max(community_ne));
% fprintf('AD - modularity : %.4f\n',modularity_ne);
% figure('color',[1 1 1]);p = plot(graph(matrix),'NodeCData',community_ne,'MarkerSize',7);p.NodeLabel = arrayfun(@num2str,orgindex,'UniformOutput',false);
% p.MarkerSize = 7;
% title('AD-module')

%% figure modularity under different threshold of HC,MCI,AD
for i=1:length(hc_results)
    matrix_hc = hc_results(i).ecne_new;
    colmask = any(matrix_hc~=0,1);
    rowmask = any(matrix_hc~=0,2);
    matrix_hc = matrix_hc(rowmask,colmask);
    orgindex = find(rowmask);
    orgindex = find(colmask);
    [community_ne,modularity_ne] = community_louvain(matrix_hc);
    hc_results(i).community_num = max(community_ne);
    hc_results(i).modularity = modularity_ne;
    clear colmask rowmask orgindex community_ne modularity_ne
    matrix_mci = mci_results(i).ecne_new;
    colmask = any(matrix_mci~=0,1);
    rowmask = any(matrix_mci~=0,2);
    matrix_mci = matrix_mci(rowmask,colmask);
    orgindex = find(rowmask);
    orgindex = find(colmask);
    [community_ne,modularity_ne] = community_louvain(matrix_mci);
    mci_results(i).community_num = max(community_ne);
    mci_results(i).modularity = modularity_ne;
    clear colmask rowmask orgindex community_ne modularity_ne
    matrix_ad = ad_results(i).ecne_new;
    colmask = any(matrix_ad~=0,1);
    rowmask = any(matrix_ad~=0,2);
    matrix_ad = matrix_ad(rowmask,colmask);
    orgindex = find(rowmask);
    orgindex = find(colmask);
    [community_ne,modularity_ne] = community_louvain(matrix_ad);
    ad_results(i).community_num = max(community_ne);
    ad_results(i).modularity = modularity_ne;
    clear colmask rowmask orgindex community_ne modularity_ne
end
%x=[hc_results.sparsity];
x=1:8;
module_hc = [hc_results.community_num];
modularity_hc = [hc_results.modularity];
module_mci = [mci_results.community_num];
modularity_mci = [mci_results.modularity];
module_ad = [ad_results.community_num];
modularity_ad = [ad_results.modularity];
colors = {[130 176 210]/255,[190 184 220]/255,[153 153 153]/255};
figure('Color',[1 1 1]);
plot(x, modularity_hc, 'Color', colors{1}, 'Marker', '*', 'LineWidth', 1.5, 'DisplayName', 'HC - Modularity'); hold on;
plot(x, modularity_mci, 'Color', colors{2}, 'Marker', '*', 'LineWidth', 1.5, 'DisplayName', 'MCI - Modularity');
plot(x, modularity_ad, 'Color', colors{3}, 'Marker', '*', 'LineWidth', 1.5, 'DisplayName', 'AD - Modularity');
ylabel('Modularity'); % 左侧 Y 轴标签
xlabel('sparsity')
set(gca, 'YColor', [0 0 0]); % 自定义左侧 Y 轴颜色

% yyaxis right; % 右侧 Y 轴（模块数量）
% plot(x, module_hc, 'Color', colors{1}, 'Marker', 'x', 'LineStyle', '--', 'LineWidth', 1.5, 'DisplayName', 'HC - Module Number');
% plot(x, module_mci, 'Color', colors{2}, 'Marker', 'x', 'LineStyle', '--', 'LineWidth', 1.5, 'DisplayName', 'MCI - Module Number');
% plot(x, module_ad, 'Color', colors{3}, 'Marker', 'x', 'LineStyle', '--', 'LineWidth', 1.5, 'DisplayName', 'AD - Module Number');
% ylabel('Module Number'); % 右侧 Y 轴标签
% set(gca, 'YColor', [0 0 0]); % 自定义右侧 Y 轴颜色

% 添加图例和轴标签
%xlabel('Sparsity Index'); % x 轴标签
legend('Location', 'best'); % 自动调整位置的图例
title('Modularity across Groups'); % 标题