#Petteri Salo
#20.11.2018
#Creating a new dataset 

library(dplyr)

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
hdnames <- c("HDI.rank", "Country", "HDI", "Life.Exp", "Edu.Exp",
             "Edu.Mean", "GNI", "GNI.rank-HDI.rank")
giinames <- c("GII.rank", "Country", "GII", "Mat.Mor", "Ado.Birth",
              "Parli.F", "Edu2.F", "Edu2.M", "Labo.F", "Labo.M")
names(hd) <- hdnames
names(gii) <- giinames

#5
gii <- mutate(gii, Edu2.FM = Edu2.F / Edu2.M,
              Labo.FM = Labo.F / Labo.M)

#6
human <- inner_join(hd, gii, by = "Country")
human
setwd("C:/Users/Pedu/Documents/GitHub/IODS-project")
write.table(human, "data/human.txt")

## Test
test <- read.table("data/human.txt") #perfect!
