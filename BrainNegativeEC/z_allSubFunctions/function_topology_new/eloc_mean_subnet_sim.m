clear all;
%close all;
load prisma1126_emp_sim.mat;
load network_lobe_idx.mat;

% Group network data
emphcnet = emphc_net;
empmcinet = empmci_net;
empadnet = empmad_net;

% Group indices
groups = {'hc', 'mci', 'ad'};
nets = {emphcnet, empmcinet, empadnet};
group_data = struct();

% Loop through groups and extract subnetwork data
for g = 1:length(groups)
    group_name = groups{g};
    group_lobe = nets{g};
    
    group_data.(group_name).dmn = group_lobe(:, DMN, :);
    group_data.(group_name).atn = group_lobe(:, ATN, :);
    group_data.(group_name).aun = group_lobe(:, AUN, :);
    group_data.(group_name).smn = group_lobe(:, SMN, :);
    group_data.(group_name).sun = group_lobe(:, SUN, :);
    group_data.(group_name).vis = group_lobe(:, VIS, :);
end

% Time range (2:11)
range = 2:2;

% Initialize results structure for means and stds
means = struct();
stds = struct();

% Define subnetworks
subnets = {'dmn', 'atn', 'aun', 'smn', 'sun', 'vis'};
%sublobes = {'frontal', 'occipital', 'parietal', 'temporal'};
% Loop through subnetworks to calculate means and stds
for s = 1:length(subnets)
    sublobe = subnets{s};
    
    for g = 1:length(groups)
        group_name = groups{g};
        
        % Extract network data for the specific subnetwork and group
        group_data_new = group_data.(group_name).(sublobe);
        
        % Calculate the mean and std for the specified range
        group_data_mean = squeeze(mean(group_data_new(range, :, :), 1)); % Mean over the range
        means.(group_name).(sublobe) = mean(group_data_mean, 1); % Mean across the first dimension (across time)
        stds.(group_name).(sublobe) = std(mean(group_data_mean, 1)); % Standard deviation across the first dimension
    end
end
% 自定义颜色
colors = [
    73 108 136;
    169 184 198;
    254 178 180
]/255;

% 定义子网络名称
%sublobes = {'dmn', 'atn', 'aun', 'smn', 'sun', 'vis'};
subnets = {'dmn', 'atn', 'aun', 'smn', 'sun', 'vis'};
% 创建图形窗口
figure('Color', [1, 1, 1]);
%subnets = {'frontal', 'occipital', 'parietal', 'temporal'};
% 创建子图
for s = 1:length(subnets)
    subplot(2, 3, s);  % 创建2行3列的子图，第s个子图

    % 计算每个子网络的均值和标准差
    % HC
    hc_mean = mean(means.hc.(subnets{s}));
    hc_std = stds.hc.(subnets{s});

    % MCI
    mci_mean = mean(means.mci.(subnets{s}));
    mci_std = stds.mci.(subnets{s});

    % AD
    ad_mean = mean(means.ad.(subnets{s}));
    ad_std = stds.ad.(subnets{s});

    % 绘制Bar图
    b = bar([hc_mean, mci_mean, ad_mean], 'BarWidth', 0.6);
    hold on;

    % 设置条形图颜色
    b.FaceColor = 'flat';
    b.CData(1,:) = colors(1,:);  % HC 颜色
    b.CData(2,:) = colors(2,:);  % MCI 颜色
    b.CData(3,:) = colors(3,:);  % AD 颜色

    % 添加误差条
    errorbar(1, hc_mean, hc_std, 'k.'); % HC
    errorbar(2, mci_mean, mci_std, 'k.'); % MCI
    errorbar(3, ad_mean, ad_std, 'k.'); % AD
    
    % 设置图形属性
    set(gca, 'XTick', 1:3, 'XTickLabel', {'HC', 'MCI', 'AD'});  % 设置X轴标签
    ylim([0.05, max([hc_mean + hc_std, mci_mean + mci_std, ad_mean + ad_std]) + 0.025]);  % 设置Y轴范围
    ylabel('value');
    title([subnets{s}, ' network']);  % 子图标题
    grid on;
end

