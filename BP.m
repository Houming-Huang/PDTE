% 关闭所有警告
warning off
% 关闭所有图形窗口
close all
% 清除所有变量
clear
% 清除命令窗口
clc

% 导入数据
data = xlsread("market_id_2.csv");  % 从csv文件中读取数据

%获取文件索引并且打乱
n = size(data, 1);  % 获取数据的行数
temp = randperm(n);  % 创建一个1到n的随机排列

% 划分训练集和测试集
P_train = data(temp(1:round(0.8*n)),  [2 4:8])';  % 取data的前80%行作为训练集，并将其转置
T_train = data(temp(1:round(0.8*n)), 9)';  % 取data的前80%行作为训练集的目标变量，并将其转置
M = size(P_train, 2);  % 训练集的大小

P_test = data(temp(round(0.8*n)+1:end),  [2 4:8])';  % 取data的后20%行作为测试集，并将其转置
T_test = data(temp(round(0.8*n)+1:end), 9)';  % 取data的后20%行作为测试集的目标变量，并将其转置
N = size(P_test, 2);  % 测试集的大小

% 数据归一化
[p_train, ps_input] = mapminmax(P_train, 0, 1);  % 对训练集输入进行归一化
p_test = mapminmax('apply', P_test, ps_input);  % 使用训练集的参数对测试集输入进行归一化

[t_train, ps_output] = mapminmax(T_train, 0, 1);  % 对训练集目标值进行归一化
t_test = mapminmax('apply', T_test, ps_output);  % 使用训练集的参数对测试集目标值进行归一化

% 创建网络
net = newff(p_train, t_train, [64 32]);  % 创建一个具有64个和32个隐藏层节点的反向传播神经网络

% 设置训练参数
net.trainParam.epochs = 1000;  % 最大迭代次数
net.trainParam.goal = 1e-6;  % 训练目标误差
net.trainParam.lr = 0.01;  % 学习率

% 训练网络
net = train(net, p_train, t_train);  % 使用训练集训练网络

% 仿真测试
t_sim1 = sim(net, p_train);  % 使用训练集进行仿真测试
t_sim2 = sim(net, p_test);  % 使用测试集进行仿真测试

% 数据反归一化
T_sim1 = mapminmax('reverse', t_sim1, ps_output);  % 对训练集的仿真测试结果进行反归一化
T_sim2 = mapminmax('reverse', t_sim2, ps_output);  % 对测试集的仿真测试结果进行反归一化

% 计算均方根误差
error1 = sqrt(sum((T_sim1 - T_train).^2) ./ M);  % 训练集的均方根误差
error2 = sqrt(sum((T_sim2 - T_test).^2) ./ N);  % 测试集的均方根误差

% 绘制训练集结果
figure  % 创建新图形窗口
plot(1:M, T_train, 'r-*', 1:M, T_sim1, 'b-o', 'LineWidth', 1)  % 绘制训练集的真实值和预测值
legend('真实值', '预测值')  % 添加图例
xlabel('预测样本')  % x轴标签
ylabel('预测结果')  % y轴标签
string = {'训练集预测结果对比'; ['RMSE=' num2str(error1)]};  % 图表标题
title(string)  % 设置图表标题
xlim([1, M])  % 设置x轴范围
grid  % 添加网格线

% 绘制测试集结果
figure  % 创建新图形窗口
plot(1:N, T_test, 'r-*', 1:N, T_sim2, 'b-o', 'LineWidth', 1)  % 绘制测试集的真实值和预测值
legend('真实值', '预测值')  % 添加图例
xlabel('预测样本')  % x轴标签
ylabel('预测结果')  % y轴标签
string = {'测试集预测结果对比'; ['RMSE=' num2str(error2)]};  % 图表标题
title(string)  % 设置图表标题
xlim([1, N])  % 设置x轴范围
grid  % 添加网格线

% 计算决定系数R^2
R1 = 1 - norm(T_train - T_sim1)^2 / norm(T_train - mean(T_train))^2;  % 训练集的决定系数R^2
R2 = 1 - norm(T_test - T_sim2)^2 / norm(T_test - mean(T_test))^2;  % 测试集的决定系数R^2

% 计算平均绝对误差MAE
mae1 = sum(abs(T_sim1 - T_train)) ./ M;  % 训练集的平均绝对误差MAE
mae2 = sum(abs(T_sim2 - T_test)) ./ N;  % 测试集的平均绝对误差MAE

% 打印结果
disp(['训练集数据的R2为：', num2str(R1)])  % 打印训练集的决定系数R^2
disp(['测试集数据的R2为：', num2str(R2)])  % 打印测试集的决定系数R^2

disp(['训练集数据的MAE为：', num2str(mae1)])  % 打印训练集的平均绝对误差MAE
disp(['测试集数据的MAE为：', num2str(mae2)])  % 打印测试集的平均绝对误差MAE


    