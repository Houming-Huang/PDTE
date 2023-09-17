data = xlsread("framingham.csv");
data = rmmissing(data);

X = data(:, 1:end-1);
y = data(:, end);
X = normalize(X);

cv = cvpartition(size(data, 1), 'KFold', 5);
accuracy_values = zeros(cv.NumTestSets, 1);
precision_values = zeros(cv.NumTestSets, 1);
recall_values = zeros(cv.NumTestSets, 1);
f1_values = zeros(cv.NumTestSets, 1);
total_cm = zeros(2, 2);
for i = 1:cv.NumTestSets
    train_idx = cv.training(i);
    test_idx = cv.test(i);
    
    net = patternnet([10, 10]);
    net.trainFcn = 'trainscg';
    net.performFcn = 'crossentropy';
    net.divideFcn = 'dividerand';
    net.divideParam.trainRatio = 0.8;
    net.divideParam.valRatio = 0.2;
    net.divideParam.testRatio = 0;
    [net, tr] = train(net, X(train_idx, :)', y(train_idx)');
    
    y_pred = net(X(test_idx, :)');
    y_pred = round(y_pred);
    
    cm = confusionmat(y(test_idx)', y_pred);
    accuracy = sum(diag(cm)) / sum(cm(:));
    precision = cm(2, 2) / sum(cm(:, 2));
    recall = cm(2, 2) / sum(cm(2, :));
    f1 = 2 * (precision * recall) / (precision + recall);
    
    accuracy_values(i) = accuracy;
    precision_values(i) = precision;
    recall_values(i) = recall;
    f1_values(i) = f1;
    
    total_cm = total_cm + cm;
end

fprintf('总混淆矩阵:\n');
disp(total_cm);

accuracy = sum(diag(total_cm)) / sum(total_cm(:));
precision = total_cm(2, 2) / sum(total_cm(:, 2));
recall = total_cm(2, 2) / sum(total_cm(2, :));
f1 = 2 * (precision * recall) / (precision + recall);

disp(['总体准确率：', num2str(accuracy)]);
disp(['总体精确度：', num2str(precision)]);
disp(['总体召回率：', num2str(recall)]);
disp(['总体F1得分：', num2str(f1)]);
