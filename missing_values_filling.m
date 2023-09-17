% 读取数据信息
data = readtable("dataset.csv");

% 填充 market_id 列的空值
marketIdMode = mode(data.market_id(~isnan(data.market_id)));
data.market_id(isnan(data.market_id)) = marketIdMode;
data.market_id = int32(data.market_id); % 转换为整数

% 删除包含 actual_delivery_time 列空值的行
data(isnat(data.actual_delivery_time), :) = [];

% 填充 order_protocol 列的空值
orderProtocolMode = mode(data.order_protocol(~isnan(data.order_protocol)));
data.order_protocol(isnan(data.order_protocol)) = orderProtocolMode;
data.order_protocol = int32(data.order_protocol); % 转换为整数

% 填充 total_onshift_partners 列的空值
onshiftMean = mean(data.total_onshift_partners(~isnan(data.total_onshift_partners)));
data.total_onshift_partners(isnan(data.total_onshift_partners)) = onshiftMean;
data.total_onshift_partners = int32(data.total_onshift_partners); % 转换为整数

% 填充 total_busy_partners 列的空值
busyMean = mean(data.total_busy_partners(~isnan(data.total_busy_partners)));
data.total_busy_partners(isnan(data.total_busy_partners)) = busyMean;
data.total_busy_partners = int32(data.total_busy_partners); % 转换为整数

% 填充 total_outstanding_orders 列的空值
outstandingMean = mean(data.total_outstanding_orders(~isnan(data.total_outstanding_orders)));
data.total_outstanding_orders(isnan(data.total_outstanding_orders)) = outstandingMean;
data.total_outstanding_orders = int32(data.total_outstanding_orders); % 转换为整数

% 保存填充后的数据到新的 CSV 文件
outputFilePath = 'filled_dataset.csv';
writetable(data, outputFilePath);
