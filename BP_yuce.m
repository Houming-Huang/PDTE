% 加载数据
data = xlsread("E:\order_protocol\order_protocol_3.csv");
% 分离输入和目标变量
inputs = data(:, [2 4:8]);
targets = data(:, 9);

% 创建交叉验证分区
cvp = cvpartition(size(data,1),'HoldOut',0.2);
idx = training(cvp);

% 训练一个决策树的增强集成模型
t = templateTree('MaxNumSplits',50);
ens = fitensemble(inputs(idx,:), targets(idx,:), 'LSBoost', 100, t);

% 预测测试数据的响应
yfit = predict(ens, inputs(~idx,:));

% 计算性能指标
r_squared = 1 - sum((yfit - targets(~idx,:)).^2) / sum((targets(~idx,:) - mean(targets(~idx,:))).^2);
mae = mean(abs(yfit - targets(~idx,:)));

% 显示性能指标
fprintf('R^2: %f\n', r_squared);
fprintf('MAE: %f\n', mae);

% 对比预测值和实际值
figure;
plot(yfit, 'r-*');
hold on;
plot(targets(~idx,:), 'b-o');
legend('预测值', '实际值');
grid;
