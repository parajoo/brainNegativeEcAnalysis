
state = 3;
hc_20_pms = pmsSubnHc';
ad_22_pms = pmsSubnAd';
mci_18_pms = pmsSubnMci';


% for i=1:20
%     for j=1:state
%     hc_20_pms(i, j) = sum(hc_pms(:, i) == j)/timepoints;
%     end
% end
% for i=1:18
%     for j = 1:state
%     mci_18_pms(i,j) = sum(mci_pms(:,i) == j)/timepoints;
%     end
% end
% for i=1:22
%     for j=1:state
%     ad_22_pms(i, j) = sum(ad_pms(:, i) == j)/timepoints;
%     end
% end
for i = 1:3
    hc_state_data = hc_20_pms(:, i);
    ad_state_data = ad_22_pms(:, i);
    mci_state_data = mci_18_pms(:,i);
   
%     [h1, p1, ci1, stats1] = ttest2(hc_state_data, ad_state_data, 'Vartype', 'unequal');
%     [h2, p2, ci2, stats2] = ttest2(hc_state_data, mci_state_data, 'Vartype', 'unequal');
%     [h3, p3, ci3, stats3] = ttest2(ad_state_data, mci_state_data, 'Vartype', 'unequal');
[p1,h1,stats1] = ranksum(hc_state_data, ad_state_data);
[p2,h2,stats2] = ranksum(hc_state_data, mci_state_data);
[p3,h3,stats3] = ranksum(ad_state_data, mci_state_data);
    %% 输出t检验结果
    fprintf('大脑亚状态 %d 的独立样本t检验结果(HC vs AD):\n', i);
    fprintf('p值: %f\n', p1);
    if h1 == 1
        fprintf('在显著性水平0.05下，HC vs AD:s\n', i);
    else
        fprintf('在显著性水平0.05下，HC vs AD :ns\n', i);
    end
    %fprintf('t统计量: %f\n', stats1.tstat);
    %% 
    fprintf('大脑亚状态 %d 的独立样本t检验结果(HC vs MCI):\n', i);
    fprintf('p值: %f\n', p2);
    if h2 == 1
        fprintf('在显著性水平0.05下，HC vs MCI :s。\n', i);
    else
        fprintf('在显著性水平0.05下，HC vs MCI:ns。\n', i);
    end
    %fprintf('t统计量: %f\n', stats2.tstat);
    %% 
    fprintf('大脑亚状态 %d 的独立样本t检验结果(AD vs MCI):\n', i);
    fprintf('p值: %f\n', p3);
    if h3 == 1
        fprintf('在显著性水平0.05下，AD vs MCI : s。\n', i);
    else
        fprintf('在显著性水平0.05下，AD vs MCI : ns。\n', i);
    end
   % fprintf('t统计量: %f\n', stats3.tstat);
end
