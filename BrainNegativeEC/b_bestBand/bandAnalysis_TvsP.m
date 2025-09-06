% clear all
% close all
% %load results_cityp.mat
% load results_cityt.mat
% load trioBoldCell0707.mat
% nsub = length(trioBoldCell0707);
% hcidx = 1:43;
% mciidx =44:88;
% adidx = 89:140;
% timepoints = 170;
% n_areas = 90;
% TR = 2;
% for i=1:length(results_cityt)
%     band = results_cityt(i).value;
%     flp = band(1);
%     fhi = band(2);
%     [iFC_all,~] = leida_emp_trio165(trioBoldCell0707,flp,fhi,nsub,TR);
%     iFC_all_per = reshape(iFC_all,[timepoints,nsub,n_areas,n_areas]);
%     iFC_all_new = permute(iFC_all_per,[2,1,3,4]);
%     iFC_hc_emp = iFC_all_new(hcidx,:,:,:);%sub*timepoints*90*90;
%     iFC_mci_emp = iFC_all_new(mciidx,:,:,:);
%     iFC_ad_emp = iFC_all_new(adidx,:,:,:);
%     results_cityt(i).ifc_hc = iFC_hc_emp;
%     results_cityt(i).ifc_mci = iFC_mci_emp;
%     results_cityt(i).ifc_ad = iFC_ad_emp;
% end
% 
% clear all
% close all
% load results_cityp.mat
% load prisma_scale_global.mat
% nsub = 60;
% hcidx = 1:20;
% mciidx =21:38;
% adidx = 38:60;
% timepoints = 480;
% n_areas = 90;
% TR = 0.735;
% for i=1:length(results_cityp)
%     band = results_cityp(i).value;
%     flp = band(1);
%     fhi = band(2);
%     [iFC_all,~] = leida_emp_trio165(prisma_scale_global,flp,fhi,nsub,TR);
%     iFC_all_per = reshape(iFC_all,[timepoints,nsub,n_areas,n_areas]);
%     iFC_all_new = permute(iFC_all_per,[2,1,3,4]);
%     iFC_hc_emp = iFC_all_new(hcidx,:,:,:);%sub*timepoints*90*90;
%     iFC_mci_emp = iFC_all_new(mciidx,:,:,:);
%     iFC_ad_emp = iFC_all_new(adidx,:,:,:);
%     results_cityp(i).ifc_hc = iFC_hc_emp;
%     results_cityp(i).ifc_mci = iFC_mci_emp;
%     results_cityp(i).ifc_ad = iFC_ad_emp;
% end

%% 
%results_cityp= results_cityt;
% for i = 1:length(results_cityp)
%     datahc = results_cityp(i).ifc_hc;
%     datamci = results_cityp(i).ifc_mci;
%     dataad = results_cityp(i).ifc_ad;
% %     results_cityp(i).hcVar = compute_connection_variance(datahc);
% %     results_cityp(i).mciVar = compute_connection_variance(datamci);
% %     results_cityp(i).adVar = compute_connection_variance(dataad);
%     pHcVarAll(:,:,i) = compute_connection_variance(squeeze(mean(datahc,1)));
%     pMciVarAll(:,:,i) = compute_connection_variance(squeeze(mean(datamci,1)));
%     pAdVarAll(:,:,i) = compute_connection_variance(squeeze(mean(dataad,1)));
% end
% function var_matrix = compute_connection_variance(data)
%     % 输入 data: 维度为 [n_sub, n_time, n_area, n_area]
%     
%     %[n_sub, n_time, n_area, ~] = size(data);
%     [n_time, n_area, ~] = size(data);
% %     n_total = n_sub * n_time;
% n_total = n_time;
%     
%     % 预分配结果矩阵
%     var_matrix = zeros(n_area, n_area);
%     
%     data_reshaped = reshape(data, [n_total, n_area, n_area]);
% 
%     for i = 1:n_area
%         for j = 1:n_area
%             values = squeeze(data_reshaped(:, i, j));
%             var_matrix(i, j) = var(values, 0);
%         end
%     end
% end
%%
clear all
% close all
load t3groupsVar.mat
load p3groupsVar.mat
% 颜色设置：三个组别
group_colors = lines(3);  % HC/MCI/AD

figure('Color',[1 1 1]);

for band = 1:10
    subplot(2,5,band);
    hold on;
    
    % 提取每个组在当前band下的90x90矩阵
    thc = tHcVarAll(:,:,band);
    phc = pHcVarAll(:,:,band);
    tmci = tMciVarAll(:,:,band);
    pmci = pMciVarAll(:,:,band);
    tad = tAdVarAll(:,:,band);
    pad = pAdVarAll(:,:,band);
    
    % 去除对角线（可选）
    mask = triu(true(90),1);
    
    % 各组别 scatter（T机器 vs P机器）
    scatter(thc(mask), phc(mask), 15, group_colors(1,:), 'filled');  % HC
    scatter(tmci(mask), pmci(mask), 15, group_colors(2,:), 'filled'); % MCI
    scatter(tad(mask), pad(mask), 15, group_colors(3,:), 'filled');  % AD
    xlims = xlim; % 横轴范围
    ylims = ylim; % 纵轴范围
    minlim = min([xlims, ylims]);
    maxlim = max([xlims, ylims]);
    plot([minlim maxlim], [minlim maxlim], 'k--', 'LineWidth', 1); % 黑色虚线
    xlabel('Trio-var');
    ylabel('Prisma-var');
%     coeffs = polyfit(thc(mask), phc(mask),1);
%     a = coeffs(1);
%     b = coeffs(2);
%     title(sprintf('p=%.3ft+%.3f',a,b));
    %title(['Band ' num2str(band)]);
    if band==10
    legend({'HC','MCI','AD'}, 'Location','best');
    end
    %axis square;
end

sgtitle('T vs P ');
% %% SC(TvsP)
% % for i=1:length(results_cityt)
% %     
% % end
% 
% %% 
% 
% figure('Color',[1 1 1]);
% 
% for band = 1:10
%     subplot(2,5,band);
%     hold on;
%     thc = results_cityt(band).ifc_hc;
%     phc = results_cityp(band).ifc_hc;
%     diff = squeeze(mean(squeeze(mean(thc,1)),1)) - squeeze(mean(squeeze(mean(phc,1)),1));
%     imagesc(diff);colorbar;xlim([0,90]);ylim([0,90]);
%     title('thc-phc');
% end