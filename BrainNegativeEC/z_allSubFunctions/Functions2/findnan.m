% 假设你的数据存储在一个116x116x184的3D矩阵中，名为data
data=results;
[brainRegions, ~, subjects] = size(data);

% 初始化一个逻辑数组，用于记录每个被试是否存在NaN
nanSubjects = false(subjects, 1);

% 遍历每个被试，检查是否包含NaN
for i = 1:subjects
    if any(isnan(data(:, :, i)), 'all')
        nanSubjects(i) = true;
    end
end

% 输出包含NaN的被试编号
nanSubjectIndices = find(nanSubjects);
disp('包含NaN的被试编号:');
disp(nanSubjectIndices);
