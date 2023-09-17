%读取数据信息
data=readtable("filled_dataset.csv");
% 找到包含负数的行的索引
negativeRows = any(data.total_items < 0 | data.subtotal < 0 | data.num_distinct_items < 0 | ...
    data.min_item_price < 0 | data.max_item_price < 0 | data.total_onshift_partners < 0 | ...
    data.total_busy_partners < 0 | data.total_outstanding_orders < 0, 2);

% 删除包含负数的行
cleanedData = data(~negativeRows, :);

% 保存到新文件
filename = 'cleaned_dataset.csv';
writetable(cleanedData, filename);

