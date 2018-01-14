### The following concepts were extracted from the book: Practical Statistics for Data Scientists - 50 Essential Concepts

#### By itself, the regression equation does not prove the direction of causation. (回归关系不等于因果关系) 

Conclusions about causation must come from a broader context of understanding about the relationship. For example, a regression equation might show a definite relationship between number of clicks on a web ad and number of conversions. It is our knowledge of the marketing process, not the regression equation, that leads us to the conclusion that clicks on the ad leads to sales, not vice versa.

#### Why would a data scientist care about heteroskedasticity?
Heteroskedasticity indicates that prediction errors differ for different ranges of the predicted value, and may suggest **an incomplete model**.

For example, in house price prediction, it may indicate that **the regression has left something unaccounted for** in high and low-range homes.

# Data Science & P-value
#### Statistical Significant (alpha)
is how people measure whether an experiment yields a result more extreme than what chance might produce. If the result is beyond the realm of chance variation, it is said to be statistically significant.

#### P-value 
Given a chance model that embodies the null hypothesis, p-value is the probability of obtaining results as extreme as the observed results.

#### Type I Error (False Positive)
The case in which you mistakenly conclude an effect is real, when it is really just **due to chance**.

#### Type II Error (False Negative)
The case in which you mistakenly conclude that an effect is not real, when it is really real.

A Type 2 error relates to the concept of "power", and the probability of making this error is referred to as "beta". We can reduce our risk of making a Type II error by making sure our test has enough power—which depends on whether the sample size is sufficiently large to detect a difference when it exists.  

#### For a data scientist, p-value is a useful metric in situations where you want to know whether a model result that appears interesting and useful is within the range of normal chance variation.

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
### Assumptions
1. There should be a **linear and additive** relationship between dependent (response) variable and independent (predictor) variable(s).

2. There should be no correlation between the residual (error) terms. Absence of this phenomenon is known as Autocorrelation.

3. The independent variables should not be correlated. Absence of this phenomenon is known as multicollinearity.

4. The error terms must have constant variance. This phenomenon is known as homoskedasticity. The presence of non-constant variance is referred to heteroskedasticity.

5. The error terms must be normally distributed.

### What if those assumptions get violated?
1. **Linear and Additive**: The model will fail to capture trend, thus resulting in erroneous predictions.

**How to check:** Look at residual vs fitted value plots. Also, can include polynomial terms (X, X^2, X^3) in the model to capture non-linear effect.

2. **Autocorrelation:** This usually occurs in time series models where the next instant is dependent on previous instant. If the error terms are correlated, the estimated standard errors tend to underestimate the true standard error. If this happens, it causes confidence intervals and prediction intervals to be narrower. Narrower confidence interval means that a 95% confidence interval would have lesser probability than 0.95 that it would contain the actual value of coefficients. 