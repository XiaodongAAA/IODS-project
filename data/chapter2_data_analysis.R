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

# 


