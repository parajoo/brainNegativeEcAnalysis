
function val = replace_with_neighbors(data, pos)
    % 提取坐标
    s = pos(1);
    t = pos(2);
    a = pos(3);
    
    % 检查边界
    if t == 1
        % 如果是第一个时间点，只能用右边的值
        val = data(s, t+1, a);
    elseif t == size(data, 2)
        % 如果是最后一个时间点，只能用左边的值
        val = data(s, t-1, a);
    else
        % 否则，用左右的平均值
        val = (data(s, t-1, a) + data(s, t+1, a)) / 2;
    end
end