#' Created at 21:00 11.11.2017
#' 
#' @author:Xiaodong Li
#' 
#' The script for RStudio Exercise 2

library(dplyr)
# Read data
data=read.table('', sep='\t',header=TRUE)
# Structure of the data
str(data)
# Dimensions of the data
dim(data)
# The data has 183 obsversions and each observation has 60 variables. Nearly all the data are 'int' format except the 'gender' observation, which is a 'Factor'.

selected_col=c('gender','age','attitude','deep','stra','surf','points')
data_ana=select(data,one_of(selected_col))
