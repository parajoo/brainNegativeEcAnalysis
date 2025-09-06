% 假设 label_area 和 SC 已经定义

%load label_area.mat
leftBrainIndices = 1:2:90; % MATLAB的索引是从1开始的，直接对应奇数索引
rightBrainIndices = 2:2:90;
newIndices = [leftBrainIndices, rightBrainIndices]; % 合并两个数组

%使用新的索引重排矩阵
SC_iter = SC1(newIndices, newIndices);
SCnew = SC(newIndices,newIndices);
% 根据 label_area 对 SC 进行重排
% 显示原始矩阵和重排后的矩阵
figure('Color',[1 1 1]);
subplot(1, 2, 1);
imagesc(SC_iter);
title('EC-after(AD)');
colorbar;
caxis([0 0.2]);

subplot(1, 2, 2);
imagesc(SCnew);
title('SC-before(AD)');
colorbar;
caxis([0 0.2]);
