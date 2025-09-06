function tpm = transitionmatrix(IDX)
    % 计算状态转移矩阵，确保结果是一个3x3矩阵

    % 固定状态的数量为3
    num_states = 3;
    
    % 初始化状态转移矩阵为3x3零矩阵
    tpm = zeros(num_states, num_states);
    
    % 遍历每个状态组合以计算转移概率
    for i = 1:num_states
        for j = 1:num_states
            % 计算从状态 i 转移到状态 j 的次数
            transitions = sum(IDX(1:end-1) == i & IDX(2:end) == j);
            
            % 计算状态 i 出现的总次数
            total_transitions = sum(IDX(1:end-1) == i);
            
            % 计算转移概率
            if total_transitions > 0
                tpm(i, j) = transitions / total_transitions;
            end
        end
    end
end
