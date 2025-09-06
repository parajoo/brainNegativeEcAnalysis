% clear all
% close all
% load trio_aal116_bold_g_cut10.mat
% load ('trioIdx.mat','trio_adIdx', ...
%     'trio_mciIdx','unNormalScale_hcIdx')
% trioBoldCell = cell(141,1);
% for i = 1:length(trioBoldCell)
%     if i<44
%     trioBoldCell{i,:} = trio_aal116_bold_g_cut10(:,1:90,unNormalScale_hcIdx(i))';
%     elseif i>43 && i<89
%         trioBoldCell{i,:} = trio_aal116_bold_g_cut10(:,1:90,trio_mciIdx(i-43))';
%     else
%         trioBoldCell{i,:} = trio_aal116_bold_g_cut10(:,1:90,trio_adIdx(i-88))';
%     end
% end
% save('trioBoldCell.mat','trioBoldCell')
clear all
close all
load trioHcBold0707.mat
hc_bold = bold_g;
clear bold_g
load trioMciBold0707.mat
mci_bold = bold_g;
clear bold_g
load trioAdBold0707.mat
ad_bold = bold_g;
ad_bold(:,:,14) = [];
trioBoldCell0707 = cell(140,1);
for i = 1:length(trioBoldCell0707)
    if i<44
    trioBoldCell0707{i,:} = hc_bold(:,1:90,i)';
    elseif i>43 && i<89
        trioBoldCell0707{i,:} = mci_bold(:,1:90,i-43)';
    else
        trioBoldCell0707{i,:} = ad_bold(:,1:90,i-88)';
    end
end
save('trioBoldCell0707.mat','trioBoldCell0707')