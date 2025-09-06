function func_subarea_CandEloc(hc,wosti,sti,name)
    load network_lobe_idx.mat
    haroad = [hippocampal,amygdala];
    limblic_road = [insula,cingulate,paracentral,fusiform];
    clear DMN SUN SMN VIS ATN AUN
    clear hippocampal amygdala insula cingulate paracentral fusiform
    lobe_name = {frontal,temporal,occipital,parietal,basal_ganglia,haroad,limblic_road};
%% for network property
    simhc_data = mean(hc,3);
    wosti_data = mean(wosti,3);
    sti_data = mean(sti,3);
    simhc_net_mean = simhc_data;
    wosti_net_mean = wosti_data;
    sti_net_mean = sti_data;
    for i=1:length(lobe_name)
        s = sprintf('lobe%d',i);
        simhc_lobeC.(s).value= simhc_net_mean(lobe_name{i},:);
        simhc_lobeC.(s).mean= mean(simhc_net_mean(lobe_name{i},:),1);
        simhc_lobeC.(s).std= std(mean(simhc_net_mean(lobe_name{i},:),1));
        wosti_lobeC.(s).value= wosti_net_mean(lobe_name{i},:);
        wosti_lobeC.(s).mean= mean(wosti_net_mean(lobe_name{i},:),1);
        wosti_lobeC.(s).std= std(mean(wosti_net_mean(lobe_name{i},:),1));
        sti_lobeC.(s).value= sti_net_mean(lobe_name{i},:);
        sti_lobeC.(s).mean= mean(sti_net_mean(lobe_name{i},:),1);
        sti_lobeC.(s).std= std(mean(sti_net_mean(lobe_name{i},:),1));
    end
    %% figure
    data_mean = zeros(7,3);
    data_error = zeros(7,3);
    for i=1:7
        s = sprintf('lobe%d',i);
        data_mean(i,1) = mean(simhc_lobeC.(s).mean);
        data_mean(i,2) = mean(wosti_lobeC.(s).mean);
        data_mean(i,3) = mean(sti_lobeC.(s).mean);
        data_error(i,1) = simhc_lobeC.(s).std;
        data_error(i,2) = wosti_lobeC.(s).std;
        data_error(i,3) = sti_lobeC.(s).std;
    end
    %clear all
    num_groups = 3;
    num_regions = 7;
    figure('Color','white');
    hBar = bar(data_mean, 'BarWidth', 0.8);
    hold on;
    
    colors = [142 139 254;
        254 163 162;
        111 111 111]./255;
    
    for k = 1:num_groups
        hBar(k).FaceColor = colors(k,:);
        hBar(k).FaceAlpha = 0.7;
    end
    
    xPositions = zeros(num_regions, num_groups);
    for k = 1:num_groups
        xPositions(:,k) = hBar(k).XEndPoints;
    end
    
    lobe_name_char = {'frontal','temporal','occipital','parietal','basal ganglia','haroad','limblic road'};
    
    % for i = 1:num_regions
    %     for k = 1:num_groups
    %         errorbar(xPositions(i,k), data_mean(i,k), data_error(i,k),...
    %             'LineStyle', 'none',...
    %             'Color', [0.2 0.2 0.2],...
    %             'LineWidth', 1,...
    %             'CapSize', 8);
    %     end
    % end
    set(gca, 'FontSize', 12, 'LineWidth', 1.2);
    ylabel('Eloc', 'FontSize', 14,'FontWeight','bold');
    title(sprintf('%s',name), 'FontSize', 16);
    legend([hBar(1), hBar(2), hBar(3)], {'simHC', 'simAD', 'stiAD'});
    
    ax = gca;
    ax.XTickLabel = lobe_name_char;
    ax.XTickLabelRotation = 0;
    ax.XAxis.FontWeight = 'bold';
    ax.YAxis.FontWeight = 'bold';
    set(gca, 'Position', [0.1 0.15 0.85 0.75]);
    hold off;
end