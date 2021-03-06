#### A comprehensive guide
https://rstudio-pubs-static.s3.amazonaws.com/201749_9fc280333a5c4f448687e1d99b9bdf76.html

#### 定义： A/B Testing is a general methodology used online when we want to test out a new product (feature), to determine which version helps the business achieve its goal more efficiently. When applied on a website, those features could be button colors or different user interfaces.

Examples of A/B testing include Amazon personal recommendations, ranking change in LinkedIn.

The goal of A/B testing is to design an experiment that is going to be robust, and gives you repeatable results so that you can make a good decision about whether to launch that product (drug) or feature.

A proper A/B test has *subjects* that can be assigned to one treatment or another. Ideally, subjects are *randomized* to treatments. In this way, any difference between the treatment groups is due to one of the two things:
- The effect of the different treatments
- Random chance in assignments of subjects

## 什么时候不能用？
A/B testing is not good for testing new experiences. It may result in ***change aversion*** (where users don't like changes to the norm), or a ***novelty effect*** (where users see something new and test out everything).

## In an A/B test, how can you check if assignment to the various buckets was truly random?
If we have two groups and several background variables on the participants, we can run a procedure such as Hotelling's T^2 to compare them. In general this should be non-significant. If we have multiple groups, MANOVA or the discriminant function should be very poor.

## A/A Test
A/A test is a method of double-checking the randomizer. In running an A/A test, you would expect the metrics for your users in each group to be around the same. If it reports that there is a statistically significant difference, there's a problem, and you'll want to check that the experiment is correctly implemented on the website or mobile app.

You may have the following problems:
- The two groups are being exposed to different pages
- The groups are not randomized properly
- Your hypothesis test is biased and you data may violate the assumptions of the test you're using (e.g., using a t-test when you have heavily influential outliers)

## How would you run an A/B test for many variants, say 20 or more?
Let's say a company is testing 20 different metrics on the browsing page - conversion rate, review rate, click on ads rate. **The more metrics you are measuring, the more likely you are, to get at least one false positive.**

You can change your confidence level (Bonferroni Correction) or do family-wide tests before you dive into the individual metrics.

## (DS Interview Questions) Design an experiment to figure out which web design alternative to use. Assume there have been no other experiments done and there is no knowledge of the user behavior. Discuss potential issues that can occur with the conclusions and how to avoid them.
Identify the nature of the change and the metric to consider to decide which version of the site to use.

Next, decide the #samples/ visits necessary to hit the statistical significance (e.g. 95%). This can be done by using 
- a chi-squared test (if we are using a binomial random variable of clicking vs. not clicking)
- a ztest (if we are using a normally distributed random variable)

You can then evaluate the p-value to identify whether the metric of the B test is statistically significantly different from the metric of the baseline A test. If it is and the metric is better than the baseline, then the alternative site is the better way to go.

**Some issues you should consider in this answer:**

1) Identify potential biases due to interactions across pages. Talk to the product manager and see if there are ways that a random sampling may not work to test the nature of the change you're proposing for a web page.

2) Perform a A/A test which implies testing two random samples of vistors, and check if the distribution and metric of choice doesn't have a statistically significant difference. This will ensure the fairness of the A/B test. It's a method of double-checking the randomizer.

## (DS Interview Questions) Tell me the process you will use to perform an A/B Testing.
- **Collect Data:** Look for pages with low conversion rates or high drop-off rates that can be improved.
- **Identify Goals:** Your conversion goals are the metrics that you are using to determine whether or not the variation is more successful than the original version.
- **Generate Hypothesis:** Make the hypothesis for the plan you think will improve the webpage
- **Create Variations:** Make the desired changes to an element of your website or mobile app experience.
- **Run Experiment:** Kick off your experiment and wait for visitors to participate. At this point, visitors to your site or app will be randomly assigned to either the control or experiment group. Their interaction with each experience is measured, counted, and compared to determine how each performs.
- **Analyze Results**

## Hypothesis Tests
### Why need this?
The answer lies in the tendency of the human mind to underestimate the scope of natural random behavior. Hypothesis testing is to protect researchers from being fooled by random chance.

### Null hypothesis
It embodies the notion that any effect you observe is due to random chance. The *hypothesis test* assumes that the null hypothesis is true, and tests whether the effect you observe is a reasonable outcome of that model.

### Sample Size Estimation and Power analysis for clinical research
**Significance**: the probability that you're failing to reject the null when it is true.

**Power**: the probability that you reject the null when it is false.

#### Factors that affect the sample size
- P-value (alpha value): if it's small, require large sample size
- Power: if it's large, require large sample size
- Effect: if it's small, meaning it's hard to detect, require large sample size

