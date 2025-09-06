
load data_need_iter_hc.mat;
data_need = data_need_iter_ad.data_need_ad;
SC_optimal_store = data_need.SC_iter;
% 实验结构连接
load SC_AD_ad.mat
SC = mean(SC_AD_ad(1:90,1:90,:),3);
%
Sim_BestValue = data_need.Sim_Bestvalue;
for ii = 1:20
%% 半球内
SC_Sim_Optimal = squeeze(SC_optimal_store(:,:,ii));
% 左上
origin1 = SC(1:45,1:45);
optimal1 = SC_Sim_Optimal(1:45,1:45);
[n1,all_link1] = link_statistics(origin1,optimal1);
[x1,y1,all_link_1] = link_statistics_change(origin1,optimal1);
% 右下
origin2 = SC(46:90,46:90);
optimal2 = SC_Sim_Optimal(46:90,46:90);
[n2,all_link2] = link_statistics(origin2,optimal2);
[x2,y2,all_link_2] = link_statistics_change(origin2,optimal2);
%% 半球间
% 左下
origin3 = SC(46:90,1:45);
optimal3 = SC_Sim_Optimal(46:90,1:45);
[n3,all_link3] = link_statistics(origin3,optimal3);
[x3,y3,all_link_3] = link_statistics_change(origin3,optimal3);
% 右上
origin4 = SC(1:45,46:90);
optimal4 = SC_Sim_Optimal(1:45,46:90);
[n4,all_link4] = link_statistics(origin4,optimal4);
[x4,y4,all_link_4] = link_statistics_change(origin4,optimal4);
new_Intra(ii) = (n1+n2)/(all_link1+all_link2+all_link3+all_link4)*100;
new_Inter(ii) = (n3+n4)/(all_link1+all_link2+all_link3+all_link4)*100;
%% 增强边的数量占经验SC总边数(不含0)的百分比
new_Intra_strength(ii) = (x1+x2-(n1+n2))/(all_link_1+all_link_2+all_link_3+all_link_4)*100; % 加边也算增强，减去加边的数量
new_Inter_strength(ii) = (x3+x4-(n3+n4))/(all_link_1+all_link_2+all_link_3+all_link_4)*100;
%% 减弱边的数量占经验SC总边数(不含0)的百分比
new_Intra_weaken(ii) = (y1+y2)/(all_link_1+all_link_2+all_link_3+all_link_4)*100; % 加边也算增强，减去加边的数量
new_Inter_weaken(ii) = (y3+y4)/(all_link_1+all_link_2+all_link_3+all_link_4)*100; 
end
figure(1)
SC = data_need.SC_Sim_Optimal;
FC = data_need.FC_Sim_Optimal;
subplot(3,2,1)
imagesc(SC);
view(0,-90);
% title('ASD_ fc');
colormap('jet');
% caxis([0,0.35])
axis xy;
colorbar('eastoutside');
subplot(3,2,2)
imagesc(FC);
view(0,-90);
% title('ASD_ fc');
colormap('jet');
% caxis([0,0.35])
axis xy;
colorbar('eastoutside');
%%
x = 0.05:0.05:1;
% figure;
subplot(3,2,[3 4]);
plot(Sim_BestValue(:,2),Sim_BestValue(:,1),'b-*');hold on;
plot(0.3,Sim_BestValue(13,1),'r-*');%最高点
xlim([0,1]);
xlabel('容差','FontWeight','bold');
% ylabel({'Fitting(Correlation)';'between empirical';'and simulated FC'},'FontWeight','bold');
ylabel({'实验与模拟';'功能连接的相关性'},'FontWeight','bold');
box off
subplot(3,2,[5 6]);
%p1 = plot(x,fliplr(new_Inter),'r-*','linewidth',2);
p1 = plot(x,fliplr(new_Inter),'b-*');hold on;%
plot(0.3,new_Inter(13),'r-*');%最高点
hold on
p2 = plot(x,fliplr(new_Intra),'k-*');hold on;
plot(0.3,new_Intra(13),'r-*');%最高点
hold off
LEG1=legend([p1 p2],{'半脑间连接','半脑内连接'});
%set(LEG1,'box','off','FontSize',18);
box off
% set(gca,'Ytick',[0,20,40,60,80]);
%set(gca,'fontsize',20,'linewidth',1.5);
xlabel('容差','FontWeight','bold');
ylabel({'新连接(%)'},'FontWeight','bold');
set(figure(1),'position',[100 100 700 800]);
%%
function [n,all_link]=link_statistics(origin,optimal)
n = 0;
all_link = 0;
for i = 1:45
    for j = 1:45
        if  origin(i,j) == 0 && optimal(i,j) ~= 0     
            n = n + 1;
        end
        if origin(i,j) ~= 0
            all_link = all_link + 1;
        end
    end
end
end

%% 改边(增强/减弱)
function [x,y,all_link] = link_statistics_change(origin,optimal)
x = 0; %增强的边数(含加边数量)
y = 0; %减弱的边数
all_link = 0;
for i = 1:45
    for j = 1:45
        if optimal(i,j) - origin(i,j) > 0
            x = x + 1;
        end
        if optimal(i,j) - origin(i,j) < 0
            y = y + 1;
        end
        if origin(i,j) ~= 0
            all_link = all_link + 1;
        end
    end
end
end
