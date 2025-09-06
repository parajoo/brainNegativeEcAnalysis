% 假设您的数据存储在一个名为 data 的变量中，尺寸为 43x90x230
%clear all
data1 = HC_bold_moca(:,:,1:90);
data11 = permute(data1,[1,3,2]);
% 初始化一个 cell 数组来存储结果
data2 = AD_bold_moca(:,:,1:90);
data22 = permute(data2,[1,3,2]);
result = cell(14, 2); % 根据您的描述，29行2列

% 循环将前29个矩阵放入第一列
for i = 1:14
    result{i, 1} = squeeze(data11(i, :, :));
end

% 循环将后14个矩阵放入第二列
for i = 1:14
    result{i, 2} = squeeze(data22(i, :, :));
end

% result 现在是一个 cell 数组，其中第一列包含前29个矩阵，第二列包含后14个矩阵
