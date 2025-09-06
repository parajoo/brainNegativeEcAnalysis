% clear all
%close all
clear all
load sim_net_neww.mat

%load net_ad62hc204_d.mat
model_net_ad = simad_net;
model_net_hc = simhc_net;
%% color
% red = [0.525 0.324 0.53];
% blue = [0.329 0.594 0.525];
%red = [246/255 202/255 229/255];
red = [255/255 190/255 122/255];
blue = [130/255 176/255 210/255];
%%
range = 2:9;%2:11
for i = 1:4
    model_mean(i,:) = mean(squeeze(model_net_ad(range,:,i)),2);  % ？ 感觉net.m中的i从11改为2，这里range也改为1：2也不会影响啊，毕竟R_mean都只取第一列。
    model_std(i,:) = std(squeeze(model_net_ad(range,:,i))');%%just apply the yuzhi(1:9)
    emp_mean(i,:) = mean(squeeze(model_net_hc(range,:,i)),2);
    emp_std(i,:) = std(squeeze(model_net_hc(range,:,i))');
end
LABEL = {'聚类系数','特征最短路径长度','全局效率','局部效率'};
%% 阈值为0
model = squeeze(model_mean(:,1));
HC = squeeze(emp_mean(:,1));
R_mean = [squeeze(model_mean(:,1)),squeeze(emp_mean(:,1))];
R_std = [squeeze(model_std(:,1)),squeeze(emp_std(:,1))];
figure('Color',[1 1 1]);
%legend('ASD','HC','rASD');
for i = 1:4
    subplot(2,2,i)
    mean = R_mean(i,:);
    std = R_std(i,:);
    handles = bar(1:2,mean,0.5,'linewidth',0.7);
    handles.FaceColor = 'flat';
%     handles.CData(1,:) = [0.86 0.62 0.86];
%     handles.CData(2,:) = [0.7059 0.7804 0.9059];
%     handles.CData(3,:) = [0.7725 0.8784 0.7059];% 0.7725 0.8784 0.7059
    handles.CData(1,:) = red;
    handles.CData(2,:) = blue;
    handles.FaceAlpha = 0.7;
    hold on;
    hErrorbar  = errorbar(1:2,mean,std, 'k');
    set(hErrorbar,'color','K','marker', 'none', 'linestyle', 'none', 'linewidth', 1);
%     if i==1
%         ylabel('聚类系数','fontsize',10);
% %         ylim([0.2 0.55])
%     elseif i==2
%         ylabel('特征最短路径长度','fontsize',10);
% %         ylim([0.5 3.5])
%     elseif i==3
%         ylabel('全局效率','fontsize',10);
% %         ylim([0 0.5])
%     else
%         ylabel('局部效率','fontsize',10);
% %         ylim([0.25 0.5])
%     end
%  fre2={'ASD','HC','ASD+Control'};
    %fre2={' ',' ',' '};
    set(gca,'XTickLabel',{'AD','HC'})
    %set(gca,'XTickLabel',{'emp-ad','emp-hc'})
    box off
    
end
%legend{'ASD','HC','rASD'};x
%format long
kkk = 4
[a1 b1] = ttest2(squeeze(model_net_ad(kkk,:,1)),squeeze(model_net_hc(kkk,:,1)))
[a2 b2] = ttest2(squeeze(model_net_ad(kkk,:,2)),squeeze(model_net_hc(kkk,:,2)))
[a3 b3] = ttest2(squeeze(model_net_ad(kkk,:,3)),squeeze(model_net_hc(kkk,:,3)))
[a4 b4] = ttest2(squeeze(model_net_ad(kkk,:,4)),squeeze(model_net_hc(kkk,:,4)))
% kkk = 3
% [a1 b1] = ttest2(squeeze(model_net_ad(kkk,:,1)),squeeze(model_net_hc(kkk,:,1)))
% [a2 b2] = ttest2(squeeze(model_net_ad(kkk,:,2)),squeeze(model_net_hc(kkk,:,2)))
% [a3 b3] = ttest2(squeeze(model_net_ad(kkk,:,3)),squeeze(model_net_hc(kkk,:,3)))
% [a4 b4] = ttest2(squeeze(model_net_ad(kkk,:,4)),squeeze(model_net_hc(kkk,:,4)))
% if b1<0.05
%     text(2.5,0.52,'*','FontSize',20)
% end
clear mean
model_net_ad_a = mean(model_net_ad(range,:,:), 1);
model_net_hc_a = mean(model_net_hc(range,:,:), 1);
model_net_adm = squeeze(model_net_ad_a);
model_net_hcm = squeeze(model_net_hc_a);
[a11 b11] = ttest2(model_net_adm(range,1),model_net_hcm(range,1))
[a22 b22] = ttest2(model_net_adm(range,2),model_net_hcm(range,2))
[a33 b33] = ttest2(model_net_adm(range,3),model_net_hcm(range,3))
[a44 b44] = ttest2(model_net_adm(range,4),model_net_hcm(range,4))
