% ��������
data = xlsread("E:\order_protocol\order_protocol_3.csv");
% ���������Ŀ�����
inputs = data(:, [2 4:8]);
targets = data(:, 9);

% ����������֤����
cvp = cvpartition(size(data,1),'HoldOut',0.2);
idx = training(cvp);

% ѵ��һ������������ǿ����ģ��
t = templateTree('MaxNumSplits',50);
ens = fitensemble(inputs(idx,:), targets(idx,:), 'LSBoost', 100, t);

% Ԥ��������ݵ���Ӧ
yfit = predict(ens, inputs(~idx,:));

% ��������ָ��
r_squared = 1 - sum((yfit - targets(~idx,:)).^2) / sum((targets(~idx,:) - mean(targets(~idx,:))).^2);
mae = mean(abs(yfit - targets(~idx,:)));

% ��ʾ����ָ��
fprintf('R^2: %f\n', r_squared);
fprintf('MAE: %f\n', mae);

% �Ա�Ԥ��ֵ��ʵ��ֵ
figure;
plot(yfit, 'r-*');
hold on;
plot(targets(~idx,:), 'b-o');
legend('Ԥ��ֵ', 'ʵ��ֵ');
grid;
