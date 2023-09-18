% 读取文件
data = readtable('encoded_dataset.csv');

% 创建虚拟变量
market_id_dummy = dummyvar(data.market_id);
store_primary_category_dummy = dummyvar(data.store_primary_category);
order_protocol_dummy = dummyvar(data.order_protocol);

% 替换原始的类别变量为虚拟变量
data.market_id = [];
data.store_primary_category = [];
data.order_protocol = [];
data = [data array2table(market_id_dummy) array2table(store_primary_category_dummy) array2table(order_protocol_dummy)];

% 取出表格中的所有特征，除了目标变量 "time_diff"
features = data(:, setdiff(data.Properties.VariableNames, 'time_diff'));

% 转换表格为数组，这样可以用于fitlm函数
X = table2array(features);

% 取出目标变量 "time_diff"
Y = data.time_diff;

% 创建一个多元线性回归模型
mdl = fitlm(X, Y);

% 显示模型的统计摘要
disp(mdl)
