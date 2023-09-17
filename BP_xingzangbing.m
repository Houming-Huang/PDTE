% 导入数据集
data = xlsread("framingham.csv");

% 处理缺失值
data = rmmissing(data);

% 分离特征矩阵X和目标向量y
X = data(:, 1:end-1);
y = data(:, end);

% 数据标准化
X = normalize(X);

cv = cvpartition(size(data, 1), 'KFold', 5);  % 使用5折交叉验证
accuracy_values = zeros(cv.NumTestSets, 1);
precision_values = zeros(cv.NumTestSets, 1);
recall_values = zeros(cv.NumTestSets, 1);
f1_values = zeros(cv.NumTestSets, 1);
total_cm = zeros(2, 2);  % 初始化总的混淆矩阵
for i = 1:cv.NumTestSets
    train_idx = cv.training(i);
    test_idx = cv.test(i);
    
    % 网络模型构建
    net = patternnet([10, 10]);
    net.trainFcn = 'trainscg';
    net.performFcn = 'crossentropy';
    net.divideFcn = 'dividerand';
    net.divideParam.trainRatio = 0.8;
    net.divideParam.valRatio = 0.2;
    net.divideParam.testRatio = 0;
    
    % 网络模型训练
    [net, tr] = train(net, X(train_idx, :)', y(train_idx)');
    
    % 网络模型预测
    y_pred = net(X(test_idx, :)');
    y_pred = round(y_pred);
    
    % 计算指标
    cm = confusionmat(y(test_idx)', y_pred);
    accuracy = sum(diag(cm)) / sum(cm(:));
    precision = cm(2, 2) / sum(cm(:, 2));
    recall = cm(2, 2) / sum(cm(2, :));
    f1 = 2 * (precision * recall) / (precision + recall);
    
    % 保存指标值
    accuracy_values(i) = accuracy;
    precision_values(i) = precision;
    recall_values(i) = recall;
    f1_values(i) = f1;
    
    % 累积混淆矩阵
    total_cm = total_cm + cm;
end

    
% 打印总的混淆矩阵
fprintf('总混淆矩阵:\n');
disp(total_cm);

% 计算总体统计指标
accuracy = sum(diag(total_cm)) / sum(total_cm(:));
precision = total_cm(2, 2) / sum(total_cm(:, 2));
recall = total_cm(2, 2) / sum(total_cm(2, :));
f1 = 2 * (precision * recall) / (precision + recall);

% 显示性能指标
disp(['总体准确率：', num2str(accuracy)]);
disp(['总体精确度：', num2str(precision)]);
disp(['总体召回率：', num2str(recall)]);
disp(['总体F1得分：', num2str(f1)]);
