# Porter Delivery Time Estimation
## Experimental Principle
### 1. Logistic Regression  
Logistic regression is a supervised machine learning algorithm mainly used for classification tasks. Its goal is to predict the probability of an instance belonging to a given class or not. It is a statistical algorithm that analyzes the relationship between a set of independent variables and a dependent variable. When the dependent variable is binary, it is used to predict the output. For example, it can be used to predict whether an email is spam or not based on certain features of the email. The algorithm describes the relationship between the independent and dependent variables by finding the best fit line. This line is then used to predict new data points.
### 2. Neural Network
#### 2.1 Concept
A neural network is a machine learning algorithm that mimics the human brain. It can learn from data and provide responses in the form of predictions or classifications. They are used for various tasks such as image recognition, speech recognition, machine translation, and medical diagnosis. Neural networks consist of layers of nodes, including an input layer, one or more hidden layers, and an output layer. Each node is connected to another node and has associated weights and thresholds.

Neural networks are just one of many tools and methods in machine learning algorithms. Neural networks themselves are also used as part of many different machine learning algorithms to process high-level input into something a computer can understand.
#### 2.2 BP Neural Network
The BP neural network algorithm is a widely used algorithm that can be used to train feedforward artificial neural networks or other parameterized networks with differentiable nodes. It is an efficient way to apply Leibniz's chain rules to these networks. BP neural network is a classic algorithm model in machine learning. It is a widely used network model with powerful nonlinear mapping capabilities, generalization capabilities and fault tolerance capabilities. At the same time, the BP neural network algorithm has some shortcomings, such as slow convergence and easy to fall into local minimum.

[BP_example](https://github.com/Houming-Huang/PDTE/blob/main/BP_example.m)

[![BP指标](https://github.com/Houming-Huang/PDTE/blob/main/images/BP_Exa/%E6%8C%87%E6%A0%87.png)](https://github.com/Houming-Huang/PDTE/blob/main/images/BP_Exa/)

<img src="https://github.com/Houming-Huang/PDTE/blob/main/images/BP_Exa/%E6%B7%B7%E6%B7%86%E7%9F%A9%E9%98%B5.png" alt="BP混淆矩阵" height="360" width="450"/>

### 3. Naive Bayes Algorithm
The Naive Bayes algorithm is a supervised machine learning algorithm based on the statistical Bayes theorem that is designed to perform exploratory and predictive modeling of inputs given a category or categories to perform various classification tasks, such as Filter spam, classify documents, predict sentiment, etc.

[Bayes_example](https://github.com/Houming-Huang/PDTE/blob/main/Bayes_example.m)

[![Bayes指标](https://github.com/Houming-Huang/PDTE/blob/main/images/Bayes_Exa/%E6%8C%87%E6%A0%87.png)](https://github.com/Houming-Huang/PDTE/blob/main/images/Bayes_Exa/)

<img src="https://github.com/Houming-Huang/PDTE/blob/main/images/Bayes_Exa/%E6%B7%B7%E6%B7%86%E7%9F%A9%E9%98%B5.png" alt="Bayes混淆矩阵" height="360" width="450"/>

## Experimental Process
### 1.Data Preprocessing
#### 1.1 Missing Values Filling
<img src="https://github.com/Houming-Huang/PDTE/blob/main/images/missing_values.png" alt="缺失值" height="290" width="700"/>
Before making predictions, the data set first needs to be preprocessed. After reading the data set file in Matlab, it was found that there were a certain number of missing values in the original data set of the task, so the missing values needed to be filled.  

[missing values filling](https://github.com/Houming-Huang/PDTE/blob/main/missing_values_filling.m)

In the above code, different filling value methods are used for different column attributes. Missing values in the market_id and order_protocol columns are filled with the mode of the column; missing values in the actual_delivery_time, total_onshift_partners, total_busy_partners, total_outstanding_partners columns are filled with the mean of the column.
#### 1.2 Outliers Handling
[outliers_handling](https://github.com/Houming-Huang/PDTE/blob/main/outliers_handling.m)

According to the specified conditions, numerical results that do not conform to common sense and reality should be deleted.
### 2. Feature Processing
#### 2.1 Feature Creation
[feature_creation](https://github.com/Houming-Huang/PDTE/blob/main/feature_creation.m)

Because the food delivery time needs to be predicted based on the time difference between order creation and food delivery, a new feature time_diff needs to be created in advance to record the time difference.
#### 2.2 Feature Encoding
[feature_encoding](https://github.com/Houming-Huang/PDTE/blob/main/feature_encoding.m)

Since all current features are still in string format, if we want to use these features in a neural network, we need to convert them into an encoded format. So we perform the above encoding operation.
### 3. Correlation Coefficient Calculation
[correlation_calculation](https://github.com/Houming-Huang/PDTE/blob/main/correlation_calculation.m)

Calculate the correlation coefficient between each column of features and the target variable, and select the features that have the greatest impact on predicting the target variable. After analysis, the correlation between market_id and the target variable is generally high.
### 4. Dataset Partitioning
[dataset_partitioning](https://github.com/Houming-Huang/PDTE/blob/main/dataset_partitioning.m)

Divide records with the same market_id into one category to facilitate subsequent retrieval.
### 5. BP Neural Network Prediction
[bp_prediction](https://github.com/Houming-Huang/PDTE/blob/main/bp_prediction.m)

[![indicators](https://github.com/Houming-Huang/PDTE/blob/main/images/BP_Est/%E6%8C%87%E6%A0%87.png)](https://github.com/Houming-Huang/PDTE/blob/main/images/BP_Est/)

<img src="https://github.com/Houming-Huang/PDTE/blob/main/images/BP_Est/%E7%BD%91%E7%BB%9C%E7%BB%93%E6%9E%84.png" alt="structure" height="360" width="510"/>

<img src="https://github.com/Houming-Huang/PDTE/blob/main/images/BP_Est/%E8%AE%AD%E7%BB%83%E7%8A%B6%E6%80%81.png" alt="training" height="360" width="510"/>

<img src="https://github.com/Houming-Huang/PDTE/blob/main/images/BP_Est/%E6%B5%8B%E8%AF%95%E9%9B%86%E9%A2%84%E6%B5%8B%E7%BB%93%E6%9E%9C%E5%AF%B9%E6%AF%94.png" alt="test" height="360" width="510"/>
<img src="https://github.com/Houming-Huang/PDTE/blob/main/images/BP_Est/%E8%AE%AD%E7%BB%83%E9%9B%86%E9%A2%84%E6%B5%8B%E7%BB%93%E6%9E%9C%E5%AF%B9%E6%AF%94.png" alt="train" height="360" width="510"/>
