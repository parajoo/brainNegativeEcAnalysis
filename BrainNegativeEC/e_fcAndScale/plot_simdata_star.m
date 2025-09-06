%% plot empdata
close all
plot_simdata_starl(simhcLobeMs,simadLobeMs,'sim-LobeMs','ad',7)
function plot_simdata_starl(emphc_lobeE,empad_lobeE,figure_name,group_name,areaIdx)
subhcNew = 15;
sub_ad = 15;
if areaIdx == 7
    idx_netOrlobe = 9;
elseif areaIdx == 6
    idx_netOrlobe = 8;
end
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