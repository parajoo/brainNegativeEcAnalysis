clear all
close all
% load ad_iter_0427.mat;
load sc_ad0.mat
load BEI_ad100.mat
N = 90;
lll = length(results);
%lll = 1;
SC_optimal = zeros(N,N,lll);
for jjj = 1:lll
    SC_optimal(:,:,jjj) = results(jjj).SCnew;
end
%SC_optimal = data_need.SC_iter;
SC = sc_ad0;
%
%Sim_BestValue = data_need.Sim_Bestvalue;
for ii = 1:lll
%% ������
n1  = 0; all_link1 = 0;x1 = 0;y1=0;all_link_1 = 0;
n2  = 0; all_link2 = 0;x2 = 0;y2=0;all_link_2 = 0;
n3  = 0; all_link3 = 0;x3 = 0;y3=0;all_link_3 = 0;
n4  = 0; all_link4 = 0;x4 = 0;y4=0;all_link_4 = 0;
SC_Sim_Optimal = squeeze(SC_optimal(:,:,ii));
% ����
origin1 = SC(1:45,1:45);
optimal1 = SC_Sim_Optimal(1:45,1:45);
[n1,all_link1] = link_statistics(origin1,optimal1);
[x1,y1,all_link_1] = link_statistics_change(origin1,optimal1);
% ����
origin2 = SC(46:90,46:90);
optimal2 = SC_Sim_Optimal(46:90,46:90);
[n2,all_link2] = link_statistics(origin2,optimal2);
[x2,y2,all_link_2] = link_statistics_change(origin2,optimal2);
%% �����
% ����
origin3 = SC(46:90,1:45);
optimal3 = SC_Sim_Optimal(46:90,1:45);
[n3,all_link3] = link_statistics(origin3,optimal3);
[x3,y3,all_link_3] = link_statistics_change(origin3,optimal3);
% ����
origin4 = SC(1:45,46:90);
optimal4 = SC_Sim_Optimal(1:45,46:90);
[n4,all_link4] = link_statistics(origin4,optimal4);
[x4,y4,all_link_4] = link_statistics_change(origin4,optimal4);
new_Intra(ii) = (n1+n2)/(all_link1+all_link2+all_link3+all_link4)*100;
new_Inter(ii) = (n3+n4)/(all_link1+all_link2+all_link3+all_link4)*100;
%% ��ǿ�ߵ�����ռ����SC�ܱ���(����0)�İٷֱ�
new_Intra_strength(ii) = (x1+x2-(n1+n2))/(all_link_1+all_link_2+all_link_3+all_link_4)*100; % �ӱ�Ҳ����ǿ����ȥ�ӱߵ�����
new_Inter_strength(ii) = (x3+x4-(n3+n4))/(all_link_1+all_link_2+all_link_3+all_link_4)*100;
%% �����ߵ�����ռ����SC�ܱ���(����0)�İٷֱ�
new_Intra_weaken(ii) = (y1+y2)/(all_link_1+all_link_2+all_link_3+all_link_4)*100; % �ӱ�Ҳ����ǿ����ȥ�ӱߵ�����
new_Inter_weaken(ii) = (y3+y4)/(all_link_1+all_link_2+all_link_3+all_link_4)*100; 
end
%%
x = 1:lll;
figure('Color',[1 1 1]);
p1 = plot(x,new_Inter,'b-*');hold on;
hold on
p2 = plot(x,new_Intra,'k-*');hold on;
hold off
LEG1=legend([p1 p2],{'���Լ�����','����������'});
box off
xlabel('iteration','FontWeight','bold');
ylabel({'������(%)'},'FontWeight','bold');
%%
x = 1:lll;
figure('Color',[1 1 1]);
p1 = plot(x,new_Inter_strength,'b-*');hold on;
hold on
p2 = plot(x,new_Intra_strength,'k-*');hold on;
hold off
LEG1=legend([p1 p2],{'���Լ�����','����������'});
box off
xlabel('iteration','FontWeight','bold');
ylabel({'������(%)'},'FontWeight','bold');
title('added link(AD - 0.001)')
%%
figure('Color',[1 1 1]);
p1 = plot(x,new_Inter_weaken,'b-*');hold on;
hold on
p2 = plot(x,new_Intra_weaken,'k-*');hold on;
hold off
LEG1=legend([p1 p2],{'���Լ�����','����������'});
box off
xlabel('iteration','FontWeight','bold');
ylabel({'������(%)'},'FontWeight','bold');
title('weakened link(AD-0.001)')
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

%% �ı�(��ǿ/����)
function [x,y,all_link] = link_statistics_change(origin,optimal)
x = 0; %��ǿ�ı���(���ӱ�����)
y = 0; %�����ı���
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
