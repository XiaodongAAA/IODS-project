#Created on 28.11.2017
#@author: Xiaodong Li
#This is the script for RStudio exercise 5 -- Data wrangling
#The data originates from the United Nations Development Programme. 
#

# Read the human development data
#human=read.table('
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
str(hd)
dim(hd)
summary(hd)

# Read the Gender inequality data
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
str(gii)
dim(gii)
summary(gii)

# Modify the column names of Human Development dataset and Gender inequality data
column_names_hd=c('HDI.Rank','Country','HDI','Life.Exp','Edu.Exp','Edu.Mean','GNI','GNI.Minus.Rank')
colnames(hd)=column_names_hd
column_names_gii=c('GII.Rank','Country','GII','Mat.Mor','Ado.Birth','Parli.F','Edu2.F','Edu2.M','Labo.F','Labo.M')
colnames(gii)=column_names_gii

# Calculate the ratio of female and male populations with secondary education and labour force participation in each country
gii=mutate(gii,Edu2.FM=Edu2.F/Edu2.M,Labo.FM=Labo.F/Labo.M)

# Join the two datasets
human=inner_join(hd,gii,by='Country')
dim(human)
summary(human)
