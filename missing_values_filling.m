data = readtable("dataset.csv");

marketIdMode = mode(data.market_id(~isnan(data.market_id)));
data.market_id(isnan(data.market_id)) = marketIdMode;
data.market_id = int32(data.market_id);

data(isnat(data.actual_delivery_time), :) = [];

orderProtocolMode = mode(data.order_protocol(~isnan(data.order_protocol)));
data.order_protocol(isnan(data.order_protocol)) = orderProtocolMode;
data.order_protocol = int32(data.order_protocol);

onshiftMean = mean(data.total_onshift_partners(~isnan(data.total_onshift_partners)));
data.total_onshift_partners(isnan(data.total_onshift_partners)) = onshiftMean;
data.total_onshift_partners = int32(data.total_onshift_partners);

busyMean = mean(data.total_busy_partners(~isnan(data.total_busy_partners)));
data.total_busy_partners(isnan(data.total_busy_partners)) = busyMean;
data.total_busy_partners = int32(data.total_busy_partners);

outstandingMean = mean(data.total_outstanding_orders(~isnan(data.total_outstanding_orders)));
data.total_outstanding_orders(isnan(data.total_outstanding_orders)) = outstandingMean;
data.total_outstanding_orders = int32(data.total_outstanding_orders);

outputFilePath = 'filled_dataset.csv';
writetable(data, outputFilePath);
