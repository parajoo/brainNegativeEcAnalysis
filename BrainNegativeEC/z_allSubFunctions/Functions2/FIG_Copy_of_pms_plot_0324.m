close all
 idx = [1,3,400,570,978];
% colors = [hex2rgb('e3f2fd')';
%         hex2rgb('64b5f6')'
%         hex2rgb('bbdefb')';
%         ];
% colors = [hex2rgb('e3f2fd')';
%         hex2rgb('64b5f6')'
%         hex2rgb('bbdefb')';
%         ];
%% PMS
 colors = [hex2rgb('b7e4c7')';
          hex2rgb('b5e2fa')';
          hex2rgb('cccccc')'];
 %for i=1:length(idx)
   % pms = results(idx(i)).pms_hc_sim;
    load trioPmsCity.mat
    alpha = 0.7;
    % 创建一个柱状图
    figure('Color',[1 1 1]);
    hold on;
    
    % 绘制经验的柱状图
    for j = 1:length(pms)
        h1 = bar(j-0.4, pms(j), 'BarWidth', 0.8);
        set(h1, 'FaceColor', colors(j, :), 'FaceAlpha', alpha);
    end
    % 添加图例和其他图形属性
    xlabel('states');
    ax = gca;
    ax.FontWeight = "bold";
    ylabel('probability');
   % title('model hc vs model ad');
    set(gca, 'xtick', [0.6,1.6,2.6], 'xticklabel', {'sTP', 'sFL','sOcc'});
    
    hold off;
 %end

 %% EC plot
%  for i=1:length(idx)
%      figure('Color',[1 1 1]);
%      imagesc(results(idx(i)).SCnew);colormap('white');
%  end