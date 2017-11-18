#Created on 18.11.2017
#@author: Xiaodong Li
#This is the script for RStudio exercise 3 -- Data wrangling
#The data is from the UCI Machine Learning Repository, Student Performance Data Set.
#

# Import packages
library(dplyr)

# Read data
math=read.csv('student-mat.csv',sep=';',header=T)
por=read.csv('student-por.csv',sep=';',header=T)

# Explore the data
str(math)
dim(math)
str(por)
dim(por)

# Join the two datasets together and explore the data
join_by = c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por = inner_join(math, por, by = join_by, suffix=c('.math','.por'))
str(math_por)
dim(math_por)

# Combine the two 'duplicated' answers
alc = select(math_por, one_of(join_by))
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]
for (column_name in notjoined_columns) {
  two_columns=select(math_por,starts_with(column_name))
  first_column=select(two_columns,1)[[1]]
  
  if(is.numeric(first_column)) {
    alc[column_name]=round(rowMeans(two_columns))
  } else {
    alc[column_name]=first_column
}
}

str(alc)
dim(alc)

# Take the average of the answers related to weekday and weekend alcohol consumption.
alc = mutate(alc, alc_use = (Dalc + Walc) / 2)
alc = mutate(alc, high_use = alc_use > 2)
glimpse(alc)

# Save the data
write.csv(alc,'alc.csv',row.names=F,quote=F)

