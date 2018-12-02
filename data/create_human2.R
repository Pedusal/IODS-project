#Petteri Salo
#20.11.2018
#Creating a new dataset
#Original datasets: http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv
#                   http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv

library(dplyr)
library(stringr)

## 

human <- read.table("data/human.txt")
str(human)
dim(human)

# Description of most 'human' dataset variables can be read from here:
# https://raw.githubusercontent.com/TuomoNieminen/Helsinki-Open-Data-Science/master/datasets/human_meta.txt
# In addition there are variables "Edu.Mean", which mean years of education,
# "GII.rank" and "GII" (=gender inequality index), 
# "HDI.rank" and "HDI" (=Human development index),
# and "GNI.rank.HDI.rank", which is the difference of those ranks.

#1
human <- mutate(human, GNI = str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric)

#2
# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM","Edu.Exp", "Life.Exp", 
          "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))


#3
# filter out all rows with NA values
human_ <- filter(human, complete.cases(human))

#4
# define the last indice we want to keep
last <- nrow(human_) - 7

# choose everything until the last 7 observations
human_ <- human_[1:last, ]


#5
# add countries as rownames
rownames(human_) <- human_$Country

# remove the Country variable
human_ <- select(human_, -Country)

setwd("C:/Users/Pedu/Documents/GitHub/IODS-project")
write.table(human_, "data/human2")

#################################
test <- read.table("data/human2") #Perfect!
test1 <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human2.txt",
                    sep = ",")
identical(test, test1)
