function ass_sim_idx = assign_pms(feature_vectors, centers)
    % assign the LE obtained from the simulated BOLD signal to the nearest centroid
    % 初始化分配状态矩阵
    num_subjects = size(feature_vectors, 1);
    num_timepoints = size(feature_vectors, 2);
    ass_sim_idx = zeros(num_subjects, num_timepoints);

    % 遍历所有被试和时间点
    for subj = 1:num_subjects
        for time = 1:num_timepoints
            % 提取当前时间点的特征向量
            vector = squeeze(feature_vectors(subj, time, :))';
            
            % 计算与每个中心的距离
            distances = pdist2(vector, centers);
            
            % 找到最近中心的索引
            [~, nearest_center_index] = min(distances);
            
            % 分配状态
            ass_sim_idx(subj, time) = nearest_center_index;
        end
    end
    ass_sim_idx = reshape(ass_sim_idx',[num_timepoints*num_subjects,1]);
end
