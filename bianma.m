% 读取处理后的数据文件
data = readtable('processed_dataset.csv');

% 转换market_id为分类特征
data.market_id = categorical(data.market_id);

% 转换store_id为分类特征
[uniqueStoreIds, ~, storeIdLabels] = unique(data.store_id);
data.store_id = categorical(storeIdLabels);

% 转换store_primary_category为分类特征
[uniqueCategories, ~, categoryLabels] = unique(data.store_primary_category);
data.store_primary_category = categorical(categoryLabels);

% 转换order_protocol为分类特征
data.order_protocol = categorical(data.order_protocol);

% 将分类特征放置在数据的最后几列
data = movevars(data, {'market_id', 'store_id', 'store_primary_category', 'order_protocol'}, 'After', size(data, 2));

% 保存到新文件
newFilename = 'encoded_dataset.csv';
writetable(data, newFilename);
