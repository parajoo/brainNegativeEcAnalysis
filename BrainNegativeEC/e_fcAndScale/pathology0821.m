%% PMS
% close all
% v = pms_hc';
% M = [pms_hc',pms_mci',pms_ad'];  
% 
% figure('Color',[1 1 1]);  % 左边画单组
% b1 = bar(v,'FaceColor','flat');  % 'flat' 允许自定义颜色
% title('Brain state distribution');
% xlabel('PMS space');
% ylabel('probability');
% ax = gca;
% ax.FontWeight = 'bold';
% % colors1 = [
% %     hex2rgb('fff0f5')';
% %     hex2rgb('e6e6fa')';
% %     hex2rgb('b5e2fa')';
% %      hex2rgb('e5e4e2')';
% %     hex2rgb('b7e4c7')';
% %           ];
% colors1 = [hex2rgb('b7e4c7')';
%           hex2rgb('b5e2fa')';
%           hex2rgb('cccccc')';];
% 
% for i = 1:length(v)
%     b1.CData(i,:) = colors1(i,:);
% end
% 
% figure('Color',[1 1 1]);
% b2 = bar(M,'grouped');   % 每行三个柱子
% 
% title('Comparison of three groups');
% xlabel('PMS space');
% ylabel('probability');
% legend({'HC','MCI','AD'},'Box','off');
% ax = gca;
% ax.FontWeight = 'bold';
% % 自定义每组人群颜色
% colors2 = [hex2rgb('b7e4c7')';
%           hex2rgb('b5e2fa')';
%           hex2rgb('cccccc')';];
% for k = 1:3
%     b2(k).FaceColor = colors2(k,:);
% end


% clear all
% close all
% ptAdMmse = zeros(74,6);
% ptAdMmse(:,1:5) = ptadMmse(:,1:5);
% ptAdMmse(:,6) = sum(ptadMmse(:,6:11),2);


clear all
close all
load t_subArea_CCandEloc0905.mat
%load ptPathology_empEloc.mat
load ('tGroup3Fc_scale0905.mat','ad_mmse')
%% 
ad_mmseNew(:,1:5) = ad_mmse(:,1:5);
ad_mmseNew(:,6) = sum(ad_mmse(:,6:11),2);
ad_mmse = ad_mmseNew;
clear ad_mmseNew
s1 = 'AUN';
s2 = 'Local Efficiency';
s3 = 'AD';
colors = [hex2rgb('b7e4c7')';
          hex2rgb('b5e2fa')';
          hex2rgb('cccccc')';
          hex2rgb('aa98a9')'];

x  = adNetE.subnet6.mean';          
%y_all = [ptadMmse(:,1),ptadMmse(:,3),ptadMmse(:,4),ptadMmse(:,6)];
y_all = [ad_mmse(:,1),ad_mmse(:,4)];
%subscoreName = {'Registration','Attention and Excution'};
subscoreName = {'MMSE','Attention and Excution'};
curveColors = colors;

boxColors   = colors;

figure('Color',[1 1 1])
sgtitle(sprintf('%s %s:cognitive association in %s and Group differences',s1,s2,s3),'FontSize',10,'FontWeight','bold');
subplot(1,3,[1 2]); hold on
numY = size(y_all,2);

    for i = 1:numY
    y = y_all(:,i);

    % 散点
    scatter(x,y,40,'o','MarkerFaceColor',curveColors(i,:), ...
        'MarkerEdgeColor','none','MarkerFaceAlpha',0.5);

    % 回归线 + 阴影
    mdl = fitlm(x,y);
    xfit = linspace(min(x),max(x),100)';
    [ypred,ci] = predict(mdl,xfit);

    % 阴影 (置信区间)
    fill([xfit; flipud(xfit)], [ci(:,1); flipud(ci(:,2))], ...
        curveColors(i,:), 'FaceAlpha',0.2, 'EdgeColor','none');

    % 回归线
    plot(xfit,ypred,'-','Color',curveColors(i,:),'LineWidth',1.5);

    % 相关系数
    [r,p] = corr(x,y,"type","Spearman");
    yl = ylim;
    text(min(x),yl(2)-0.5*i, ...
        sprintf('%s: r = %.2f, p = %.3f',subscoreName{i},r,p), ...
        'Color',curveColors(i,:),'FontSize',8,'FontWeight','bold');
    end
xlim([min(x),max(x)])
xlabel('MeanS')
ylabel('Subscores')
ax = gca;
ax.FontWeight = 'bold';
box off
grid on

% ------------------ 右侧 (1/3): 箱线图 ------------------
load ('trio0718_EandCC_subarea.mat','adNetE','mciNetE','hcNetE')
%load('trio0718_Ms_subarea.mat','adLobeMs','mciLobeMs','hcLobeMs')
%load('sinCCandElocMs_struct.mat','hcLobeMs','mciLobeMs','adLobeMs')
HC  = hcNetE.subnet6.mean';
MCI = mciNetE.subnet6.mean';
AD  = adNetE.subnet6.mean';
[~,p12] = ttest2(HC,MCI,'Vartype','equal');
[~,p23] = ttest2(MCI,AD,'Vartype','equal');
[~,p13] = ttest2(HC,AD,'Vartype','equal');
subplot(1,3,3)
data = [HC; MCI; AD];
group = [repmat({'HC'},15,1); repmat({'MCI'},15,1); repmat({'AD'},15,1)];

boxplot(data,group,'Notch','off','Colors','k')
ylabel('MeanS')
set(gca,'FontSize',10)

% 给每个箱子填充颜色
h = findobj(gca,'Tag','Box');
for j = 1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),boxColors(length(h)-j+1,:), ...
        'FaceAlpha',0.6);
end

% ------------------ 显著性标记 ------------------
hold on
yMax = max(data);
% yMax = max(data(1:30));
% yMax = max(data);
% yMax = max(data(16:45));
offset = 0.0005;

% HC vs MCI
plot([1 2],[yMax+offset yMax+offset],'k','LineWidth',1.2)
text(1.5,yMax+offset+0.0005,getStars(p12),'HorizontalAlignment','center','FontSize',10)

% MCI vs AD
plot([2 3],[yMax+2*offset yMax+2*offset],'k','LineWidth',1.2)
text(2.5,yMax+2*offset+0.0005,getStars(p23),'HorizontalAlignment','center','FontSize',10)

% HC vs AD
plot([1 3],[yMax+3*offset yMax+3*offset],'k','LineWidth',1.2)
text(2,yMax+3*offset+0.0005,getStars(p13),'HorizontalAlignment','center','FontSize',10)
box off;
ax = gca;
ax.FontWeight='bold';

function stars = getStars(p)
    if p < 0.001
        stars = '***';
    elseif p < 0.01
        stars = '**';
    elseif p < 0.05
        stars = '*';
    else
        stars = 'n.s';
    end
end
