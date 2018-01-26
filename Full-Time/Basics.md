### The following concepts were extracted from the book: Practical Statistics for Data Scientists - 50 Essential Concepts

#### By itself, the regression equation does not prove the direction of causation. (回归关系不等于因果关系) 

Conclusions about causation must come from a broader context of understanding about the relationship. For example, a regression equation might show a definite relationship between number of clicks on a web ad and number of conversions. It is our knowledge of the marketing process, not the regression equation, that leads us to the conclusion that clicks on the ad leads to sales, not vice versa.

#### Why would a data scientist care about heteroskedasticity?
Heteroskedasticity indicates that prediction errors differ for different ranges of the predicted value, and may suggest **an incomplete model**.

For example, in house price prediction, it may indicate that **the regression has left something unaccounted for** in high and low-range homes.

# Data Science & P-value
#### Statistical Significance (alpha)
is how people measure whether an experiment yields a result more extreme than what chance might produce. If the result is beyond the realm of chance variation, it is said to be statistically significant.

#### P-value 
Given a chance model that embodies the null hypothesis, p-value is the probability of obtaining results as extreme as the observed results.

#### Type I Error (False Positive)
The case in which you mistakenly conclude an effect is real, when it is really just **due to chance**.

#### Type II Error (False Negative)
The case in which you mistakenly conclude that an effect is not real, when it is really real.

A Type 2 error relates to the concept of "power", and the probability of making this error is referred to as "beta". We can reduce our risk of making a Type II error by making sure our test has enough power—which depends on whether the sample size is sufficiently large to detect a difference when it exists.  

#### For a data scientist, p-value is a useful metric in situations where you want to know whether a model result that appears interesting and useful is within the range of normal chance variation.

#### Confidence Intervals
If repeated samples were taken and the 95% confidence interval was computed for each sample, 95% of the intervals would contain the population mean.

#### Data Science & t-statistic
一个系数的t-statistic = hat(b)/SE(hat(b)), which measures the extent to which a coefficient is "statistically significant", outside the range of what a random chance arrangement of predictor and target variable might produce.

Data scientist primarily focus on t-statistic as a useful guide for whether to include a predictor in a model or not.

### Chi-Square Test (Goodness-of-fit)
It is used with count data to test how well it fits some expected distribution. The most common use of *chi-square* statistic in practice is with r* c contingency tables, to assess whether the null hypothesis of independence among variables is reasonable.

