% 假设数据为 4x90 的矩阵，其中每行代表一个聚类中心的 90 维数据

data = centers;  % 这里使用随机数据作为示例

% 计算距离矩阵
distMatrix = pdist(data, 'euclidean');  % 计算欧氏距离
distMatrix = squareform(distMatrix);    % 将距离向量转化为方阵形式
% 使用 MDS 将数据降维到 2 维空间
Y = mdscale(distMatrix, 2);

% 如果需要 3 维空间，可以改成
Y3 = mdscale(distMatrix, 3);
figure('Color',[1 1 1]);
scatter(Y(:,1), Y(:,2), 100, 'filled');
text(Y(:,1), Y(:,2), {'Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4'}, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
xlabel('Dimension 1');
ylabel('Dimension 2');
title('MDS Representation of Cluster Centers');
figure('Color',[1 1 1]);
scatter3(Y3(:,1), Y3(:,2), Y3(:,3), 100, 'filled');
text(Y3(:,1), Y3(:,2), Y3(:,3), {'Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4'}, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
xlabel('Dimension 1');
ylabel('Dimension 2');
zlabel('Dimension 3');
title('MDS Representation of Cluster Centers in 3D');

