%% find boldsignal == NaN
load trio_bold_use.mat
data=trio_bold_use;
[num_timepoints, num_rois, num_subjects] = size(data);

% 初始化一个逻辑数组，记录哪些被试和脑区中存在NaN
nan_subject_roi = false(num_rois, num_subjects);

% 遍历每个被试和脑区，查找NaN
for subj = 1:num_subjects
    for roi = 1:num_rois
        % 如果该被试和脑区中的时间点存在NaN，则记录为true
        if any(isnan(data(:, roi, subj)))
            nan_subject_roi(roi, subj) = true;
        end
    end
end

% 找出有NaN值的被试和脑区
[rois_with_nan, subjects_with_nan] = find(nan_subject_roi);

% 显示结果
fprintf('包含NaN值的被试和脑区：\n');
for k = 1:length(rois_with_nan)
    fprintf('被试 %d 的脑区 %d 存在NaN值\n', subjects_with_nan(k), rois_with_nan(k));
end
%% find boldsignal == 0
zero_subject_roi = false(num_rois, num_subjects);

% 遍历每个被试和脑区，查找信号是否全为0
for subj = 1:num_subjects
    for roi = 1:num_rois
        % 如果该被试的某个脑区的所有时间点的信号全为0，则记录为true
        if all(data(:, roi, subj) == 0)
            zero_subject_roi(roi, subj) = true;
        end
    end
end

% 找出信号全为0的被试和脑区
[rois_with_zero, subjects_with_zero] = find(zero_subject_roi);

% 计算信号全为0的脑区数量
num_zero_rois = sum(any(zero_subject_roi, 2));

% 显示结果
fprintf('包含信号全为0的被试和脑区：\n');
for k = 1:length(rois_with_zero)
    fprintf('被试 %d 的脑区 %d 信号全为0\n', subjects_with_zero(k), rois_with_zero(k));
end

fprintf('\n总共有 %d 个脑区的信号全为0。\n', num_zero_rois);
% % 假设数据存储在一个名为fc_data的90x90x44三维矩阵中
% % 获取矩阵的维度
% fc_data = ad44_fc;
% [num_nodes, ~, num_subjects] = size(fc_data);
% 
% % 初始化一个逻辑数组，用于记录哪些被试的FC矩阵包含NaN
% nan_subjects = false(1, num_subjects);
% 
% % 遍历每个被试，检查其FC矩阵是否存在NaN值
% for subj = 1:num_subjects
%     % 如果当前被试的FC矩阵包含NaN，则将该被试标记为true
%     if any(isnan(fc_data(:, :, subj)), 'all')
%         nan_subjects(subj) = true;
%     end
% end
% 
% % 找出包含NaN的被试编号
% subjects_with_nan = find(nan_subjects);
% 
% % 显示结果
% fprintf('包含NaN值的被试：\n');
% disp(subjects_with_nan);
% 
% % 如果需要进一步分析，可以将结果保存为一个表
% nan_table = table(subjects_with_nan', 'VariableNames', {'Subjects_With_NaN'});
% disp(nan_table);
