function klDivergences = calculateKLDivergences_test(pms_hc_emp, pms_hc_sim)
    % 初始化存储KL散度的向量
    klDivergences = zeros(size(pms_hc_sim, 1), 1);
    
    % 对每个模拟分布向量计算KL散度
    for i = 1:size(pms_hc_sim, 1)
        klDivergences(i) = KLdivergence(pms_hc_emp, pms_hc_sim(i, :));
    end
end

function klDiv = KLdivergence(P, Q)
    % 小的常数，避免对零取对数
    epsilon = 1e-3;
    
    % 将0替换为一个小常数
    P(P == 0) = epsilon;
    Q(Q == 0) = epsilon;
    
    % 确保P和Q是概率分布，即非负且和为1
    P = P / sum(P);
    Q = Q / sum(Q);
    
    % 计算KL散度
    klDiv = sum(P .* log(P ./ Q));
end