(1) Determine appropriate sample sizes for web experiments. (These experiments often have very low click rates, in such cases, Fisher's exact test, the chi-square test can be useful as a component of power and sample size calculations)

(2) Chi-square tests, or similar resampling simulations, are used more as a filter to determine whether an effect or feature is worthy of further consideration.

(3) They can also be used in automated feature selection in machine learning, to access class prevalence across features and identify features where the prevalence of a certain class is unusually high or low, in a way that is not compatible with random variation.

#### Data science is not so worried about statistical significance, but more concerned with optimizing overall effort and results.

#### 违背回归假设 & Data Science
Most often in data science, the interest is primarily in **predictive accuracy**, so some review of heteroskedasticity may be in order. You may discover that there is some signal in the data that your model has not captured. Satisfying distributional assumptions simply for the sake of validating formal statistical inference (p-values, F-statistics, etc.), however, is not that important for the data scientist.

#### 经典统计学 & Data Science
These methods are distinguished from classical statistical methods in that they are data-driven and do not seek to impose linear or other overall structure on the data.

- Machine learning tends to be more focused on developing efficient algorithms that scale to large data in order to optimize the predictive model.
- Statistics generally pays more attention to the probabilistic theory and underlying structure of the model.

# Linear Regression
https://www.analyticsvidhya.com/blog/2016/07/deeper-regression-analysis-assumptions-plots-solutions/
### Assumptions
1. There should be a **linear and additive** relationship between dependent (response) variable and independent (predictor) variable(s).

2. There should be no correlation between the residual (error) terms. Absence of this phenomenon is known as Autocorrelation.

3. The independent variables should not be correlated. Absence of this phenomenon is known as multicollinearity.

4. The error terms must have constant variance. This phenomenon is known as homoskedasticity. The presence of non-constant variance is referred to heteroskedasticity.

5. The error terms must be normally distributed.

### What if those assumptions get violated?
1. **Linear and Additive**: 
- The model will fail to capture trend, thus resulting in erroneous predictions.
- **How to check:** Look at residual vs fitted value plots. Also, can include polynomial terms (X, X^2, X^3) in the model to capture non-linear effect.

2. **Autocorrelation:** 
- This usually occurs in time series models where the next instant is dependent on previous instant. If the error terms are correlated, the estimated standard errors tend to underestimate the true standard error. If this happens, it causes confidence intervals and prediction intervals to be narrower. Narrower confidence interval means that a 95% confidence interval would have probability less than 0.95 that it would contain the actual value of coefficients. 
- **How to check:** Look for Durbin - Watson (DW) statistic. It must lie between 0 and 4. 0<DW<2 implies positive autocorrelation, while 2<DW<4 implies negative autocorrelation.

3. **Multicollinearity:** 
- This causes standard errors to increase, thus the confidence interval becomes wider leading to inaccurate estimates of parameters.
- **How to check:** Use scatter plot to visualize correlation among variables. Also, you can also use VIF (Variation Inflation Factor). VIF > 10 implies serious multicollinearity。

4. **Heteroskedasticity:** 
- Non-constant variance arises in presence of outliers or extreme leverage values. When this phenomenon occurs, the confidence interval tends to be very wide or narrow.
- **How to check:** Look at residual vs fitted values plot. If this problem exists, the plot will show a funnel shape pattern. Can also use Breusch-Pagan/ Cook-Weisberg test or White general test.

5. **Normal Distribution of error terms:** 
- Confidence intervals may become too wide or narrow. Once confidence interval becomes unstable, it leads to difficulty in estimating coefficients based on least squares.
- **How to check:** QQ plot. Or Kolmogorov-Smirnov test, Shapiro-Wilk test.

### Key Factors to Keep In Mind for Regression Model
- Data exploration is an inevitable part of building predictive model.
- To compare the goodness of fit for different models, we can analyse different metrics like statistical significance of parameters, R-square, Adjusted r-square, AIC, BIC and error term. Another one is the **Mallow’s Cp criterion**. This essentially checks for possible bias in your model, by comparing the model with all possible submodels (or a careful selection of them).
- If your data set has multiple confounding variables, you should not choose automatic model selection method because you do not want to put these in a model at the same time.

# Logistic Regression
It's a special type of regression where the response is binary, and it's related to a set of explanatory variables. 与linear regression区别在于, we model the odds of the response taking a particular value.

We also assume that the logit transformation of the response has a linear relationship with the predictor variables.

#### Sigmoid Function
It maps any real-valued number into a value between 0 and 1: 1/(1 + e^-value)

#### Equation
y = e^(b0 + b1* x)/ (1 + e^(b0 + b1* x))

Usually we model the probability that an input X belongs to the default class (Y=1), we have P(X) = e^(b0 + b1* X)/ (1 + e^(b0 + b1* X))

#### MLE
Maximum likelihood is used to optimize the best values for the coefficients.

#### Potential Problems
- **Binary output**
- **Remove Noise**: Logistic regression assumes no error in the output variable (y), consider removing outliers and possibly misclassified instances from your training data.
- **Gaussian Distribution**: Logistic regression is a linear algorithm (with a non-linear transform on output). It does assume a linear relationship between the input variables with the output. Data transforms of your input variables that better expose this linear relationship can result in a more accurate model. For example, you can use log, root, Box-Cox and other univariate transforms to better expose this relationship.
- **Remove Correlated Inputs**:  Like linear regression, the model can overfit if you have multiple highly-correlated inputs. Consider calculating the pairwise correlations between all inputs and removing highly correlated inputs.
- **Fail to converge**:  This can happen if there are many highly correlated inputs in your data or the data is very sparse (e.g. lots of zeros in your input data).

#### ROC-AUC
**Sensitivity (Recall)**:  TP/ (TP + FN)

**Specificity**: TN / (TN + FP)

**Precision**: TP/ (TP + FP)

ROC Curve:
- X axis: Specificity
- Y axis: Sensitivity
- A model with high discrimination ability will have high sensitivity and specificity simultaneously, leading to an ROC curve which goes close to the top left corner of the plot.

# Generalized Linear Models
https://onlinecourses.science.psu.edu/stat504/node/216

**SAS PROC GENMOD, SAS PROC GLM (General)**

| **Model**  | **Random**  | **Link**  | **Systematic**  |
|:-:|:-:|:-:|:-:|
| Linear Regression  | Normal  |  Identity | Continuous  |
| ANOVA  | Normal  | Indentity  |  Categorical |
| ANCOVA  | Normal  | Identity  | Mixed  |
| Logistic Regression  | Binomial  |  Logit | Mixed  |
| Loglinear  | Poisson  | Log  |  Categorical |
|  Poisson Regression | Poisson  | Log  | Mixed  |
| Multinomial response  |  Multinomial | Generalized Logit  | Mixed  |

- ***Random***: refers to the probability distribution of the response Y
- ***Systematic***: specifies the predictors
- ***Link***: specifies the link between predictors and response


# High Dimensional Data
https://rpubs.com/ryankelly/reg
### Curse of Dimensionality
Refers to how certain learning algorithms may perform poorly in high-dimensional data.

1. High dimensionality is a curse when one is trying to do rejection sampling. With a higher dimension probability distribution, it becomes increasingly harder to find an appropriate enveloping distribution since the acceptance probability will keep shrinking with dimensionality.

2. K-means clustering suffers as well in high dimensions, because having lots of dimensions means that everything is "far away" from each other. It's hard to know what true distance means when you have so many dimensions. That's why it's often helpful to perform PCA to reduce dimensionality before clustering.

### Model Interpretability
Often in multiple regression, many variables are not associated with the response. Irrelevant variables leads to unnecessary complexity in the resulting model. By setting coefficient = 0, we obtain a more easily interpretable model. Here are some approaches for automatically excluding features using this idea.

#### (A) Subset Selection
- Forward Stepwise Selection, which begins with a model containing no predictors, then adds predictors to the model which gives the greatest improvement to the fit. **(High dimensional setting where p>n)**
- Backward Stepwise Selection, which begins with all predictors, then removes the least useful predictor one at a time. (n>)
  
- 4 Measures
Criteria to choose the best subset of predictors.
  - AIC = -2logL + 2p, the
  - BIC = -2logL + log(n)* p, penalizes free parameters more strongly
  - Adjusted R^2 = 1 - RSS/ (n-d-1)/TSS/(n-1), adds a penalty term for additional variables

#### (B) Shrinkage Methods
- Ridge Regression
  - The data must be standardized.
  - L2 regularization -- penalizes sum of squares
  - works best when LS estimates have high variance
  
- Lasso Regression
  - Zeroing out many coefficients
  - L1 regularization -- penalizes sum of absolute values
    
- Elastic Net: a combination of Ridge and Lasso

#### (C) Dimension Reduction Methods
- PCA
  - Derives a low-dimensional set of features from a large set of variables
  - Idea: PCs capture the most variance in the data using linear combinations of the data
  - Then 应用到模型中，use these PCs as predictors
  - Response Y is not used to help determine the PC directions

- Partial Least Squares
  - Supervised: gives higher weights to the variables that are most strongly related to the response
  - In practice, PLS performs no better than ridge regression

### Considerations for High Dimensions
Model fitting parameters R^2, Cp, AIC and BIC are not effective in high dimensional setting. The approaches above avoid overfitting by using a less flexible approach than OLS.

In high dimensional setting, multicollinearity problem is extreme. It's useful to report error and prediction results using a test set, or cross-validation errors.


### Variable Screening
In genetic studies, the number of variables is extremely large relative to the number of participants: there may be hundreds of subjects and hundreds of thousands of variables. This has a crippling effect on exploratory data analyses because nearly all multivariate procedures break down when the number of variables exceeds the sample size. As a result, it is necessary to reduce the number of variables to a subset of predictors that potentially impact the outcome of interest.
**VariableScreening R package** allows us to narrow the subset of variables for the analysis.

### Variable Selection
Other types of genetic studies focus on specific genes. This creates a situation in which the sample size is somewhat larger than the number of predictors (e.g., 500 subjects and 300 variables). In these situations, many variables are often highly correlated. A complicated model may include many insignificant variables, and it may have less predictive power and be difficult to interpret.

In these cases, approaches such as penalized least squares and penalized likelihood with the smoothly clipped absolute deviation (SCAD) penalty can select significant variables. We are developing broadly applicable techniques for high-dimensional variable selection. We also developed PROC SCAD, a pair of SAS procedures using the SCAD penalty for high-dimensional variable selection.

### KNN as a Feature Engine
In practical model fitting, KNN can be used to add "local knowledge" in the staged process with other classification techniques. Steps:

(1) KNN is run on the data, and for each record, a classification is derived

(2) That result is added as a new feature to the record, and another classification method is then run on the data. The original predictors are used twice.

Explanation: We can think of this staged use of KNN as a form of ensemble learning, in which multiple predictive modeling methods are used in conjunction with one another. It can also be considered as a form of **feature engineering** where the aim is to derive features that have predictive power.

#### How to choose k?
几点考虑：
- K is too small, we may be overfitting: include the noise in the data;
- K is too big, we may oversmooth the data and miss out on KNN's ability to capture the local structure in the data

解决办法：
- Determined by accuracy with holdout or validation set
- Depends greatly on the nature of data

如何变化：K = 1
- more complex
- more flexible
- less interpretable
- overfit
- high variance
- low bias

### Tree
#### 步骤
- The rules correspond to successive partitioning of the data into subpartitions
- Each partition, or split, references a specific value of a predictor variable and divides the data into records where the predictor value is above or below that split value
- At each stage, the tree algorithm chooses the split that **minimizes the outcome impurity within each subpartition**
- When no further splits can be made, the tree is fully grown and each terminal node, or leaf, has records of a single class; new cases following that rule path would be assigned that class
- **A fully grown tree (completely pure leaves & 100% accuracy) overfits the data and must be pruned back so that it captures signal and not noise**

#### Ways to measure homogeneity
- Gini Impurity: I(A) = p(1-p)
- Entropy: I(A) = -plog2(p) - (1-p)log2(1-p)
- p is the misclassified records within that partition

#### Tree model has two appealing aspects:
- Tree models provide a visual tool for exploring the data, to gain an idea of what variables are important and how they relate to one another. **Trees can capture nonlinear relationships among predictive variables.**
- Tree models provide a set of rules that can **be effectively communicated to non-specialists**, either for implementation or to "sell" a data mining project.

# Unsupervised Learning
Unsupervised learning techniques require that the data **be appropriately scaled.** For example, with the personal loan data, the variables have widely different units and magnitude. Some variables have relatively small values (e.g., number of years employed), while others have very large values (e.g., loan amount in dollars). If the data is not scaled, then the PCA, K-means and other clustering methods will be dominated by the variables with large values and ignore the variables with small values.

#### 聚类分析& 混合型数据
K-means and PCA are most appropriate for **continuous variables**. 
- For smaller data sets, it is better to use hierarchical clustering with *Gower's distance*.
- In principle, k-means could also be applied to binary or catogorical data by using "one hot encoder" representation to convert the categorical data to numeric values.
- For very large data sets, we could apply clustering to different subsets of data taking on specific catogorical values

【Gower's Distance】: scales all variables to the 0-1 range (it is often used with mixed numeric and categorical data)
- For **numeric** variables and ordered factors, distance is calculated as the absolute value of the difference between two records (manhattan distance)
- For **categorical** variables
  - distance is 1, if the categories between two records are different
  - distance is 0, if the categories are the same
  
  ## Comparisons  
  For highly structured data (in which the clusters are well separated), all methods produce similar results
  - K means scales to very large data and easily understood
  - Hierarchical clustering can be applied to mixed data types -- numeric and categorical -- and lends itself to an intuitive display (dendrogram)
  - Model-based clustering provides a more rigorous approach, as opposed to the heuristic methods
  
  For noisy data, produce different results
  - **For data scientists, there is no simple rule of thumb to guide the choice. Ultimatly, the method used will depend on the data size and the goal of the application.**

# Other Questions
### How to deal with imbalanced data? (Cancer Detection)
In an imbalanced data set, accuracy should not be used as a measure of performance. We should use **sensitivity** (TP rate), **Specificity** (TN rate), **F measure** to evaluate the performance of the classifier. If the minority class performance is found to be poor, we can take the following steps:
- Undersampling, oversampling, or SMOTE to make the data balanced.
- We can alter the prediction threshold using AUC-ROC curve.
- We can assign weights to classes such that the minority classes gets larger weight.
