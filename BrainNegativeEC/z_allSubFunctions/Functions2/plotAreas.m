clear all; close all
%% %% Areas - Sankey figure
% Sankey figure
addpath('/home/zengxin/181subs/sankey/matlab-sankey-diagram-master')
%% area-based
load('/home/zengxin/1_depression/label_area.mat')
index = {1:24;25:32;33:48;49:68;69:80;81:90};
% the original label-net is wrong !!!
% hc
load('/home/zengxin/1_depression/hc/data_need_cluster_finalWC5000.mat')
sfc=data_need_cluster.FCsim; sfc = sfc(label_area,label_area);
efc = data_need_cluster.FCemp;  efc = efc(label_area,label_area); N=size(efc,1);
shc_area = toArea(sfc,index); ehc_area = toArea(efc,index);
% dep1
load('/home/zengxin/1_depression/dep1/data_need_cluster_finalWC5000.mat')
sfc=data_need_cluster.FCsim; sfc = sfc(label_area,label_area);
efc = data_need_cluster.FCemp;  efc = efc(label_area,label_area); N=size(efc,1);
sdep1_area = toArea(sfc,index); edep1_area = toArea(efc,index);
% dep2
load('/home/zengxin/1_depression/dep2/data_need_cluster_finalWC5000.mat')
sfc=data_need_cluster.FCsim; sfc = sfc(label_area,label_area);
efc = data_need_cluster.FCemp;  efc = efc(label_area,label_area); N=size(efc,1);
sdep2_area = toArea(sfc,index); edep2_area = toArea(efc,index);
save('all_areas','shc_area','ehc_area','sdep1_area','edep1_area',"sdep2_area","edep2_area");

arealabel=["PFR","FR","PR","TR","OR","SUB"];
para_area={'shc_area','sdep1_area','sdep2_area','ehc_area','edep1_area','edep2_area'};
toSankey(para_area,arealabel);

%% net-based
load('/home/zengxin/1_depression/label_net_right.mat')
index = {1:20;21:36;37:48;49:62;63:70;71:90};
% the original label-net is wrong !!!
% hc
load('/home/zengxin/1_depression/hc/data_need_cluster_finalWC5000.mat')
sfc=data_need_cluster.FCsim; sfc = sfc(label_net_right,label_net_right);
efc = data_need_cluster.FCemp;  efc = efc(label_net_right,label_net_right); N=size(efc,1);
shc_area = toArea(sfc,index); ehc_area = toArea(efc,index);
% dep1
load('/home/zengxin/1_depression/dep1/data_need_cluster_finalWC5000.mat')
sfc=data_need_cluster.FCsim; sfc = sfc(label_net_right,label_net_right);
efc = data_need_cluster.FCemp;  efc = efc(label_net_right,label_net_right); N=size(efc,1);
sdep1_area = toArea(sfc,index); edep1_area = toArea(efc,index);
% dep2
load('/home/zengxin/1_depression/dep2/data_need_cluster_finalWC5000.mat')
sfc=data_need_cluster.FCsim; sfc = sfc(label_net_right,label_net_right);
efc = data_need_cluster.FCemp;  efc = efc(label_net_right,label_net_right); N=size(efc,1);
sdep2_area = toArea(sfc,index); edep2_area = toArea(efc,index);
save('all_areas','shc_area','ehc_area','sdep1_area','edep1_area',"sdep2_area","edep2_area");

netabel=["DMN","ATN","AUN","VIS","SMN","SUN"];
para_area={'shc_area','sdep1_area','sdep2_area','ehc_area','edep1_area','edep2_area'};
toSankey(para_area,netabel);


