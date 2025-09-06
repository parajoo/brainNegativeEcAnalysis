function rgb = hex2rgb(hexStr)
% HEX2RGB 将十六进制颜色代码转换为MATLAB RGB值
% 输入格式示例：
%   "#cdb4db" 或 "cdb4db" 或 "CDB4DB"
% 输出格式：
%   [0.8039, 0.7059, 0.8588]

% 去除#符号并统一为小写
hexStr = lower(strrep(hexStr, '#', ''));

% 输入验证
assert(numel(hexStr)==6, '输入必须为6位十六进制字符（例如cdb4db）');
validChars = ismember(hexStr, ['0':'9' 'a':'f']);
assert(all(validChars), '包含非法字符。只允许0-9和a-f/A-F');

% 分割颜色分量
components = {
    hexStr(1:2)  % 红
    hexStr(3:4)  % 绿
    hexStr(5:6)  % 蓝
};

% 转换为0-255再归一化
rgb = cellfun(@(x) hex2dec(x)/255, components);
end