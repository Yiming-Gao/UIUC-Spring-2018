#### 定义： A/B Testing is a general methodology used online when we want to test out a new product (feature), to determine which version helps the business achieve its goal more efficiently. When applied on a website, those features could be button colors or different user interfaces.

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
