function maxDiff = getMaxDifference(experience, simulation,time)
    % 初始化一个数组来存储每个时间点的最大差值
    maxDiffs = zeros(1, time);
    
    % 遍历230个时间点
    for t = 1:time
        % 计算当前时间点的两个矩阵差值的绝对值
        diffMatrix = abs(experience(:, :, t) - simulation(:, :, t));
        
        % 找到当前差值矩阵的最大值
        maxDiffs(t) = max(diffMatrix(:));
    end
    
    % 在所有时间点的最大差值中找到最大的那个
    maxDiff = max(maxDiffs);
end
