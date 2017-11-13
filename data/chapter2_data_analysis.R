#' Created at 10:00 12.11.2017
#' 
#' @author:Xiaodong Li
#' 
#' The script for RStudio Exercise 2 -- analysis

library(dplyr)
library(GGally)
library(ggplot2)
#read data
lrn2014 = read.table('/home/xiaodong/IODS_course/IODS-project/data/learning2014.txt',sep='\t',header = TRUE)
# Structure of the data
str(lrn2014)
# Dimensions of the data
dim(lrn2014)
# Data description
# According to the structure and dimensions of the data, the data frame contains 7 variables which are 'gender',
# 'age','attitude','deep','stra','surf','points'. In each variable, there are 166 observations. 'gender' represents
# male (M) and female (F) surveyors. 'age' is the ages (in years) of the people derived from the date of birth.
# In 'attitude' column lists the global attitudes toward statistics. Columns 'deep','surf' and 'stra' list the questions
# related to deep, surface and strategic learning. The related question could be found in the following page, http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-meta.txt
# The 'points' column list the exam points from the survey.

# Explore the data
# Plot the relationships between the variables
p <- ggpairs(lrn2014, mapping = aes(col=gender,alpha=0.3))
p

# The figure shows relationships between different variables. From the figure we can see that, from the gender column, 
# female surveyors are more than male surveyors. Most of the people being surveyed are young generations, aged around 20 years old. 
# The attitudes of man are higher than those of wemon towards statistics, which reflects that man has more positive attitudes towards
# statistics than wemen. The questions of deep and strategic learning are almost the same for men and wemen. The mean scores for 
# them are around 3 and 4. However, the surface questions are quite different between the men and wemen surveyors. For wemen, the answers are centered 
# at around 3.0 while the answers of men are centered at around 2.3. The exam points got from male and female answerers are quite the same and the most 
# points are about 23 for both of them. 

# Multiple regression
reg_model=lm(points~attitude+stra+surf,data=lrn2014)
summary(reg_model)

# The target variable point is fitted to three explanatory variables: attitude, stra and surf. According to
# the results of the model, surf does not have a statistically significant relationship with the target variable.
# So, surf is removed from the fitting model and points is modelled according to attitude and stra again.

# Model again
reg_model2=lm(points~attitude+stra, data=lrn2014)
summary(reg_model2)

# The model is fitted with the target points and two explanatory variable, attitude and stra. According to the summary results, the 
# relationship between these variable should be points=8.9729+3.4658*attitude+0.9137*stra. The Std. Error is the standard deviation of the sampling distribution of 
# the estimate of the coefficient under the standard regression assumptions. The t values are the estimates divided by there standard errors. It is an estimation of how 
# extreme the value you see is, relative to the standard error. Pr. is the p-value for the hypothesis for which the t value is the test statistic. It tell you the probability 
# of a test statistic at least as unusual as the one you obtained, if the null hypothesis were true (the null hypothesis is usually 'no effect', unless something else is specified).
# So, if the p-value is very low, then there is a higher probability that you're see data that is counter-indicative of zero effect. 
# Residual standard error represents the standard deviation of the residuals. It's a measure of how close the fit is to the points. The Multiple R-squared is the proportion of the variance 
# in the data that's explained by the model. The more variables you add, the large this will be. The Adjusted R-squared reduces that to account for the number of variables in the model.
# The F-statistic on the last line is telling you whether the regression as a whole is performing 'better than random',in other words, it tells whether your model fits better
# than you'd expect if all your predictors had no relationship with the response. The p-value in the last row is the p-value for that test, essentially comparing the full model you fitted with an intercept-only model.

# Diagnostic plots
# Residuals vs Fitted values, Normal QQ-plot and Residuals vs Leverage are plotted
par(mfrow=c(2,2))
plot(reg_model2, which=c(1,2,5))

# The Residuals vs Fitted values plot examines if the errors have constant variance. The graph shows a reasonable constant variance without any pattern.
# The Normal QQ-polt checks if the errors are normally distributed. We see from the graph a very good linear model fit, indicating a normally distributed error set.
# The Residuals vs Leverage confirms if there are any outliers with high leverage. From the graph, it shows that all the leverage are below 0.06, indicating good model fitting.

