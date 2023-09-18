data = readtable('encoded_dataset.csv');

market_id_dummy = dummyvar(data.market_id);
store_primary_category_dummy = dummyvar(data.store_primary_category);
order_protocol_dummy = dummyvar(data.order_protocol);

data.market_id = [];
data.store_primary_category = [];
data.order_protocol = [];
data = [data array2table(market_id_dummy) array2table(store_primary_category_dummy) array2table(order_protocol_dummy)];

features = data(:, setdiff(data.Properties.VariableNames, 'time_diff'));
X = table2array(features);
Y = data.time_diff;

mdl = fitlm(X, Y);
disp(mdl)
