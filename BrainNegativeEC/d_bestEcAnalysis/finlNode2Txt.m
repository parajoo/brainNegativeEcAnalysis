% 
% % 指定文件夹路径
% folderPath = '/home/zengmin/model/pms_tianjin_data/fig0901';
% 
% % 获取该路径下所有 .txt 文件
% files = dir(fullfile(folderPath, '*.txt'));
% 
% % 循环处理每个文件
% for i = 1:length(files)
%     filePath = fullfile(folderPath, files(i).name);  % 当前文件路径
%     
%     % 读取文件内容
%     fid = fopen(filePath, 'r');
%     content = fread(fid, '*char')';
%     fclose(fid);
%     
%     % 找到第一行换行符位置
%     newlineIdx = find(content == newline, 1, 'first');
%     if isempty(newlineIdx)
%         % 如果文件只有一行，就整行加#
%         newContent = ['#', content];
%     else
%         % 在第一行前加#
%         newContent = ['#', content(1:newlineIdx-1), newline, content(newlineIdx+1:end)];
%     end
%     
%     % 写回文件
%     fid = fopen(filePath, 'w');
%     fwrite(fid, newContent);
%     fclose(fid);
% end
% 
% disp('所有 .txt 文件第一行已在前面加上 #');




% 指定文件夹路径（替换成你的路径）
folderPath = '/home/zengmin/model/pms_tianjin_data/fig0901';

% 获取该路径下所有 .txt 文件
files = dir(fullfile(folderPath, '*.txt'));

% 循环重命名
for i = 1:length(files)
    oldName = fullfile(folderPath, files(i).name);           % 原文件路径
    [~, name, ~] = fileparts(files(i).name);                 % 提取不带后缀的文件名
    newName = fullfile(folderPath, [name, '.node']);          % 新文件路径
    movefile(oldName, newName);                              % 重命名
end

disp('所有 .txt 文件已改为 .node 后缀。');
