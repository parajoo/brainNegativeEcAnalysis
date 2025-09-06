clear all
%close all
load hcsc168.mat
matrix = hcsc168;
matrix(matrix>0)=0;
matrix = abs(matrix);
% 定义阈值范围
thresholds = 0:0.0005:0.006; % 从 0 到 1，以 0.05 为步长
%thresholds = 0:0.0025:0.1;

% 初始化存储信息熵的数组
entropies = zeros(size(thresholds));

% 按步长进行分段处理的步长
%step = 0.001;
step = 0.0001;

for i = 1:length(thresholds)%different thresholds
    % 当前阈值
    threshold = thresholds(i);
    
    % 阈值处理：将低于阈值的值设为0
    processed_matrix = matrix;
    processed_matrix(matrix < threshold) = 0;
    
    % 按步长进行分段处理
    non_zero_indices = processed_matrix > 0;
    processed_matrix(non_zero_indices) = ceil(processed_matrix(non_zero_indices) / step);
    
    % 计算非零值的概率分布
    if any(processed_matrix(:) > 0)
        unique_values = unique(processed_matrix(processed_matrix > 0));
        counts = histc(processed_matrix(:), unique_values);
        probabilities = counts(counts > 0) / sum(counts);

        % 计算信息熵
        entropy = -sum(probabilities .* log(probabilities));
    else
        entropy = 0; 
    end
    
    % 存储信息熵
    entropies(i) = entropy;
end

% 绘制信息熵随阈值变化的曲线
figure('Color',[1 1 1]);
plot(thresholds, entropies, '-o');
xlabel('Threshold');
ylabel('Entropy');
title('entropy in different threshold(HC<0)');
grid on;