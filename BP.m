warning off
close all
clear
clc

data = xlsread("market_id_2.csv");

n = size(data, 1);  
temp = randperm(n);

P_train = data(temp(1:round(0.8*n)),  [2 4:8])';  
T_train = data(temp(1:round(0.8*n)), 9)';
M = size(P_train, 2);

P_test = data(temp(round(0.8*n)+1:end),  [2 4:8])';
T_test = data(temp(round(0.8*n)+1:end), 9)';
N = size(P_test, 2);

[p_train, ps_input] = mapminmax(P_train, 0, 1);
p_test = mapminmax('apply', P_test, ps_input);

[t_train, ps_output] = mapminmax(T_train, 0, 1);
t_test = mapminmax('apply', T_test, ps_output);

net = newff(p_train, t_train, [64 32]);

net.trainParam.epochs = 1000;  
net.trainParam.goal = 1e-6;  
net.trainParam.lr = 0.01; 
net = train(net, p_train, t_train); 

t_sim1 = sim(net, p_train);
t_sim2 = sim(net, p_test);

T_sim1 = mapminmax('reverse', t_sim1, ps_output); 
T_sim2 = mapminmax('reverse', t_sim2, ps_output); 

error1 = sqrt(sum((T_sim1 - T_train).^2) ./ M); 
error2 = sqrt(sum((T_sim2 - T_test).^2) ./ N); 

figure
plot(1:M, T_train, 'r-*', 1:M, T_sim1, 'b-o', 'LineWidth', 1)
legend('True_value', 'predict_value')
xlabel('predict_sample')
ylabel('predict_result')
string = {'contrast_result'; ['RMSE=' num2str(error1)]};
title(string)
xlim([1, M])
grid

figure
plot(1:N, T_test, 'r-*', 1:N, T_sim2, 'b-o', 'LineWidth', 1)  
legend('True_value', 'predict_value')
xlabel('predict_sample')
ylabel('predict_result')
string = {'contrast_result'; ['RMSE=' num2str(error2)]};
title(string)  
xlim([1, N])  
grid

R1 = 1 - norm(T_train - T_sim1)^2 / norm(T_train - mean(T_train))^2;  
R2 = 1 - norm(T_test - T_sim2)^2 / norm(T_test - mean(T_test))^2;  

mae1 = sum(abs(T_sim1 - T_train)) ./ M;  
mae2 = sum(abs(T_sim2 - T_test)) ./ N;  

disp(['train_R2：', num2str(R1)])  
disp(['test_R2：', num2str(R2)])  

disp(['train_MAE：', num2str(mae1)])  
disp(['test_MAE：', num2str(mae2)]) 
