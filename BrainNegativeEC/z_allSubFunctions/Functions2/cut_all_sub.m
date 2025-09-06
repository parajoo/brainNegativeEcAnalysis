% 示例向量（6440x1）
data = idx_all; % 假设这是你的数据

% 定义参数
num_subjects = 14;
num_timepoints = 230;
num_states = 3;

% 分割向量
HC_data = data(1:num_subjects*num_timepoints); % 前14*230为HC数据
AD_data = data(num_subjects*num_timepoints+1:end); % 后14*230为AD数据

% 初始化存储概率分布的矩阵
HC_probabilities = zeros(num_subjects, num_states);
AD_probabilities = zeros(num_subjects, num_states);

% 计算HC每个被试的亚状态分布概率
for i = 1:num_subjects
    subject_data = HC_data((i-1)*num_timepoints + 1:i*num_timepoints);
    for state = 1:num_states
        HC_probabilities(i, state) = sum(subject_data == state) / num_timepoints;
    end
end

% 计算AD每个被试的亚状态分布概率
for i = 1:num_subjects
    subject_data = AD_data((i-1)*num_timepoints + 1:i*num_timepoints);
    for state = 1:num_states
        AD_probabilities(i, state) = sum(subject_data == state) / num_timepoints;
    end
end
