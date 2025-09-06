% Split and reshape data
close all
% timepoints = 170;  % Example value, adjust accordingly
% cluster_num = size(centers,1);   % Example value, adjust accordingly
% original_vec = cluster.IDX;
% sub = 26;
% hc_data_mat = reshape(original_vec(1:sub*timepoints), timepoints, sub);
% mci_data_mat = reshape(original_vec(sub*timepoints+1:sub*2*timepoints), timepoints, sub);
% ad_data_mat = reshape(original_vec(sub*2*timepoints+1:end), timepoints, sub);
timepoints = 480;
cluster_num = 3;
original_vec = cluster.IDX;
sub_hc = 20;sub_mci = 18;sub_ad = 22;
% Initialize results matrix
pms_matrices = {zeros(sub, cluster_num), zeros(sub, cluster_num), zeros(sub, cluster_num)};
data_matrices = {hc_data_mat, mci_data_mat, ad_data_mat};

% Compute distribution for each person and state
for i = 1:sub
    for state = 1:cluster_num
        for j = 1:3
            pms_matrices{j}(i, state) = sum(data_matrices{j}(:, i) == state) / timepoints;
        end
    end
end

% Perform t-tests and display results
groups = {'HC', 'MCI', 'AD'};
for i = 1:cluster_num
    for comb = [1 2; 1 3; 2 3]'  % HC vs MCI, HC vs AD, MCI vs AD
        [h, p, ci, stats] = ttest2(pms_matrices{comb(1)}(:, i), pms_matrices{comb(2)}(:, i), 'Vartype', 'unequal');
        fprintf('State %d (%s vs %s):\np = %.4f, t = %.4f, CI = [%.4f, %.4f]\n', ...
                i, groups{comb(1)}, groups{comb(2)}, p, stats.tstat, ci(1), ci(2));
        if h, fprintf('Significant at 0.05\n\n'); else, fprintf('Not significant\n\n'); end
    end
end



% Data and settings
v1 = [pms_hc(1,1), pms_mci(1,1), pms_ad(1,1)];
v2 = [pms_hc(1,2), pms_mci(1,2), pms_ad(1,2)];
v3 = [pms_hc(1,3), pms_mci(1,3), pms_ad(1,3)];
v4 = [pms_hc(1,4), pms_mci(1,4), pms_ad(1,4)];

delta = 0.075;
% Create bar plots for each state
create_bar_plot(v1, 1, max(v1)+delta, [], {});
create_bar_plot(v2, 2, max(v2)+delta, [1,2;1,3], {'***','***'});
create_bar_plot(v3, 3, max(v3)+delta, [1,2;1,3], {'***','***'});
create_bar_plot(v4, 4, max(v4)+delta, [1,3], {'***'});
%create_bar_plot(v5, 5, max(v5)+delta, [1,3;2,3], {'*','***'});
% Function for creating bar plots with colors and significance markers
function create_bar_plot(v, state, ylim_val, sig_pairs, sig_labels)
    colors = [73, 108, 136; 169, 184, 198; 254, 178, 180]./255;
    tik = {'HC','MCI','AD'};
    figure('color', [1 1 1]);
    b = bar(v, 'FaceColor', 'flat');
    for k = 1:length(v)
        b.CData(k, :) = colors(k, :);
    end
    set(gca, 'XTickLabel', tik);
    title(['state' num2str(state)]);
    xlabel('group'); ylabel('probability'); ylim([0, ylim_val]);

    % Add significance markers
    hold on;
    for i = 1:size(sig_pairs, 1)
        x = sig_pairs(i, :); 
        %y = max(v(x))+0.01 + 0.01* i;
        y=max(v)+0.02*i;
        %y = max()
        plot(x, [y, y], 'k-', 'LineWidth', 1.25);
        text(mean(x), y + 0.0025, sig_labels{i}, 'FontSize', 13, 'HorizontalAlignment', 'center');
    end
    hold off;
end





