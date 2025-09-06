plotPmsl('restoration of PMS space',hc895_simpms,pms_ad_sim,results(357).pms_ad_sim,'AD')
function plotPmsl(name, pms_simHC, pms_simAD, pms_stiAD, group_name)
    % 假设每个输入都是 1×4 的向量
    sim_hc = pms_simHC;
    sim_ad_withoutsti = pms_simAD;
    sim_ad_withsti = pms_stiAD;

    % 为不同的组指定颜色
    colors = [hex2rgb('e3f2fd')';    % HC
              hex2rgb('64b5f6')';    % AD
              hex2rgb('bbdefb')'];   % rAD
%     colors = [hex2rgb('b7e4c7')';
%     hex2rgb('b5e2fa')';
%     hex2rgb('cccccc')'];
    alpha = 0.5;

    figure('Color', [1 1 1]); hold on;

    nStates = length(sim_hc);  % 应为 4
    barWidth = 0.25;

    for i = 1:nStates
        % HC
        h1 = bar(i - barWidth, sim_hc(i), barWidth, ...
                 'FaceColor', colors(1,:), 'FaceAlpha', alpha);

        % AD
        h2 = bar(i, sim_ad_withoutsti(i), barWidth, ...
                 'FaceColor', colors(2,:), 'FaceAlpha', alpha);

        % rAD
        h3 = bar(i + barWidth, sim_ad_withsti(i), barWidth, ...
                 'FaceColor', colors(3,:), 'FaceAlpha', alpha);
    end

    ylabel('Probability');
    title(name);
    set(gca, 'xtick', 1:nStates, ...
             'xticklabel', {'s1', 's2', 's3', 's4','s5'});  % 你可以修改标签
    ax = gca;
    ax.FontWeight = 'bold';
    legend([h1, h2, h3], {'HC', group_name, ['r' group_name]});
    legend boxoff;
    hold off;
end