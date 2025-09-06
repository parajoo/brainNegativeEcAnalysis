 function klD = KLdivergence(P, Q)
    % 确保P和Q是概率分布，即非负且和为1
    if any(P < 0) || any(Q < 0) || sum(P) ~= 1 || sum(Q) ~= 1
        error('输入必须是概率分布');
    end
    
    % 只计算P中非零元素对应的KL散度
    P = P(P > 0);
    Q = Q(P > 0);

    % 计算KL散度
    klDiv = sum(P .* log(P ./ Q));
end
