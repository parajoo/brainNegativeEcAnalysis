% close all
% load PTmmse.mat
% plot_netproperty_scorel(emphcNetC,empadNetC,63,pthc,ptadMmse,0,7,'lobeCC','MCI')
function plot_netproperty_score(emphc_lobeE,empad_lobeE,subHcAll,hc_scale,ad_scale,scaleIdx,areaIdx,name1,name2)
figure_name = name1;
if areaIdx == 7
    idx_netOrlobe = 9;%8:subnet  9:lobe
elseif areaIdx == 6
    idx_netOrlobe = 8;
end
sub_hc = size(hc_scale,1);
sub_ad = size(ad_scale,1);
%% scaleIdx == 0:MMSE scaleIdx == 1:MOCA
if scaleIdx ==0
    scaleName = 'MMSE';
    jjjMax = 6;
    hc_scale_new = zeros(sub_hc,6);
    for i = 1:sub_hc
        hc_scale_new(i,1:5) = hc_scale(i,1:5);
        hc_scale_new(i,6) = sum(hc_scale(i,6:11));
    end
    ad_scale_new = zeros(sub_ad,6);
    for i = 1:sub_ad
        ad_scale_new(i,1:5) = ad_scale(i,1:5);
        ad_scale_new(i,6) = sum(ad_scale(i,6:11));
    end
elseif scaleIdx ==1
    scaleName = 'MOCA';
    jjjMax = 8;
    hc_scale_new = hc_scale;
    ad_scale_new = ad_scale;
end
%% subplot
for jjj = 1:jjjMax%6:mmse 8:moca
    subscore = jjj;
    data_cc = zeros(sub_ad+sub_hc,idx_netOrlobe);
    for i=1:sub_ad
        data_cc(i,1) = 1;
        data_cc(i,2) =ad_scale_new(i,subscore);
        for j=3:idx_netOrlobe%9:lobe  8:subnet
            if areaIdx == 7
                lobej = empad_lobeE.(sprintf('lobe%d',j-2)).mean;
            elseif areaIdx ==6
                lobej = empad_lobeE.(sprintf('subnet%d',j-2)).mean; 
            end
            data_cc(i,j) = lobej(i);
        end
    end
    for i = 1:sub_hc
        data_cc(i+sub_ad,2) = hc_scale_new(i,subscore);
        for j=3:idx_netOrlobe%9:lobe  8:subnet
            if areaIdx == 7
                lobej = emphc_lobeE.(sprintf('lobe%d',j-2)).mean;
            elseif areaIdx ==6
                lobej = emphc_lobeE.(sprintf('subnet%d',j-2)).mean; 
            end
            data_cc(i+sub_ad,j) = lobej(i);
        end
    end
    data = data_cc;
    group = data(:,1);
    mmse = data(:,2);
    network_properties = data(:,3:idx_netOrlobe);%9:lobe  8:subnet

    % 脑区名称
    if idx_netOrlobe==9
        regions = {'Frontal','Temporal','Occipital','Parietal','BasalGanglia','HAroad','Limbic'};
    elseif idx_netOrlobe == 8
        regions = {'DMN','SUN','SMN','VIS','ATN','AUN'};
    end
    mci_idx = (group == 1);
    admmse = mmse(mci_idx);
    ad_net = network_properties(mci_idx,:);n_regions = size(ad_net,2);
    p_values = zeros(n_regions,1);
    corr_coeffs = zeros(n_regions,1);

    for r = 1:n_regions
        [rho, p] = corr(ad_net(:,r), admmse, 'type','Spearman');  % 非正态分布用Spearman
        corr_coeffs(r) = rho;
        p_values(r) = p;
    end

    % 多重比较校正（FDR）
    %[~, ~, adj_p] = fdr_bh(p_values, 0.05,'pdep');  % 需要FDR函数：https://www.mathworks.com/matlabcentral/fileexchange/27418-fdr_bh
    adj_p = p_values;
    result_table = table(regions', corr_coeffs, p_values, adj_p,...
        'VariableNames',{'Region','Correlation','PValue','AdjP'});
    disp(result_table);
    figure('Color',[1 1 1])
    for r = 1:n_regions
        if idx_netOrlobe==9
            subplot(3,3,r);%(33r:lobe)  (23r:subnet)
        elseif idx_netOrlobe == 8
            subplot(2,3,r);
        end
        scatter(ad_net(:,r), admmse, 50, 'filled', 'MarkerFaceColor',[154 201 219]./255);

        % 添加趋势线
        hold on;
        p = polyfit(ad_net(:,r), admmse, 1);
        x_fit = linspace(min(ad_net(:,r)), max(ad_net(:,r)), 100);
        y_fit = polyval(p, x_fit);
        plot(x_fit, y_fit, 'color',[153 153 153]./255, 'LineWidth',2);

        % 标注统计值
        text(0.1, 0.9, sprintf('ρ=%.2f\np=%.3f', corr_coeffs(r), adj_p(r)),...
            'Units','normalized', 'FontSize',10);

        title(regions{r});
        xlabel(sprintf('%s',figure_name),'FontWeight','bold');
        if scaleIdx ==0
            ylabel(sprintf('mmse-sub%d',jjj),'FontWeight','bold');
        elseif scaleIdx ==1
            ylabel(sprintf('moca-sub%d',jjj),'FontWeight','bold');
        end
    end
    sgtitle(sprintf('%s~%s(%s)',name1,scaleName,name2));
