#' Created at 21:00 11.11.2017
#' 
#' @author:Xiaodong Li
#' 
#' The script for RStudio Exercise 2

library(dplyr)
# Read data
lrn14=read.table('http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt', sep='\t',header=TRUE)
# Structure of the data
str(lrn14)
# Dimensions of the data
dim(lrn14)
# The data has 183 obsversions and each observation has 60 variables. Nearly all the data are 'int' format except the 'gender' observation, which is a 'Factor'.

# Modify column names
column_names=c('age','attitude','points')
colnames(lrn14)[57:59]=column_names

# Sacling variables
lrn14$attitude=lrn14$attitude/10
# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)
# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)
# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra = rowMeans(strategic_columns)

# Select columns
selected_col=c('gender','age','attitude','deep','stra','surf','points')
learning2014=select(lrn14,one_of(selected_col))

# Exclude observations where the exam points variable is zero
learning2014=filter(learning2014,points!=0)

# Save data
write.table(learning2014,file='learning2014.txt',row.names=F,sep = '\t')
