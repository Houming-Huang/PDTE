data = readtable('processed_dataset.csv');

data.market_id = categorical(data.market_id);

[uniqueStoreIds, ~, storeIdLabels] = unique(data.store_id);
data.store_id = categorical(storeIdLabels);

[uniqueCategories, ~, categoryLabels] = unique(data.store_primary_category);
data.store_primary_category = categorical(categoryLabels);

data.order_protocol = categorical(data.order_protocol);

data = movevars(data, {'market_id', 'store_id', 'store_primary_category', 'order_protocol'}, 'After', size(data, 2));

newFilename = 'encoded_dataset.csv';
writetable(data, newFilename);