%% %% Areas - PMS areas
% according to lobe areas, plot different lobes' KLD, such as 24-areas
% frontal lobe. Input 400*24 not 400*90 bold data. And obtain 6 PMS
% results of 6 lobes. Then figure them(same methods used in emp data, so could plot the two data's bars together).
load('/home/zengxin/1_depression/label_area.mat')
index = {1:24;25:32;33:48;49:68;69:80;81:90};
% hc
load('/home/zengxin/1_depression/hc/data_need_cluster_finalWC5000.mat')
shc_bold=data_need_cluster.allbolds2;
shc_pmsArea = pmsArea(shc_bold,index,label_area);
load /home/zengxin/1_depression/dataHC/signal_hc_90p.mat
ehc_bold = signal_hc_90p;
ehc_pmsArea = pmsArea(ehc_bold,index,label_area);
% dep1
load('/home/zengxin/1_depression/dep1/data_need_cluster_finalWC5000.mat')
sdep1_bold=data_need_cluster.allbolds2;
sdep1_pmsArea = pmsArea(sdep1_bold,index,label_area);
load /home/zengxin/1_depression/dataDep/1_signal/signal_dep1_90p.mat
edep1_bold = signal_dep1_90p;
edep1_pmsArea = pmsArea(edep1_bold,index,label_area);
% dep2
load('/home/zengxin/1_depression/dep2/data_need_cluster_finalWC5000.mat')
sdep2_bold=data_need_cluster.allbolds2;
sdep2_pmsArea = pmsArea(sdep2_bold,index,label_area);
load /home/zengxin/1_depression/dataDep/1_signal/signal_dep2_90p.mat
edep2_bold = signal_dep2_90p;
edep2_pmsArea = pmsArea(edep2_bold,index,label_area);

%% bars
figure;
arealabel=["PFR","FR","PR","TR","OR","SUB"];
for i=1:6
sim=[shc_pmsArea(i,1),sdep1_pmsArea(i,1),sdep2_pmsArea(i,1),shc_pmsArea(i,2),sdep1_pmsArea(i,2),sdep2_pmsArea(i,2),...
    shc_pmsArea(i,3),sdep1_pmsArea(i,3),sdep2_pmsArea(i,3)];
emp=[ehc_pmsArea(i,1),edep1_pmsArea(i,1),edep2_pmsArea(i,1),ehc_pmsArea(i,2),edep1_pmsArea(i,2),edep2_pmsArea(i,2),...
    ehc_pmsArea(i,3),edep1_pmsArea(i,3),edep2_pmsArea(i,3)];
pstatesMatrix = [ sim;emp ];
%figure; 
subplot(2,3,i);
b3 = bar3(pstatesMatrix);  title([arealabel(i),' substates']); xticklabels({'hc-A','dep1-A','dep2-A','hc-B',...
    'dep1-B','dep2-B','hc-C','dep1-C','dep2-C',}); yticklabels({'sim','emp'}); 
for k = 1:length(b3)
    zdata = b3(k).ZData;
    b3(k).CData = zdata;
    b3(k).FaceColor = "interp";
end
colorbar('Location','southoutside')
view(gca,[-28 20]);

end








%% many functions
function res = toArea(fc,index)

%row as i, column as j 
for i=1:6
    for j=1:6
        % res(i,j) = mean(mean(fc(index{i},index{j})));
        res(i,j) = sum(sum(fc(index{i},index{j})));
    end
end

end

function toSankey(para_area,arealabel)
load all_areas.mat
for i=1:6; reduction{i} = eval(para_area{i}); reduction{i} = round(reduction{i}); end; 
figure;for i=1:6;subplot(2,3,i);imagesc(reduction{i});colormap('jet');caxis([0 210]);end;

links_1p={};links_2p={};
trii=triu(ones(21));
for m=1:length(para_area)
    for i=1:length(arealabel)
        for j=1:length(arealabel)
            if i~=j && trii(i,j)==1 %get half matrix and no diagonal
            links_1p{m,i,j}=[arealabel(i),arealabel(j),(reduction{m}(i,j))];
            end
        end
    end
end
%plot 
links_1p=links_1p(~cellfun('isempty',links_1p)); % remove '[]' in links_1p
links_2p=reshape(links_1p,[m,(i*j-i)/2]); links_2p=links_2p';
figure; 
for m=1:6
    sk=figure;
    for k=1:(i*j-i)/2
    links{k,1}=char(links_2p{k,m}(1));
    links{k,2}=char(links_2p{k,m}(2));links{k,3}=eval(links_2p{k,m}(3));
    end
    SK=SSankey(links(:,1),links(:,2),links(:,3));
    SK.draw();
    close (sk)
    %subplot(2,3,m);
    figure;
    BCC=biChordChart(SK.AdjMat,'Arrow','on','Label',SK.NodeList);
    BCC.Label={'','','','','',''};  % delete area label
    % get colors -------------------------------------
%     color=cell(1,21);
%     for i=1:21
%         r=randi([0,255]);
%         g=randi([0,255]);
%         b=randi([0,255]);
%         color{i}=[r./255,g./255,b./255];
%     end
%     color=color';
%     color=cell2mat(color);
%     save('color','color');
    % -------------------------------------------------
    load color.mat
    BCC.CData=color;
    BCC=BCC.draw();
    BCC.setFont('FontName','Cambria','FontSize',20)
     BCC.tickState('on');
     BCC.setLabelRadius(1.34)
     BCC.tickLabelState('on')

end
end

function Pstate_mean = pmsArea(BOLD_Signals, index, label_area)
ds = 800; % TR
load('/home/zengxin/1_depression/empiricalLEiDA_BOLDS.mat')
for i=1:size(BOLD_Signals,3)
    BOLD_Signal=BOLD_Signals(:,:,i);
    BOLD_Signal=BOLD_Signal(label_area,:); Vemp=Vemp(:,label_area);
    for j=1:length(index)
        bold = BOLD_Signal(index{j},:); vemp = Vemp(:,index{j});
        [PTRsim,Pstates,LTime]=LEiDA_fix_cluster2(bold,3,vemp,ds/1000);
        Pstate_area(j,:) = Pstates;
    end
    Pstate_ntrial{i}=Pstate_area;
end
% 使用 cellfun 函数计算每个矩阵的平均
meanMatrix = cellfun(@(x) mean(x, 3), Pstate_ntrial, 'UniformOutput', false);
% 将每个矩阵的平均值合并为一个 3x6 矩阵
Pstate_mean = mean(cat(3, meanMatrix{:}), 3);
end





