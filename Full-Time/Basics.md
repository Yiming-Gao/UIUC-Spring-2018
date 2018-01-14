### The following concepts were extracted from the book: Practical Statistics for Data Scientists - 50 Essential Concepts

#### By itself, the regression equation does not prove the direction of causation. (回归关系不等于因果关系) 

Conclusions about causation must come from a broader context of understanding about the relationship. For example, a regression equation might show a definite relationship between number of clicks on a web ad and number of conversions. It is our knowledge of the marketing process, not the regression equation, that leads us to the conclusion that clicks on the ad leads to sales, not vice versa.

#### Why would a data scientist care about heteroskedasticity?
Heteroskedasticity indicates that prediction errors differ for different ranges of the predicted value, and may suggest **an incomplete model**.

For example, in house price prediction, it may indicate that **the regression has left something unaccounted for** in high and low-range homes.

### Data Science & P-value
#### Statistical Significant
is how people measure whether an experiment yields a result more extreme than what chance might produce. If the result is beyond the realm of chance variation, it is said to be statistically significant.

#### P-value 
Given a chance model that embodies the null hypothesis, p-value is the probability of obtaining results as extreme as the observed results.

#### Type I Error (False Positive)
The case in which you mistakenly conclude an effect is real, when it is really just **due to chance**.

#### Type II Error (False Negative)
The case in which you mistakenly conclude that an effect is not real, when it is really real

####
