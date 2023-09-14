% 读取清理后的数据文件
cleanedData = readtable('cleaned_dataset.csv');

% 计算actual_delivery_time和created_at之差（秒）
timeDiff = seconds(cleanedData.actual_delivery_time - cleanedData.created_at);

% 添加新的变量time_diff
cleanedData.time_diff = timeDiff;

% 删除actual_delivery_time和created_at变量
cleanedData.actual_delivery_time = [];
cleanedData.created_at = [];

% 保存到新文件
newFilename = 'processed_dataset.csv';
writetable(cleanedData, newFilename);
