#Petteri Salo
#20.11.2018
#Creating a new dataset 

#2
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#3
str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

#4
