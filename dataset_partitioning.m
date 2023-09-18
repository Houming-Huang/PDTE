% 读取CSV文件
data = readtable('E:\encoded_dataset.csv');

% 变量选择
variable = 'market_id';

% 获取选定变量的唯一值
values = unique(data.(variable));

% 创建保存文件的文件夹
folderPath = fullfile('D:\预测分类', variable);
if ~exist(folderPath, 'dir')
    mkdir(folderPath);
end

% 按照选定变量进行文件划分和保存
for i = 1:numel(values)
    value = values(i);
    
    % 获取符合当前选定变量值的行索引
    indices = data.(variable) == value;
    
    % 根据行索引筛选数据
    valueData = data(indices, :);
    
    % 构造保存文件路径
    filePath = fullfile(folderPath, sprintf('%s_%d.csv', variable, value));
    
    % 保存数据到CSV文件
    writetable(valueData, filePath);
end
