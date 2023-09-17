% 读取CSV文件
filename = "framingham.csv";
data = readtable(filename);

% 提取特征和目标变量
X = data{:, 1:end-1};    % 特征矩阵
y = data{:, end};        % 目标变量向量

% 创建朴素贝叶斯分类器
nb = fitcnb(X, y);

% 使用crossval函数进行交叉验证
cv = cvpartition(size(X, 1), 'KFold', 5);
C = zeros(2, 2);  % 初始化混淆矩阵

for i = 1:cv.NumTestSets
    % 获取训练集和测试集的索引
    trainIdx = cv.training(i);
    testIdx = cv.test(i);
    
    % 在训练集上进行拟合
    nbModel = fitcnb(X(trainIdx, :), y(trainIdx));
    
    % 在测试集上进行预测
    y_pred = predict(nbModel, X(testIdx, :));
    
    % 更新混淆矩阵
    C = C + confusionmat(y(testIdx), y_pred);
end

% 显示混淆矩阵
disp(C);
% 计算准确率和其他性能指标
accuracy = sum(diag(C)) / sum(C(:));
precision = C(2, 2) / sum(C(:, 2));
recall = C(2, 2) / sum(C(2, :));
f1score = 2 * (precision * recall) / (precision + recall);

% 显示性能指标
disp(['准确率：', num2str(accuracy)]);
disp(['精确度：', num2str(precision)]);
disp(['召回率：', num2str(recall)]);
disp(['F1得分：', num2str(f1score)]);