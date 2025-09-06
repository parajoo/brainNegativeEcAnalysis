%% brainnet--eigenvector 
clear all
close all
load ('trio0718_neEmpFcRes.mat','neec_results')
idx = [6,7,8,9];
egNodeFile = readtable('Node_AAL90.txt');
%nodeColor = [2,2.7,2.4,2.1,1.8,1.5,1.22,0.9,0.6,0.3];
nodeColor = [4,3.8,3.6,3.4,1.8,1.5,1.2,0.9,0.6,0.3];
sizeVec = [3:-0.2:1.2];
for i=1:length(idx)
    hcranki = neec_results(i).ec_iHc;
    hccolorVec = 0.1*ones(90,1);
    hcsizeColor = 0.1*ones(90,1);
    for j = 1:length(hcranki)
       hccolorVec(hcranki(j)) = nodeColor(j);
       hcsizeColor(hcranki(j)) = sizeVec(j);
    end
    hccurNodeFile = egNodeFile;
    hccurNodeFile.Var4 = hccolorVec;
    hccurNodeFile.Var5 = hcsizeColor;
    cd /home/zengmin/model/pms_tianjin_data/fig0821/
    writetable(hccurNodeFile,sprintf('thc_nefc0812%dRank10.txt',i),'Delimiter',' ');
    cd /home/zengmin/model/pms_tianjin_data/
    mciranki = neec_results(i).ec_iMci;
    mcicolorVec = 0.1*ones(90,1);
    mcisizeColor = 0.1*ones(90,1);
    for j = 1:length(mciranki)
       mcicolorVec(mciranki(j)) = nodeColor(j);
       mcisizeColor(mciranki(j)) = sizeVec(j);
    end
    mcicurNodeFile = egNodeFile;
    mcicurNodeFile.Var4 = mcicolorVec;
    mcicurNodeFile.Var5 = mcisizeColor;
    cd /home/zengmin/model/pms_tianjin_data/fig0821/
    writetable(mcicurNodeFile,sprintf('tmci_nefc0812%dRank10.txt',i),'Delimiter',' ');
    cd /home/zengmin/model/pms_tianjin_data/
    adranki = neec_results(i).ec_iAd;
    adcolorVec = 0.1*ones(90,1);
    adsizeColor = 0.1*ones(90,1);
    for j = 1:length(adranki)
       adcolorVec(adranki(j)) = nodeColor(j);
       adsizeColor(adranki(j)) = sizeVec(j);
    end
    adcurNodeFile = egNodeFile;
    adcurNodeFile.Var4 = adcolorVec;
    adcurNodeFile.Var5 = adsizeColor;
    cd /home/zengmin/model/pms_tianjin_data/fig0821/
    writetable(adcurNodeFile,sprintf('tad_nefc0812%dRank10.txt',i),'Delimiter',' ');
    cd /home/zengmin/model/pms_tianjin_data/
end

%% imagesc
% clear all
% close all
% rng(1);
% load hc979_data.mat
% A = hc978_ec;
% upper_mask = triu(true(size(A)), 1); 
% lower_mask = tril(true(size(A)), -1); 
% 
% upper_pos = A;
% upper_pos(~upper_mask | upper_pos < 0) = 0; 
% lower_neg = A;
% lower_neg(~lower_mask | lower_neg > 0) = 0; 
% % 合并数据并归一化
% combined_data = zeros(size(A));
% combined_data(upper_mask) = upper_pos(upper_mask);
% combined_data(lower_mask) = (lower_neg(lower_mask)); % 取负值的绝对值
% 
% max_neg = max(abs(lower_neg(:)), [], 'omitnan');
% max_pos = max(upper_pos(:), [], 'omitnan');
% overall_max = max([max_neg, max_pos]);
% 
% normalized_data = combined_data ; 
% 
% num_colors = 256;
% gray_part = linspace(0.8, 0.2, num_colors/2)' * [1 1 1]; 
% blue_part = [linspace(0.9, 0, num_colors/2)' linspace(0.9, 0, num_colors/2)' ones(num_colors/2, 1)]; % 蓝色渐变：浅蓝→深蓝
% custom_cmap = [gray_part; blue_part];
% 
% figure('Color',[1 1 1]);
% h = imagesc(normalized_data, [0 1]);
% colormap(custom_cmap);
% c = colorbar;
% 
% c.Ticks = [0 0.5 1];
% c.TickLabels = {num2str(-overall_max, '%.2f'), '0', num2str(overall_max, '%.2f')};
% 
% set(h, 'AlphaData', ~isnan(combined_data));
% 
% axis square;
% grid off;