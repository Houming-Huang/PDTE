filename = "framingham.csv";
data = readtable(filename);

X = data{:, 1:end-1};    
y = data{:, end};        
nb = fitcnb(X, y);

cv = cvpartition(size(X, 1), 'KFold', 5);
C = zeros(2, 2);  

for i = 1:cv.NumTestSets

    trainIdx = cv.training(i);
    testIdx = cv.test(i);
    
    nbModel = fitcnb(X(trainIdx, :), y(trainIdx));
    y_pred = predict(nbModel, X(testIdx, :));
    C = C + confusionmat(y(testIdx), y_pred);
end

disp(C);

accuracy = sum(diag(C)) / sum(C(:));
precision = C(2, 2) / sum(C(:, 2));
recall = C(2, 2) / sum(C(2, :));
f1score = 2 * (precision * recall) / (precision + recall);

disp(['准确率：', num2str(accuracy)]);
disp(['精确度：', num2str(precision)]);
disp(['召回率：', num2str(recall)]);
disp(['F1得分：', num2str(f1score)]);
