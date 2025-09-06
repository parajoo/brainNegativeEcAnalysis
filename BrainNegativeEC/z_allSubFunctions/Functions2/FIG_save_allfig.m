% 获取所有图形的句柄
figHandles = findobj('Type', 'figure');

% 遍历所有图形句柄
for i = 1:length(figHandles)
    % 设置要保存的文件名，例如：figure_1.png, figure_2.png, ...
    filename = sprintf('figure_%d.fig', i);
    
    % 保存图形到文件
    % 注意：这里使用的是PNG格式，你可以根据需要更改为其他格式，例如PDF或JPEG
    saveas(figHandles(i), filename, 'fig');
    
    % 如果你想确保图像以全分辨率保存，可以使用下面的exportgraphics函数（需要MATLAB R2020a或更高版本）
    % exportgraphics(figHandles(i), filename);
end
