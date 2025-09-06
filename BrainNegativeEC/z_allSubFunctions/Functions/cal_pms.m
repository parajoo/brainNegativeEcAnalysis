function  pms_all = cal_pms(input,T_max,N_subs,states)
     % 重塑向量以获取 43x230 的矩阵，每行代表一个被试
    
    reshaped_data = reshape(input, T_max, N_subs)';

    % 初始化概率矩阵
    pms_all = zeros(N_subs, states);

    % 计算每个被试在每个亚状态下的概率
    for i = 1:N_subs
        for j = 1:states
            pms_all(i, j) = sum(reshaped_data(i, :) == j) / T_max;
        end
    end
end