end
%% plot empdata
subhcNew = subHcAll;
figure_name = name1;
group_name = name2;
data_simcc = zeros(sub_ad+subhcNew,idx_netOrlobe);

for i=1:sub_ad
    data_simcc(i,1) = 1;
    data_simcc(i,2) =1;
    for j=3:idx_netOrlobe%9:lobe  8:subnet
        if areaIdx == 7
            lobej = empad_lobeE.(sprintf('lobe%d',j-2)).mean;
        elseif areaIdx ==6
            lobej = empad_lobeE.(sprintf('subnet%d',j-2)).mean;
        end
        data_simcc(i,j) = lobej(i);
    end
end
for i = 1:subhcNew
    data_simcc(i+sub_ad,2) = 1;
    for j=3:idx_netOrlobe%9:lobe  8:subnet
        if areaIdx == 7
                lobej = emphc_lobeE.(sprintf('lobe%d',j-2)).mean;
            elseif areaIdx ==6
                lobej = emphc_lobeE.(sprintf('subnet%d',j-2)).mean; 
            end
        data_simcc(i+sub_ad,j) = lobej(i);
    end
end
data = data_simcc;
mmse = data(:,2);
network_properties = data(:,3:idx_netOrlobe);%9:lobe  8:subnet
group = data(:,1);
hc_idx = (group==0);
hc_net = network_properties(hc_idx,:);
% 脑区名称
if idx_netOrlobe ==9
    regions = {'Frontal','Temporal','Occipital','parietal','BasalGanglia','HAroad','Limbic'};
elseif idx_netOrlobe ==8
    regions = {'DMN','SUN','SMN','VIS','ATN','AUN'};
end
mci_idx = (group == 1);
admmse = mmse(mci_idx);
ad_net = network_properties(mci_idx,:);n_regions = size(ad_net,2);
figure('Color',[1 1 1]);
for r = 1:idx_netOrlobe - 2
    if idx_netOrlobe ==9
        subplot(3,3,r);
    elseif idx_netOrlobe == 8
        subplot(2,3,r);
    end
    h = boxplot([ad_net(:,r); hc_net(:,r)], [ones(size(ad_net,1),1); zeros(size(hc_net,1),1)],'Colors',hex2rgb('006494')','Jitter',1.5);

    title(regions{r});
    ylabel(sprintf('%s',figure_name),'FontWeight','bold');

    [~,p] = ttest2(ad_net(:,r), hc_net(:,r),'Vartype','unequal');

    text(1.5, max([ad_net(:,r); hc_net(:,r)]), sprintf('p=%.5f',p),...
        'HorizontalAlignment','center','FontWeight','bold');
    ax = gca;
    ax.FontWeight = "bold";
    ax.XTickLabel = {'HC',group_name};
end
sgtitle(sprintf('%s(%s vs HC)',figure_name,group_name));
end